//
//  ScrollSegmentViewController.m
//  SegmentScrollVCDemo
//
//  Created by 王亚文 on 2017/4/8.
//  Copyright © 2017年 wyw. All rights reserved.
//

#import "ScrollSegmentViewController.h"
#import "YWSlideMenu.h"

#define PDColor_Random              [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1]

@interface ScrollSegmentViewController ()<YWSlideMenuDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)UITableView        *firstTableView;
@property (nonatomic, strong)UITableView        *secondTableView;


@end

@implementation ScrollSegmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadTitleView];
    [self loadContentView];
    
}

- (void)loadTitleView
{
    self.titleLabel.text = @"YWSlideMenu";
    self.leftButton.hidden = YES;
}

- (void)loadContentView
{
    YWSlideMenu *slideMenu = [[YWSlideMenu alloc] initWithFrame:self.contentView.bounds];
    slideMenu.itemsTitle = @[@"头条", @"娱乐", @"体育", @"财经", @"科技", @"时尚", @"直播", @"热点", @"图片", @"新闻"];
    slideMenu.ywSlideMenuDelegate = self;
    [self.contentView addSubview:slideMenu];
}

- (UIView *)ywSlideMenu:(YWSlideMenu *)slideMenu indexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0)
    {
        _firstTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Width_MainScreen, Height_MainScreen-30.f) style:UITableViewStylePlain];
        _firstTableView.dataSource = self;
        _firstTableView.delegate = self;
        _firstTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _firstTableView.tableFooterView = [[UIView alloc] init];
        return _firstTableView;
    }
    else if(indexPath.row==1)
    {
        _secondTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Width_MainScreen, Height_MainScreen-30.f) style:UITableViewStylePlain];
        _secondTableView.dataSource = self;
        _secondTableView.delegate = self;
        _secondTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _secondTableView.tableFooterView = [[UIView alloc] init];
        return _secondTableView;
    }
    else{
        UIView *emptyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width_MainScreen, Height_MainScreen-30.f)];
        emptyView.backgroundColor = PDColor_Random;
        return emptyView;
    }
    
    return nil;

}

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
