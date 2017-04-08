//
//  AutoLayoutObject.m
//  YWAutoLayoutDemo
//
//  Created by 王亚文 on 2017/4/6.
//  Copyright © 2017年 wyw. All rights reserved.
//

#import "AutoLayoutObject.h"
#import "UIView+AutoLayoutAttribute.h"


@implementation AutoLayoutObject

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        _viewItem  =nil;
        _attribute = NSLayoutAttributeNotAnAttribute;
        _relation = NSLayoutRelationEqual;
        _multiplier = 1.f;
        _constant = 0.f;
    }
    return self;
}

// 视图某属性等于某常量的约束（某UIView的height等于200）
// 在内部其实也是调用equalConstraintWithSecondLayoutObject:multiplier:constant这个方法，只不过此时secondItem为其superView
- (void)equalConstraintConstant:(CGFloat)constant
{
    UIView *superView = (UIView *)[self.viewItem superview];
    switch (self.attribute)
    {
        case NSLayoutAttributeTop:
        {
            [self equalConstraintWithSecondLayoutObject:superView.top multiplier:1.f constant:constant];
        }
            break;
        case NSLayoutAttributeBottom:
        {
            [self equalConstraintWithSecondLayoutObject:superView.bottom multiplier:1.f constant:constant];
        }
            break;
        case NSLayoutAttributeLeft:
        {
            [self equalConstraintWithSecondLayoutObject:superView.left multiplier:1.f constant:constant];
        }
            break;
        case NSLayoutAttributeRight:
        {
            [self equalConstraintWithSecondLayoutObject:superView.right multiplier:1.f constant:constant];
        }
            break;
        case NSLayoutAttributeCenterX:
        {
            [self equalConstraintWithSecondLayoutObject:superView.centerX multiplier:1.f constant:constant];
        }
            break;
        case NSLayoutAttributeCenterY:
        {
            [self equalConstraintWithSecondLayoutObject:superView.centerY multiplier:1.f constant:constant];
        }
            break;
        case NSLayoutAttributeLeading:
        {
            [self equalConstraintWithSecondLayoutObject:superView.leading multiplier:1.f constant:constant];
        }
            break;
        case NSLayoutAttributeTrailing:
        {
            [self equalConstraintWithSecondLayoutObject:superView.trailing multiplier:1.f constant:constant];
        }
            break;
        case NSLayoutAttributeBaseline:
        {
            [self equalConstraintWithSecondLayoutObject:superView.baseline multiplier:1.f constant:constant];
        }
            break;
        case NSLayoutAttributeNotAnAttribute:
        {
            [self equalConstraintWithSecondLayoutObject:superView.notAnAttribute multiplier:1.f constant:constant];
        }
            break;
            
            
        case NSLayoutAttributeWidth:
        case NSLayoutAttributeHeight:
        {
            [self equalConstraintWithSecondLayoutObject:nil multiplier:1.f constant:constant];
        }
            break;
            
        default:
            break;
    }
}

// 视图某属性小于等于某常量的约束（某UIView的height最大为200）
- (void)lessThanConstraintConstant:(CGFloat)constant
{
    
}

// 视图某属性大于等于某常量的约束（某UIView的height最小为200）
- (void)moreThanConstraintConstant:(CGFloat)constant
{
    
}




// aView某属性与bView某属性距离(相差)等于一个常量（aView的left与bView的right相差20）
- (void)equalConstraintWithSecondLayoutObject:(AutoLayoutObject *)secondLayoutObject
                                   multiplier:(CGFloat)multiplier
                                     constant:(CGFloat)constant
{
    // 找出aView和bView的最小公共父视图，约束最终是添加在该视图上的
    UIView *ancestorView = [self ancestorViewWithAView:self.viewItem
                                                 bView:secondLayoutObject.viewItem];
    if(ancestorView){
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self.viewItem
                                                                      attribute:self.attribute
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:secondLayoutObject.viewItem
                                                                      attribute:secondLayoutObject.attribute
                                                                     multiplier:multiplier
                                                                       constant:constant];
        [ancestorView addConstraint:constraint];
    }
}


- (void)lessThanConstraintWithSecondLayoutObject:(AutoLayoutObject *)secondLayoutObject
                                      multiplier:(CGFloat)multiplier
                                        constant:(CGFloat)constant
{
    
}


- (void)moreThanConstraintWithSecondLayoutObject:(AutoLayoutObject *)secondLayoutObject
                                      multiplier:(CGFloat)multiplier
                                        constant:(CGFloat)constant
{
    
}

// 返回 aView和bView两视图最小公共父视图。
- (UIView *)ancestorViewWithAView:(UIView *)aView bView:(UIView *)bView
{
    if(!aView){
        return nil;
    }
    
    if(!bView){
        // 结果为aView的父视图
        return [aView superview];
    }
    UIView *ancestorView;
    if([aView isDescendantOfView:bView]){
        ancestorView = bView;
    }else if([bView isDescendantOfView:aView]){
        ancestorView = aView;
    }else if([aView isDescendantOfView:bView.superview]){
        ancestorView = bView.superview;
    }else if([bView isDescendantOfView:aView.superview]){
        ancestorView = aView.superview;
    }
    
    return ancestorView;
}



@end
