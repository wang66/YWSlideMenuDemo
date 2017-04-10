//
//  YWSlideMenu.h
//  SegmentScrollVCDemo
//
//  Created by 王亚文 on 2017/4/8.
//  Copyright © 2017年 wyw. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YWSlideMenu;
@protocol YWSlideMenuDelegate <NSObject>

- (void)ywSlideMenu:(YWSlideMenu *)slideMenu selectedIndex:(NSInteger)selectedIndex;

- (UIView *)ywSlideMenu:(YWSlideMenu *)slideMenu index:(NSInteger)index;

@end

@interface YWSlideMenu : UIView

@property (nonatomic, strong)NSArray        *itemsTitle;
@property (nonatomic, assign)CGSize          itemBarSize;
@property (nonatomic, strong)UIColor        *barTextColor;
@property (nonatomic, strong)UIColor        *barTextHighlightColor;
@property (nonatomic, strong)UIFont         *barFont;
@property (nonatomic, strong)UIFont         *barHighlightFont;
@property (nonatomic, strong)UIColor        *barBgColor;
@property (nonatomic, strong)UIColor        *barHighlightBgColor;

@property (nonatomic, weak)id<YWSlideMenuDelegate> ywSlideMenuDelegate;

@end


@interface SlideModel : NSObject

@property (nonatomic, copy)NSString         *itemTitle;
@property (nonatomic, assign)BOOL            isSelected;

@end


@interface CellSettingModel : NSObject

@property (nonatomic, strong)UIColor            *textColor;
@property (nonatomic, strong)UIColor            *textHighlightColor;

@property (nonatomic, strong)UIFont             *font;
@property (nonatomic, strong)UIFont             *highlightFont;

@property (nonatomic, strong)UIColor            *bgColor;
@property (nonatomic, strong)UIColor            *highlightBgColor;

@end
