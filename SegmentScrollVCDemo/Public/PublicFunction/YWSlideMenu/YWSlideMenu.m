//
//  YWSlideMenu.m
//  SegmentScrollVCDemo
//
//  Created by 王亚文 on 2017/4/8.
//  Copyright © 2017年 wyw. All rights reserved.
//

#import "YWSlideMenu.h"
#define PDColor_Random              [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1]


@implementation SlideModel

//- (void)

@end


@interface CellSettingModel ()


@end


@implementation CellSettingModel

- (instancetype)init
{
    self = [super init];
    if(self){
        _textColor = RGB(60, 60, 90);
        _textHighlightColor = Color_White;
        
        _font = FONT(13);
        _highlightFont = FONT(15);
        
        _bgColor = RGB(177, 221, 174);
        _highlightBgColor = RGB(28, 215, 187);
    }
    return self;
}

@end




@interface BasicCell ()
@property (nonatomic, strong)UILabel            *titleLab;
@property (nonatomic, strong)SlideModel         *slideModel;
@end

@implementation BasicCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = Color_Clear;
        [self loadContentView];
    }
    
    return self;
}

- (void)loadContentView
{
    self.titleLab = [UILabel create];
    self.titleLab.font = FONT(14);
    self.titleLab.textColor = [UIColor blackColor];
    self.titleLab.backgroundColor = [UIColor clearColor];
    self.titleLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.titleLab];
    LAY(self.titleLab.centerX, self.centerX, 1, 0);
    LAY(self.titleLab.centerY, self.centerY, 1, 0);
}

+ (CGFloat)cellHeight
{
    return 60.f;
}

- (void)refreshContent:(SlideModel *)itemModel
{
    [self clearCellData];
    _slideModel = itemModel;
    self.titleLab.text = itemModel.itemTitle;
}

- (void)cellSettingConfig:(CellSettingModel *)cellSettingModel
{
    if(_slideModel.isSelected){
        self.titleLab.textColor = cellSettingModel.textHighlightColor;
        self.titleLab.font = cellSettingModel.highlightFont;
        self.backgroundColor = cellSettingModel.highlightBgColor;
    }else{
        self.titleLab.textColor = cellSettingModel.textColor;
        self.titleLab.font = cellSettingModel.font;
        self.backgroundColor = cellSettingModel.bgColor;
    }
}

- (void)clearCellData
{
    self.titleLab.text = @"";
    
}

@end





@interface YWSlideMenu ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong)UIView                 *moveSlide;
@property (nonatomic, strong)UITableView            *slideBarTabelView;
@property (nonatomic, strong)UITableView            *slideContentTableView;
@property (nonatomic, strong)NSMutableArray         *itemModelsArr;
@property (nonatomic, strong)CellSettingModel       *cellSettingModel;
@end


@implementation YWSlideMenu

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        _itemBarSize = CGSizeMake(65.f, 30.f);
        _cellSettingModel = [[CellSettingModel alloc] init];
        
//        [self loadMoveSlide];
        [self loadSlideMenuBar];
        [self loadSlideMenuContentView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.moveSlide.frame = CGRectMake(0, 0, _itemBarSize.width, _itemBarSize.height);
    
    self.slideBarTabelView.frame = CGRectMake(0, 0, _itemBarSize.height, CGRectGetWidth(self.frame));
    self.slideBarTabelView.center = CGPointMake(CGRectGetWidth(self.frame)/2.f, _itemBarSize.height/2.f);
    self.slideBarTabelView.transform = CGAffineTransformMakeRotation(-M_PI_2); //旋转形变一定要给frame和center赋值后面
    
    self.slideContentTableView.frame = CGRectMake(0, CGRectGetHeight(self.slideBarTabelView.frame), CGRectGetHeight(self.frame)-CGRectGetHeight(self.slideBarTabelView.frame), CGRectGetWidth(self.frame));
    self.slideContentTableView.center = CGPointMake(CGRectGetWidth(self.frame)/2.f, (CGRectGetHeight(self.frame)+_itemBarSize.height)/2.f);
    self.slideContentTableView.transform = CGAffineTransformMakeRotation(-M_PI_2); //旋转形变一定要给frame和center赋值后面
}

- (void)loadMoveSlide
{
    self.moveSlide = [[UIView alloc] initWithFrame:CGRectZero];
    self.moveSlide.backgroundColor = [UIColor orangeColor];
    [self addSubview:self.moveSlide];
}

- (void)loadSlideMenuBar
{
    self.slideBarTabelView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.slideBarTabelView.dataSource = self;
    self.slideBarTabelView.delegate = self;
    self.slideBarTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.slideBarTabelView.showsVerticalScrollIndicator = NO;
    self.slideBarTabelView.backgroundColor = Color_Clear;
    [self addSubview:self.slideBarTabelView];
}

