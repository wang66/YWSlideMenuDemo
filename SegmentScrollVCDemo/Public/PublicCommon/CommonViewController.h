//
//  CommonViewController.h
//  0213Demo
//
//  Created by ZJCS on 17/2/13.
//  Copyright © 2017年 wyw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonViewController : UIViewController

@property (nonatomic, assign)CGFloat		width; // Screen's width
@property (nonatomic, assign)CGFloat		height; // Screen's height

//@property (nonatomic, strong)UIView			*windowView; // highest (0, 0, width, height)
@property (nonatomic, strong)UIView			*loadingView; // higher (0, 64, width, height-64)
@property (nonatomic, strong)UIView			*titleView; // normal	(0, 0, width, 64)
@property (nonatomic, strong)UIView			*contentView; // normal (0, 64, width, height-64)
@property (nonatomic, strong)UIView			*backGroundView; // low (0, 0, width, height)

@property (nonatomic, strong)UILabel		*titleLabel;
@property (nonatomic, strong)UIImageView	*leftButton;
@property (nonatomic, strong)UIImageView	*rightButton;
@property (nonatomic, strong)UIView			*titleBottomLine;

- (void)setup;

- (void)initBackGroundView;

- (void)initTitleView;

- (void)initContentView;

- (void)initLoadingView;

//- (void)initWindowView;


- (void)leftButtonClick;

- (void)rightButtonClick;

- (void)setCenterTitleView:(UIView *)centerView;

@end
