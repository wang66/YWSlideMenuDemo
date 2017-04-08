//
//  AutoLayoutObject.h
//  YWAutoLayoutDemo
//
//  Created by 王亚文 on 2017/4/6.
//  Copyright © 2017年 wyw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define LAY(aViewAttr,bViewAttr, m, c)  [aViewAttr equalConstraintWithSecondLayoutObject:bViewAttr multiplier:m constant:c]

#define LAYC(aViewAttr, constant)   [aViewAttr equalConstraintConstant:constant]


@interface AutoLayoutObject : NSObject

@property (nonatomic, strong)id                     viewItem; // 某视图
@property (nonatomic, assign)NSLayoutAttribute      attribute; // 属性 top/bottom/left/right/centerX/centerY等
@property (nonatomic, assign)NSLayoutRelation       relation; // = 、> 、<
@property (nonatomic, assign)CGFloat                multiplier; // 伸缩形变量
@property (nonatomic, assign)CGFloat                constant; // 常量，代表长度或距离

// 视图某属性等于某常量的约束（某UIView的height等于200）
- (void)equalConstraintConstant:(CGFloat)constant;

// 视图某属性小于等于某常量的约束（某UIView的height最大为200）
- (void)lessThanConstraintConstant:(CGFloat)constant;

// 视图某属性大于等于某常量的约束（某UIView的height最小为200）
- (void)moreThanConstraintConstant:(CGFloat)constant;



// aView某属性与bView某属性距离(相差)等于一个常量（aView的left与bView的right相差20）
- (void)equalConstraintWithSecondLayoutObject:(AutoLayoutObject *)secondLayoutObject
                                   multiplier:(CGFloat)multiplier
                                     constant:(CGFloat)constant;


- (void)lessThanConstraintWithSecondLayoutObject:(AutoLayoutObject *)secondLayoutObject
                                      multiplier:(CGFloat)multiplier
                                        constant:(CGFloat)constant;


- (void)moreThanConstraintWithSecondLayoutObject:(AutoLayoutObject *)secondLayoutObject
                                      multiplier:(CGFloat)multiplier
                                        constant:(CGFloat)constant;


@end
