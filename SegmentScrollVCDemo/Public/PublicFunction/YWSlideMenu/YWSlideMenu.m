//
//  YWSlideMenu.m
//  SegmentScrollVCDemo
//
//  Created by 王亚文 on 2017/4/8.
//  Copyright © 2017年 wyw. All rights reserved.
//

#import "YWSlideMenu.h"
#import "BasicCell.h"
#define PDColor_Random              [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1]




@implementation SlideModel

//- (void)

@end




@interface YWSlideMenu ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)UITableView            *slideBarTabelView;
@property (nonatomic, strong)UITableView            *slideContentTableView;
@property (nonatomic, strong)NSMutableArray         *itemModelsArr;

@end


@implementation YWSlideMenu

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        
        _itemBarSize = CGSizeMake(65.f, 30.f);
        
        [self loadSlideMenuBar];
        [self loadSlodeMenuContentView];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.slideBarTabelView.frame = CGRectMake(0, 0, _itemBarSize.height, CGRectGetWidth(self.frame));
    self.slideBarTabelView.center = CGPointMake(CGRectGetWidth(self.frame)/2.f, _itemBarSize.height/2.f);
    self.slideBarTabelView.transform = CGAffineTransformMakeRotation(-M_PI_2); //旋转形变一定要给frame和center赋值后面
    
    self.slideContentTableView.frame = CGRectMake(0, CGRectGetHeight(self.slideBarTabelView.frame), CGRectGetHeight(self.frame)-CGRectGetHeight(self.slideBarTabelView.frame), CGRectGetWidth(self.frame));
    self.slideContentTableView.center = CGPointMake(CGRectGetWidth(self.frame)/2.f, (CGRectGetHeight(self.frame)+_itemBarSize.height+10.f)/2.f);
    self.slideContentTableView.transform = CGAffineTransformMakeRotation(-M_PI_2); //旋转形变一定要给frame和center赋值后面
}

- (void)loadSlideMenuBar
{
    self.slideBarTabelView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.slideBarTabelView.dataSource = self;
    self.slideBarTabelView.delegate = self;
    self.slideBarTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.slideBarTabelView.showsVerticalScrollIndicator = NO;
    [self addSubview:self.slideBarTabelView];
}

- (void)loadSlodeMenuContentView
{
    self.slideContentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.slideContentTableView.dataSource = self;
    self.slideContentTableView.delegate = self;
    self.slideContentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.slideContentTableView.pagingEnabled = YES;
    self.slideContentTableView.showsVerticalScrollIndicator = NO;
    [self addSubview:self.slideContentTableView];
}


#pragma mark - tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.itemModelsArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==self.slideBarTabelView)
    {
        static NSString *barCellId = @"barCellId";
        BasicCell *cell = [tableView dequeueReusableCellWithIdentifier:barCellId];
        if(cell==nil){
            cell = [[BasicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:barCellId];
            cell.transform = CGAffineTransformMakeRotation(M_PI_2);
        }
        
        SlideModel *slideModel = self.itemModelsArr[indexPath.row];
        [cell refreshContent:slideModel];
        return cell;
    }
    else
    {
        static NSString *contentCellId = @"contentCellId";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:contentCellId];
        if(cell==nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:contentCellId];
            cell.transform = CGAffineTransformMakeRotation(M_PI_2);
        }
        cell.backgroundColor = PDColor_Random;

        if([self.ywSlideMenuDelegate respondsToSelector:@selector(ywSlideMenu:indexPath:)]){
            UIView *cellView = [self.ywSlideMenuDelegate ywSlideMenu:self indexPath:indexPath];
            for(UIView *subView in cell.subviews)
            {
                [subView removeFromSuperview];
            }
            [cell addSubview:cellView];
            
        }
        return cell;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==self.slideBarTabelView){
        return _itemBarSize.width;
    }else if(tableView==self.slideContentTableView){
        return CGRectGetWidth(tableView.frame);
    }
    return CGRectGetWidth(self.frame);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(tableView==self.slideBarTabelView){
        BasicCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        NSInteger count = cell.frame.origin.y/_itemBarSize.width;
        self.slideContentTableView.contentOffset = CGPointMake(0, CGRectGetWidth(self.frame)*count);
        [self.slideBarTabelView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
        [self selectedTableView:tableView indexPath:indexPath];
    }
}

#pragma mark - scrollView delegate

// 当滑动减速时调用一次
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSIndexPath *indexPath = [self.slideContentTableView indexPathForRowAtPoint:scrollView.contentOffset];
    [self.slideBarTabelView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    [self selectedTableView:self.slideBarTabelView indexPath:indexPath];
}

- (void)selectedTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:self.itemModelsArr.count];
    for(int i=0; i<self.itemModelsArr.count; i++)
    {
        SlideModel *slideModel = self.itemModelsArr[i];
        slideModel.isSelected = NO;
        if(i==indexPath.row){
            slideModel.isSelected = YES;
        }
        
        [tempArr addObject:slideModel];
    }
    
    [self.itemModelsArr removeAllObjects];
    self.itemModelsArr = tempArr;
    
    [tableView reloadData];
    
}


#pragma mark - 属性修改

- (void)setItemsTitle:(NSArray *)itemsTitle
{
    _itemsTitle = itemsTitle;
    _itemModelsArr = [NSMutableArray arrayWithCapacity:itemsTitle.count];
    
    for(int i=0; i<itemsTitle.count; i++)
    {
        
        SlideModel *slideModel = [SlideModel new];
        slideModel.itemTitle = itemsTitle[i];
        slideModel.isSelected = NO;
        if(i==0){
            slideModel.isSelected = YES;
        }
        [_itemModelsArr addObject:slideModel];
    }
    
    [self.slideBarTabelView reloadData];
    [self.slideContentTableView reloadData];
}

- (void)setItemBarSize:(CGSize)itemBarSize
{
    _itemBarSize = itemBarSize;
    [self setNeedsLayout];
}

@end




