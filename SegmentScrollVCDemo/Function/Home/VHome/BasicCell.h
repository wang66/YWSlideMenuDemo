//
//  BasicCell.h
//  SegmentScrollVCDemo
//
//  Created by 王亚文 on 2017/4/8.
//  Copyright © 2017年 wyw. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SlideModel;
@class CellSettingModel;
@interface BasicCell : UITableViewCell
+ (CGFloat)cellHeight;
- (void)refreshContent:(SlideModel *)itemModel;
- (void)cellSettingConfig:(CellSettingModel *)cellSettingModel;
@end
