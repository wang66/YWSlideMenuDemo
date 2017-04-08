//
//  BasicCell.m
//  SegmentScrollVCDemo
//
//  Created by 王亚文 on 2017/4/8.
//  Copyright © 2017年 wyw. All rights reserved.
//

#import "BasicCell.h"
#import "YWAutoLayout.h"
#import "YWSlideMenu.h"

@interface BasicCell ()

@property (nonatomic, strong)UILabel            *titleLab;

@end

@implementation BasicCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self loadContentView];
    }
    
    return self;
}

- (void)loadContentView
{
    self.titleLab = [UILabel create];
    self.titleLab.font = FONT(14);
    self.titleLab.textColor = [UIColor blackColor];
    self.titleLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.titleLab];
    LAY(self.titleLab.centerX, self.centerX, 1, 0);
    LAY(self.titleLab.centerY, self.centerY, 1, 0);
}

+ (CGFloat)cellHeight
{
    return 60.f;
}

- (void)refreshContent:(SlideModel *)itemModel
{
    [self clearCellData];
    self.titleLab.text = itemModel.itemTitle;
    if(itemModel.isSelected){
        self.titleLab.textColor = [UIColor orangeColor];
        self.titleLab.font = FONT(16);
    }else{
        self.titleLab.textColor = [UIColor blackColor];
        self.titleLab.font = FONT(14);
    }
}

- (void)clearCellData
{
    self.titleLab.text = @"";

}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
