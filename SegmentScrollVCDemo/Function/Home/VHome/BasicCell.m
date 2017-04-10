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

@property (nonatomic, strong)SlideModel         *slideModel;

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
    self.titleLab.backgroundColor = [UIColor clearColor];
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
    _slideModel = itemModel;
    self.titleLab.text = itemModel.itemTitle;
}

- (void)cellSettingConfig:(CellSettingModel *)cellSettingModel
{
    if(_slideModel.isSelected){
        self.titleLab.textColor = cellSettingModel.textHighlightColor;
        self.titleLab.font = cellSettingModel.highlightFont;
        self.backgroundColor = cellSettingModel.highlightBgColor;
    }else{
        self.titleLab.textColor = cellSettingModel.textColor;
        self.titleLab.font = cellSettingModel.font;
        self.backgroundColor = cellSettingModel.bgColor;
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
