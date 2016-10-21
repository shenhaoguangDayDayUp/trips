//
//  SearchDetailTableViewCell.m
//  Travel
//
//  Created by 申浩光 on 15/10/8.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "SearchDetailTableViewCell.h"

@implementation SearchDetailTableViewCell

- (void)dealloc {
    [_backView release];
    [_showImg release];
    [_title release];
    [_dateLabel release];
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = kBackColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _backView = [[UIView alloc] initWithFrame:(CGRectMake(12, 5, kWidth - 24, 100.0 / kAutoHight))];
        _backView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_backView];
        
        _showImg = [[UIImageView alloc] initWithFrame:(CGRectMake(0, 0, _backView.bounds.size.height - 5,  _backView.bounds.size.height - 5))];
        _showImg.backgroundColor = kBackColor;
//        _showImg.contentMode = UIViewContentModeScaleAspectFill;
        [_backView addSubview:_showImg];
        
        UIImageView *buttomImg = [[UIImageView alloc] initWithFrame:(CGRectMake(0, _backView.bounds.size.height - 5, _backView.bounds.size.width, 5))];
        buttomImg.image = [UIImage imageNamed:@"journey_cell_shadow"];
        buttomImg.alpha = 0.4;
        [_backView addSubview:buttomImg];
        [buttomImg release];
        
        _title = [[UILabel alloc] initWithFrame:(CGRectMake(_showImg.bounds.size.width + 10, _showImg.frame.origin.y + 15, _backView.bounds.size.width - _showImg.bounds.size.width - 10 - 10, 15))];
        _title.textColor = [UIColor colorWithRed:1.000 green:0.205 blue:0.278 alpha:1.000];
        _title.font = [UIFont systemFontOfSize:18.0];
        [_backView addSubview:_title];
        
        
        _dateLabel = [[UILabel alloc] initWithFrame:(CGRectMake(_title.frame.origin.x, _title.frame.origin.y + _title.bounds.size.height + 20, _title.bounds.size.width, 10))];
        _dateLabel.textColor = [UIColor grayColor];
        _dateLabel.font = [UIFont systemFontOfSize:14.0];
        [_backView addSubview:_dateLabel];
        
        UIImageView *arrow = [[UIImageView alloc] initWithFrame:(CGRectMake(_backView.bounds.size.width - 10, 0, 10, 15))];
        arrow.image = [UIImage imageNamed:@"poi_arrow_icon@2x"];
        arrow.center = CGPointMake(_backView.bounds.size.width - 5, _backView.bounds.size.height / 2);
        [_backView addSubview:arrow];
        [arrow release];
    }
    return self;
}

- (void)setValueWithModel:(SearchResultModel *)model {
    
    [_showImg sd_setImageWithURL:[NSURL URLWithString:model.cover_image_default] placeholderImage:[UIImage imageNamed:@"trip_edit_empty_content"]];
    
    _title.text = model.name;
    
    _dateLabel.text = [NSString stringWithFormat:@"%@天", model.day_count];
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
