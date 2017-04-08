//
//  UIView+AutoLayoutAttribute.m
//  YWAutoLayoutDemo
//
//  Created by 王亚文 on 2017/4/6.
//  Copyright © 2017年 wyw. All rights reserved.
//

#import "UIView+AutoLayoutAttribute.h"


@implementation UIView (AutoLayoutAttribute)

+ (id)create
{
    UIView *aView = [[self alloc] init];
    if(aView){
        aView.translatesAutoresizingMaskIntoConstraints = NO; // 使用AutoLayout时统一关闭autoresizingMask
    }
    
    return aView;
}

- (AutoLayoutObject *)left
{
    return [self autoLayoutObjectWithAttribute:NSLayoutAttributeLeft];
}

- (AutoLayoutObject *)right
{
    return [self autoLayoutObjectWithAttribute:NSLayoutAttributeRight];
}

- (AutoLayoutObject *)top
{
    return [self autoLayoutObjectWithAttribute:NSLayoutAttributeTop];
}

- (AutoLayoutObject *)bottom
{
    return [self autoLayoutObjectWithAttribute:NSLayoutAttributeBottom];
}

- (AutoLayoutObject *)leading
{
    return [self autoLayoutObjectWithAttribute:NSLayoutAttributeLeading];
}

-(AutoLayoutObject *)trailing
{
    return [self autoLayoutObjectWithAttribute:NSLayoutAttributeTrailing];
}

- (AutoLayoutObject *)baseline
{
    return [self autoLayoutObjectWithAttribute:NSLayoutAttributeBaseline];
}

- (AutoLayoutObject *)centerX
{
    return [self autoLayoutObjectWithAttribute:NSLayoutAttributeCenterX];
}

- (AutoLayoutObject *)centerY
{
    return [self autoLayoutObjectWithAttribute:NSLayoutAttributeCenterY];
}

- (AutoLayoutObject *)width
{
    return [self autoLayoutObjectWithAttribute:NSLayoutAttributeWidth];
}

- (AutoLayoutObject *)height
{
    return [self autoLayoutObjectWithAttribute:NSLayoutAttributeHeight];
}

- (AutoLayoutObject *)notAnAttribute
{
    return [self autoLayoutObjectWithAttribute:NSLayoutAttributeNotAnAttribute];
}

- (AutoLayoutObject *)autoLayoutObjectWithAttribute:(NSLayoutAttribute)attribute
{
    AutoLayoutObject *layoutObj = [AutoLayoutObject new];
    layoutObj.viewItem = self;
    layoutObj.attribute = attribute;
    
    return layoutObj;
}





@end
