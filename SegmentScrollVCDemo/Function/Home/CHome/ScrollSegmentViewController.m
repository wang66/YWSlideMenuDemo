//
//  ScrollSegmentViewController.m
//  SegmentScrollVCDemo
//
//  Created by 王亚文 on 2017/4/8.
//  Copyright © 2017年 wyw. All rights reserved.
//

#import "ScrollSegmentViewController.h"
#import "YWSlideMenu.h"

#define Height_SlideMenu 30.f

@interface ScrollSegmentViewController ()<YWSlideMenuDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)UITableView        *firstTableView;
@property (nonatomic, strong)UITableView        *secondTableView;
@property (nonatomic ,strong)NSMutableArray     *barTitleItems;
@property (nonatomic ,strong)NSMutableArray     *barImageItems;
@property (nonatomic, strong)YWSlideMenu        *slideMenu;


@end

@implementation ScrollSegmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadTitleView];
    [self loadContentView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    _barTitleItems = [NSMutableArray arrayWithArray:@[@"头条", @"娱乐", @"体育", @"财经", @"科技", @"时尚", @"直播", @"热点", @"图片", @"新闻"]];
    _barImageItems = [NSMutableArray arrayWithArray:@[IMAGE(@"01.png"),IMAGE(@"02.png"),IMAGE(@"03.png"),IMAGE(@"04.png"),IMAGE(@"05.png"),IMAGE(@"06.png"),IMAGE(@"07.png"),IMAGE(@"08.png"),IMAGE(@"09.png"),IMAGE(@"10.png")]];
    _slideMenu.itemBarSize = CGSizeMake(70, Height_SlideMenu);
    
    _slideMenu.itemsTitle = _barTitleItems;
    _slideMenu.itemsImage = _barImageItems;
}

- (void)loadTitleView
{
    self.titleLabel.text = @"YWSlideMenu";
    self.leftButton.hidden = YES;
}

- (void)loadContentView
{
    _slideMenu = [[YWSlideMenu alloc] initWithFrame:self.contentView.bounds];
//    _slideMenu.itemsTitle = _barTitleItems;
//    _slideMenu.itemsImage =
    _slideMenu.itemBarSize = CGSizeMake(60, Height_SlideMenu); //
    _slideMenu.ywSlideMenuDelegate = self;
    [self.contentView addSubview:_slideMenu];
}

- (UIView *)ywSlideMenu:(YWSlideMenu *)slideMenu cellForBarViewAtIndex:(NSInteger)index
{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 10)];
    [btn setTitle:_barTitleItems[index] forState:UIControlStateNormal];
    [btn setImage:_barImageItems[index] forState:UIControlStateNormal];
    btn.titleLabel.font = FONT(14);
    btn.userInteractionEnabled = NO;
    
    return btn;
}

- (UIView *)ywSlideMenu:(YWSlideMenu *)slideMenu cellForContentViewAtIndex:(NSInteger)index
{
    if(index==0)
    {
        if(!_firstTableView){
            _firstTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Width_MainScreen, Height_MainScreen-Height_SlideMenu-64.f) style:UITableViewStylePlain];
            _firstTableView.dataSource = self;
            _firstTableView.delegate = self;
            _firstTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            _firstTableView.tableFooterView = [[UIView alloc] init];
        }
        return _firstTableView;
    }
    else if(index==1)
    {
        if(!_secondTableView){
            _secondTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Width_MainScreen, Height_MainScreen-Height_SlideMenu-64.f) style:UITableViewStylePlain];
            _secondTableView.dataSource = self;
            _secondTableView.delegate = self;
            _secondTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            _secondTableView.tableFooterView = [[UIView alloc] init];
        }
        
        return _secondTableView;
    }
    else{
    
        UIView *emptyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width_MainScreen, Height_MainScreen-Height_SlideMenu-64.f)];
        emptyView.backgroundColor = Color_Random;
        return emptyView;
    }
    
    return nil;

}

- (void)ywSlideMenu:(YWSlideMenu *)slideMenu didSelectedIndex:(NSInteger)selectedIndex
{
    NSLog(@"❤---选中了第%d项", (int)selectedIndex);
}



#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView==_firstTableView){
        return 20;
    }else if(tableView==_secondTableView){
        return 5;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==_firstTableView)
    {
        static NSString *firstTableViewCell = @"firstTableViewCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:firstTableViewCell];
        if(cell==nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:firstTableViewCell];
        }
        
        cell.textLabel.text = @"我自横刀向天笑，去留肝胆两昆仑。仰天大笑出门去，我辈岂是蓬蒿人";
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.font = FONT(12);
        return cell;
    }
    else if(tableView==_secondTableView)
    {
        static NSString *secondTableViewCell = @"secondTableViewCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:secondTableViewCell];
        if(cell==nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:secondTableViewCell];
        }
        
        cell.textLabel.text = @"wang66";
        cell.detailTextLabel.text = @"18693133051";
        return cell;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.f;
}

@end
