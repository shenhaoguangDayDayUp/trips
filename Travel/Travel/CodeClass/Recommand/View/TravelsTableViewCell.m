//
//  TravelsTableViewCell.m
//  Travel
//
//  Created by 申浩光 on 15/9/25.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "TravelsTableViewCell.h"

@implementation TravelsTableViewCell

- (void)dealloc {
    [_backView release];
    [_showImg release];
    [_lineImg release];
    [_buttomImg release];
    [_clockImg release];
    [_showImg release];
    [_dateLabel release];
    [_date release];
    [_arrowImg release];
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = kBackColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _lineImg = [[UIImageView alloc] initWithFrame:(CGRectMake(5, 0, 300.0 / kAutoWidth, 30.0 / kAutoWidth))];
        _lineImg.image = [UIImage imageNamed:@"journey_table_header"];
        [self.contentView addSubview:_lineImg];
        
        _date = [[UILabel alloc] initWithFrame:(CGRectMake(_lineImg.frame.origin.x + 40, _lineImg.frame.origin.y + 3, kWidth - 60, 10))];
        _date.textColor = kBrownColor;
        _date.text = @"第1天 09月04日";
        _date.font = [UIFont boldSystemFontOfSize:13.0];
        [self.contentView addSubview:_date];
        
        _backView = [[UIView alloc] initWithFrame:(CGRectMake(12, _lineImg.frame.origin.y + _lineImg.bounds.size.height, kWidth - 24, 350))];
        _backView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_backView];
        
        _buttomImg = [[UIImageView alloc] initWithFrame:(CGRectMake(0, _backView.bounds.size.height, kWidth - 24, 5))];
        _buttomImg.image = [UIImage imageNamed:@"journey_cell_shadow"];
        _buttomImg.alpha = 0.4;
        [_backView addSubview:_buttomImg];
        
        _showImg = [[UIImageView alloc] initWithFrame:(CGRectMake(0, 0, kWidth - 24, 220))];
        _showImg.userInteractionEnabled = YES;
        _showImg.clipsToBounds = YES;
        _showImg.contentMode = UIViewContentModeScaleAspectFill;
        [_backView addSubview:_showImg];
        
        _arrowImg = [[UIImageView alloc] initWithFrame:(CGRectMake(0, _showImg.bounds.size.height - 5, _buttomImg.bounds.size.width, 5))];
        _arrowImg.image = [UIImage imageNamed:@"feedcell_photo_cover"];
        [_showImg addSubview:_arrowImg];
        
        
        _showLabel = [[UILabel alloc] initWithFrame:(CGRectMake(12, _showImg.bounds.size.height + 5, kWidth - 48, 15))];
        _showLabel.text = @"出站台前合影一张，少一人";
        _showLabel.font = [UIFont systemFontOfSize:14.0];
        _showLabel.numberOfLines = 0;
        [_backView addSubview:_showLabel];
        
        _clockImg = [[UIImageView alloc] initWithFrame:(CGRectMake(12, _showLabel.bounds.size.height + _showLabel.frame.origin.y + 10, 15, 15))];
        _clockImg.image = [UIImage imageNamed:@"clock_gray_big"];
        [_backView addSubview:_clockImg];
        
        _dateLabel = [[UILabel alloc] initWithFrame:(CGRectMake(_clockImg.frame.origin.x + _clockImg.bounds.size.width + 5, _clockImg.frame.origin.y, kWidth - 50, 10))];
        _dateLabel.text = @"1025-09-04 19:42";
        _dateLabel.font = [UIFont systemFontOfSize:12.0];
        _dateLabel.textColor = [UIColor grayColor];
        [_dateLabel sizeToFit];
        [_backView addSubview:_dateLabel];
    }
    return self;
}

- (void)setValueWithModel:(DaysModel *)model {
    
    
    if (model.date != nil) {
        NSString *dates = [model.date stringByReplacingOccurrencesOfString:@"-" withString:@"月"];
        
        _date.text = [NSString stringWithFormat:@"第%@天 %@日", model.day, [dates substringWithRange:NSMakeRange(5, 5)]];
        
        _lineImg.image = [UIImage imageNamed:@"journey_table_header"];
    } 
    

    if (model.photo_info != nil) {
        NSString *w = [NSString stringWithFormat:@"%@", model.photo_info[@"w"]];
        NSString *h = [NSString stringWithFormat:@"%@", model.photo_info[@"h"]];
        
        
        CGFloat imgHeight = (kWidth - 24) * [h floatValue] / [w floatValue];
        
        _showImg.frame = CGRectMake(0, 0, kWidth - 24, imgHeight);
        [_showImg sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:[UIImage imageNamed:@"poi_bg_placeholder@2x"]];
        
        
        _arrowImg.frame = CGRectMake(0, imgHeight - 5, _buttomImg.bounds.size.width, 5);
        
        
        _showLabel.frame = CGRectMake(12, imgHeight + 5, kWidth - 48, 15);
        _showLabel.text = model.text;
        [_showLabel sizeToFit];
        
        
        _clockImg.frame = CGRectMake(12, _showLabel.bounds.size.height + _showLabel.frame.origin.y + 10, 15, 15);
        
        _dateLabel.frame = CGRectMake(_clockImg.frame.origin.x + _clockImg.bounds.size.width + 5, _clockImg.frame.origin.y + 3, kWidth - 50, 10);
        _dateLabel.text = model.date;
        
        _backView.frame = CGRectMake(12, _lineImg.frame.origin.y + _lineImg.bounds.size.height, kWidth - 24, _clockImg.frame.origin.y + _clockImg.bounds.size.height + 10);
        
        _buttomImg.frame = CGRectMake(0, _backView.bounds.size.height, kWidth - 24, 5);
    }
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