- (void)loadSlideMenuContentView
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
        BasicCell *barCell = [tableView dequeueReusableCellWithIdentifier:barCellId];
        if(barCell==nil){
            barCell = [[BasicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:barCellId];
            barCell.transform = CGAffineTransformMakeRotation(M_PI_2);
        }
        SlideModel *slideModel = self.itemModelsArr[indexPath.row];
        [barCell refreshContent:slideModel];
        [barCell cellSettingConfig:_cellSettingModel];
        
        if([self.ywSlideMenuDelegate respondsToSelector:@selector(ywSlideMenu:cellForBarViewAtIndex:)]){
            UIView *barCellView = [self.ywSlideMenuDelegate ywSlideMenu:self cellForBarViewAtIndex:indexPath.row];
            barCellView.frame = CGRectMake(0, 0, _itemBarSize.width, _itemBarSize.height);
            for(UIView *subView in barCell.subviews){
                [subView removeFromSuperview];
            }
            [barCell refreshContent:slideModel];
            [barCell cellSettingConfig:_cellSettingModel];
            [barCell addSubview:barCellView];
        }
        
        return barCell;
    }
    else
    {
        static NSString *contentCellId = @"contentCellId";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:contentCellId];
        if(cell==nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:contentCellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.transform = CGAffineTransformMakeRotation(M_PI_2);
        }
        cell.backgroundColor = PDColor_Random;

        if([self.ywSlideMenuDelegate respondsToSelector:@selector(ywSlideMenu:cellForContentViewAtIndex:)]){
            UIView *cellView = [self.ywSlideMenuDelegate ywSlideMenu:self cellForContentViewAtIndex:indexPath.row];
            for(UIView *subView in cell.subviews){
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
//        NSLog(@"%d----%f-----", (int)indexPath.row,CGRectGetHeight(tableView.frame)); // 这里有个bug，最后一行的高度竟然是375，而不是正确的573
//        return CGRectGetHeight(tableView.frame);
        return Width_MainScreen;
        
    }
    return CGRectGetWidth(self.frame);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(tableView==self.slideBarTabelView){
        BasicCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        NSInteger count = cell.frame.origin.y/_itemBarSize.width;
        NSLog(@"❤❤❤❤❤❤❤❤%f", CGRectGetWidth(tableView.frame)*count);
        self.slideContentTableView.contentOffset = CGPointMake(0, CGRectGetWidth(tableView.frame)*count);
        [self.slideBarTabelView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
        [self selectedTableView:tableView indexPath:indexPath];
        
        if([self.ywSlideMenuDelegate respondsToSelector:@selector(ywSlideMenu:didSelectedIndex:)]){
            [self.ywSlideMenuDelegate ywSlideMenu:self didSelectedIndex:indexPath.row];
        }
    }
}

#pragma mark - scrollView delegate

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    CGFloat offset_x = _itemBarSize.width/Width_MainScreen*scrollView.contentOffset.y;
//    self.moveSlide.frame = CGRectMake(offset_x, 0, _itemBarSize.width, _itemBarSize.height);
//}
//
//- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
//{
//    int w = (int)Width_MainScreen;
//    
//    CGFloat offset_x = (int)scrollView.contentOffset.y%w;
//    self.moveSlide.frame = CGRectMake(offset_x, 0, _itemBarSize.width, _itemBarSize.height);
//}

// 当滑动减速时调用一次
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSIndexPath *indexPath = [self.slideContentTableView indexPathForRowAtPoint:scrollView.contentOffset];
    NSLog(@"%d", (int)indexPath.row);
    [self.slideBarTabelView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];

    [self selectedTableView:self.slideBarTabelView indexPath:indexPath];
    
    if([self.ywSlideMenuDelegate respondsToSelector:@selector(ywSlideMenu:didSelectedIndex:)]){
        [self.ywSlideMenuDelegate ywSlideMenu:self didSelectedIndex:indexPath.row];
    }
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

- (void)setItemsImage:(NSArray *)itemsImage
{
    _itemsImage = itemsImage;
    _itemModelsArr = [NSMutableArray arrayWithCapacity:itemsImage.count];
    
    for(int i=0; i<itemsImage.count; i++)
    {
        
        SlideModel *slideModel = [SlideModel new];
        slideModel.itemImage = itemsImage[i];
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

- (void)setBarTextColor:(UIColor *)barTextColor
{
    if(!barTextColor){
        return;
    }
    _barTextColor = barTextColor;
    _cellSettingModel.textColor = barTextColor;
    [self.slideBarTabelView reloadData];
}

- (void)setBarTextHighlightColor:(UIColor *)barTextHighlightColor
{
    if(!barTextHighlightColor){
        return;
    }
    _barTextHighlightColor = barTextHighlightColor;
    _cellSettingModel.textHighlightColor = barTextHighlightColor;
    [self.slideBarTabelView reloadData];
    
}

- (void)setBarFont:(UIFont *)barFont
{
    if(!barFont){
        return;
    }
    _barFont = barFont;
    _cellSettingModel.font = barFont;
    [self.slideBarTabelView reloadData];
}

- (void)setBarHighlightFont:(UIFont *)barHighlightFont
{
    if(!barHighlightFont){
        return;
    }
    _barHighlightFont = barHighlightFont;
    _cellSettingModel.highlightFont = barHighlightFont;
    [self.slideBarTabelView reloadData];
}

- (void)setBarBgColor:(UIColor *)barBgColor
{
    if(!barBgColor){
        return;
    }
    _barBgColor = barBgColor;
    _cellSettingModel.bgColor = barBgColor;
    [self.slideBarTabelView reloadData];
}

- (void)setBarHighlightBgColor:(UIColor *)barHighlightBgColor
{
    if(!barHighlightBgColor){
        return;
    }
    _barHighlightBgColor = barHighlightBgColor;
    _cellSettingModel.highlightBgColor = barHighlightBgColor;
    [self.slideBarTabelView reloadData];
}

@end




