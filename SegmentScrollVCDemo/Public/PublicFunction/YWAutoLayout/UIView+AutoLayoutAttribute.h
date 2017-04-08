//
//  UIView+AutoLayoutAttribute.h
//  YWAutoLayoutDemo
//
//  Created by 王亚文 on 2017/4/6.
//  Copyright © 2017年 wyw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AutoLayoutObject.h"

@interface UIView (AutoLayoutAttribute)


/**
 自动布局时，取代new方法。在create内部关闭了

 @return return value description
 */
+ (id)create;

- (AutoLayoutObject *)left;
- (AutoLayoutObject *)right;
- (AutoLayoutObject *)top;
- (AutoLayoutObject *)bottom;

- (AutoLayoutObject *)leading;
- (AutoLayoutObject *)trailing;
- (AutoLayoutObject *)baseline;

- (AutoLayoutObject *)centerX;
- (AutoLayoutObject *)centerY;

- (AutoLayoutObject *)width;
- (AutoLayoutObject *)height;
- (AutoLayoutObject *)notAnAttribute;

@end
