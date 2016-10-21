//
//  SpecialTopicCollectionViewCell.m
//  Travel
//
//  Created by 申浩光 on 15/9/19.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "SpecialTopicCollectionViewCell.h"

@implementation SpecialTopicCollectionViewCell

- (void)dealloc {
    [_showImgView release];
    [_titleLabel release];
    [_lineView release];
    [_timeLabel release];
    [_locationLabel release];
    [_userImgView release];
    [_userLabel release];
    [_shadowImg release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat x = kWidth / (375.0 / 20);
        CGFloat y = kWidth / (375.0 / 20);
        self.height = self.frame.size.height;
        self.width = self.frame.size.width;
        
        self.backgroundColor = [UIColor colorWithRed:0.969 green:0.949 blue:0.902 alpha:1.000];
        
        _showImgView = [[UIImageView alloc] initWithFrame:(CGRectMake(0, 0, _width, _height))];
        _showImgView.backgroundColor = [UIColor colorWithRed:0.882 green:0.839 blue:0.729 alpha:1.000];
        _showImgView.layer.masksToBounds = YES;
        _showImgView.layer.cornerRadius = 5;
        _showImgView.clipsToBounds = YES;
        _showImgView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_showImgView];
        
        _shadowImg = [[UIImageView alloc] initWithFrame:(CGRectMake(0, 0, _width, _height))];
        _shadowImg.image = [UIImage imageNamed:@"phone_desc_tripcell_shadow"];
        _shadowImg.layer.masksToBounds = YES;
        _shadowImg.layer.cornerRadius = 5;
        [self addSubview:_shadowImg];
        
        _titleLabel = [[UILabel alloc] initWithFrame:(CGRectMake(x, y, _width - 2*x, 20))];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
        [_shadowImg addSubview:_titleLabel];
        
        _lineView = [[UIView alloc] initWithFrame:(CGRectMake(x, _titleLabel.frame.origin.y + (kWidth / (375.0 / 30)), y / 4, x + (kWidth / (375.0 / 10))))];
        _lineView.backgroundColor = [UIColor colorWithRed:0.886 green:0.2588 blue:0.3411 alpha:1];
        _lineView.layer.masksToBounds = YES;
        _lineView.layer.cornerRadius = 1.5;
        [_shadowImg addSubview:_lineView];
        
        _timeLabel = [[UILabel alloc] initWithFrame:(CGRectMake(_lineView.frame.origin.x + (kWidth / (375.0 / 15)), _lineView.frame.origin.y - (kWidth / (375.0 / 2)), _titleLabel.frame.size.width, (kWidth / (375.0 / 10))))];
        _timeLabel.textColor = [UIColor whiteColor];
        _timeLabel.font = [UIFont systemFontOfSize:12.0];
        [_shadowImg addSubview:_timeLabel];
        
        _locationLabel = [[UILabel alloc] initWithFrame:(CGRectMake(_timeLabel.frame.origin.x, _timeLabel.frame.origin.y + (kWidth / (375.0 / 20)), _titleLabel.frame.size.width, (kWidth / (375.0 / 10))))];
        _locationLabel.textColor = [UIColor whiteColor];
        _locationLabel.font = [UIFont systemFontOfSize:12.0];
        [_shadowImg addSubview:_locationLabel];
        
        _userImgView = [[UIImageView alloc] initWithFrame:CGRectMake(x, _height - (kWidth / (375.0 / 45)), 30, 30)];
        _userImgView.layer.masksToBounds = YES;
        _userImgView.layer.cornerRadius = 15;
        _userImgView.backgroundColor = kBrownColor;
        [_shadowImg addSubview:_userImgView];
        
        _userLabel = [[UILabel alloc] initWithFrame:(CGRectMake(x + 30 + 10, _userImgView.frame.origin.y, 200, 30))];
        _userLabel.textColor = [UIColor whiteColor];
        _userLabel.font = [UIFont systemFontOfSize:12.0];
        [_shadowImg addSubview:_userLabel];
        
        
    }
    
    return self;
}

- (void)setValueWithModel:(EveryDayModel *)model user:(UserInfo *)user {
    
    _titleLabel.text = model.name;
    
    NSArray *url = [model.cover_image_w640 componentsSeparatedByString:@"?"];
    [_showImgView sd_setImageWithURL:[NSURL URLWithString:url[0]] placeholderImage:[UIImage imageNamed:@"poi_bg_placeholder@2x"]];
    
    NSString *time = [model.first_day stringByReplacingOccurrencesOfString:@"-" withString:@"."];
    NSString *day_count = [NSString stringWithFormat:@"%@天", model.day_count];
    NSString *view_count = [NSString stringWithFormat:@"%@浏览", model.view_count];
    _timeLabel.text = [NSString stringWithFormat:@"%@  %@  %@", time, day_count, view_count];
    _locationLabel.text = model.popular_place_str;
    
    _userLabel.text = user.name;
    [_userImgView sd_setImageWithURL:[NSURL URLWithString:user.cover] placeholderImage:[UIImage imageNamed:@"poi_bg_placeholder@2x"]];
    
}

@end
