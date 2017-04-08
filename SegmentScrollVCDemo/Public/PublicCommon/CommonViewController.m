//
//  CommonViewController.m
//  0213Demo
//
//  Created by ZJCS on 17/2/13.
//  Copyright © 2017年 wyw. All rights reserved.
//

#import "CommonViewController.h"

@interface CommonViewController ()

@end

@implementation CommonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self setup];
	
	[self initBackGroundView];
	[self initTitleView];
	[self initContentView];
	[self initLoadingView];
//	[self initWindowView];
	
	self.loadingView.userInteractionEnabled = NO;
//	self.windowView.userInteractionEnabled = NO;
	
}

- (void)setup
{
	self.edgesForExtendedLayout = UIRectEdgeNone;
	self.extendedLayoutIncludesOpaqueBars = NO;
	self.automaticallyAdjustsScrollViewInsets = NO;
	
	self.navigationController.navigationBar.hidden = YES;
	self.width = [UIScreen mainScreen].bounds.size.width;
	self.height = [UIScreen mainScreen].bounds.size.height;
	self.view.backgroundColor = [UIColor whiteColor];
}

- (void)initBackGroundView
{
	self.backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
	[self.view addSubview:self.backGroundView];
}

- (void)initTitleView
{
	self.titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 64.f)];
	[self.view addSubview:self.titleView];
	
	self.leftButton = [[UIImageView alloc] initWithFrame:CGRectMake(15.f, 30.f, 25.f, 25.f)];
	self.leftButton.image = [UIImage imageNamed:@"back"];
	self.leftButton.contentMode = UIViewContentModeScaleAspectFit;
	UITapGestureRecognizer *leftTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftButtonClick)];
	self.leftButton.userInteractionEnabled = YES;
	[self.leftButton addGestureRecognizer:leftTapGesture];
	[self.titleView addSubview:self.leftButton];
	
	self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width-120.f, 44.f)];
	self.titleLabel.center = CGPointMake(self.titleView.center.x, self.titleView.center.y+11.f);
	self.titleLabel.textAlignment = NSTextAlignmentCenter;
	self.titleLabel.font = [UIFont boldSystemFontOfSize:16];
	[self.titleView addSubview:self.titleLabel];
	
	self.rightButton = [[UIImageView alloc] initWithFrame:CGRectMake(self.width-25.f-15.f, 30.f, 25.f, 25.f)];
	self.rightButton.image = [UIImage imageNamed:@"setting"];
	self.rightButton.contentMode = UIViewContentModeScaleAspectFit;
	UITapGestureRecognizer *rightTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightButtonClick)];
	self.rightButton.userInteractionEnabled = YES;
	[self.rightButton addGestureRecognizer:rightTapGesture];
	[self.titleView addSubview:self.rightButton];
	
	self.titleBottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, 63.7f, self.width, 0.3f)];
	self.titleBottomLine.backgroundColor = [UIColor lightGrayColor];
	[self.titleView addSubview:self.titleBottomLine];

}

- (void)initContentView
{
	self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 64.f, self.width, self.height-64.f)];
	[self.view addSubview:self.contentView];
}

- (void)initLoadingView
{
	self.loadingView = [[UIView alloc] initWithFrame:CGRectMake(0, 64.f, self.width, self.height-64.f)];
	[self.view addSubview:self.loadingView];
}

//- (void)initWindowView
//{
//	self.windowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
//	[self.view addSubview:self.windowView];
//}

- (void)leftButtonClick
{
	[self popViewControllerAnimated:YES];
}

- (void)rightButtonClick
{
	
}

- (void)setCenterTitleView:(UIView *)centerView
{
    if(self.titleLabel){
        [self.titleLabel removeFromSuperview];
    }
    centerView.center = CGPointMake(self.titleView.center.x, self.titleView.center.y+11.f);
    [self.titleView addSubview:centerView];
}










- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)anmiated
{
	[self.navigationController pushViewController:viewController animated:anmiated];
}

- (void)popViewControllerAnimated:(BOOL)anmiated
{
	[self.navigationController popViewControllerAnimated:anmiated];
}

- (void)popToRootViewControllerAnimated:(BOOL)animated
{
	[self.navigationController popToRootViewControllerAnimated:animated];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
