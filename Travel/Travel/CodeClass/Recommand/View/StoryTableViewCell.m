//
//  StoryTableViewCell.m
//  Travel
//
//  Created by 申浩光 on 15/9/24.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "StoryTableViewCell.h"

@implementation StoryTableViewCell

- (void)dealloc {
    [_showImg release];
    [_showLabel release];
    [super dealloc];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = kBackColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUpShowContent];
    }
    return self;
}


- (void)setUpShowContent {
    // 循环创建展示图片
    _showImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, kWidth - 20, 100)];
    _showImg.contentMode = UIViewContentModeScaleAspectFill;
    _showImg.clipsToBounds = YES;
    _showImg.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:_showImg];
    
    // 创建内容
    _showLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10 + _showImg.frame.origin.y + _showImg.bounds.size.height, kWidth - 20, 10)];
    _showLabel.font = [UIFont systemFontOfSize:15.0];
    _showLabel.numberOfLines = 0;
    [self.contentView addSubview:_showLabel];
}

- (void)setValueWithModel:(DetailList *)model {
    
    NSString *height = [NSString stringWithFormat:@"%@", model.photo_height];
    NSString *width = [NSString stringWithFormat:@"%@", model.photo_width];
    _showImg.frame = CGRectMake(10, 10, kWidth - 20, (kWidth - 20) * [height floatValue] / [width floatValue]);

    [_showImg sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:[UIImage imageNamed:@"poi_bg_placeholder@2x"]];
    
    UIImageView *arrow = [[UIImageView alloc] initWithFrame:(CGRectMake(30, _showImg.frame.origin.y + _showImg.bounds.size.height - 5, 12, 5))];
    arrow.image = [UIImage imageNamed:@"up_triangle"];
    [self.contentView addSubview:arrow];

    _showLabel.frame = CGRectMake(10, 10 + _showImg.frame.origin.y + _showImg.bounds.size.height, kWidth - 20, 10);
    _showLabel.text = model.text;
    [_showLabel sizeToFit];
    [arrow release];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
