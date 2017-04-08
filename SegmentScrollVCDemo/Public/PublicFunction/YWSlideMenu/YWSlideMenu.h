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

- (UIView *)ywSlideMenu:(YWSlideMenu *)slideMenu indexPath:(NSIndexPath *)indexPath;

@end

@interface YWSlideMenu : UIView

@property (nonatomic, strong)NSArray *itemsTitle;
@property (nonatomic, assign)CGSize   itemBarSize;
@property (nonatomic, weak)id<YWSlideMenuDelegate> ywSlideMenuDelegate;

@end


@interface SlideModel : NSObject

@property (nonatomic, copy)NSString         *itemTitle;
@property (nonatomic, assign)BOOL            isSelected;

@end
