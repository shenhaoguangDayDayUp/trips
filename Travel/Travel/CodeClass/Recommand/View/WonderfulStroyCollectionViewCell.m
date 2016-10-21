//
//  WonderfulStroyCollectionViewCell.m
//  Travel
//
//  Created by 申浩光 on 15/9/18.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "WonderfulStroyCollectionViewCell.h"

@implementation WonderfulStroyCollectionViewCell

-(void)dealloc {
    [_showImgView release];
    [_userImgView release];
    [_userLabel release];
    [_titleLabel release];
    [_backImgView release];
    [_loactionLabel release];
    [_deletebutton release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat height = self.frame.size.height;
        CGFloat width = self.frame.size.width;
        
        self.backgroundColor = [UIColor clearColor];
        
        _backImgView = [[UIImageView alloc] initWithFrame:(CGRectMake(0, 0, width, height))];
        _backImgView.backgroundColor = [UIColor whiteColor];
        _backImgView.layer.masksToBounds = YES;
        _backImgView.layer.cornerRadius = 5;
        [self addSubview:_backImgView];
        
        _showImgView = [[UIImageView alloc] initWithFrame:(CGRectMake(0, 0, width, kWidth / (375.0 / 130)))];
        _showImgView.backgroundColor = [UIColor colorWithRed:0.882 green:0.839 blue:0.729 alpha:1.000];
        _showImgView.clipsToBounds = YES;
        _showImgView.contentMode = UIViewContentModeScaleAspectFill;
        [_backImgView addSubview:_showImgView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:(CGRectMake(kWidth / (375.0 / 8), _showImgView.frame.origin.y + kWidth / (375.0 / 130) + kWidth / (375.0 / 10), _showImgView.frame.size.width - (kWidth / (375.0 / 16)), kWidth / (375.0 / 40)))];
       // _titleLabel.text = @"逛完大昭寺，我们赶往布达拉宫广场，中途打听到一个逛完大昭寺，我们赶往布达拉宫广场，中途打听到一个";
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = [UIFont systemFontOfSize:13.0];
        [_backImgView addSubview:_titleLabel];
        
        _userImgView = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth / (375.0 / 8), _titleLabel.frame.origin.y + _titleLabel.bounds.size.height + 5, 20, 20)];
        _userImgView.backgroundColor = [UIColor colorWithRed:0.882 green:0.839 blue:0.729 alpha:1.000];
        _userImgView.layer.masksToBounds = YES;
        _userImgView.layer.cornerRadius = _userImgView.bounds.size.width / 2;
        [_backImgView addSubview:_userImgView];
        
        _userLabel = [[UILabel alloc] initWithFrame:(CGRectMake(kWidth / (375.0 / 8) + 25, _userImgView.frame.origin.y, 200, 20))];
        _userLabel.text = @"作者名";
        _userLabel.textColor = [UIColor grayColor];
        _userLabel.font = [UIFont systemFontOfSize:10.0];
        [_backImgView addSubview:_userLabel];
        
        
        _deletebutton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _deletebutton.frame = CGRectMake(0, 0, 20, 20);
        [_deletebutton setImage:[UIImage imageNamed:@"btn_add_new_poi_close@2x"] forState:(UIControlStateNormal)];
        _deletebutton.hidden = YES;
        _deletebutton.tag = 10;
        [_backImgView addSubview:_deletebutton];
        
    }
    return self;
}

- (void)setValueWithModel:(EveryDayModel *)model user:(UserInfo *)user {
    NSArray *url = [model.cover_image componentsSeparatedByString:@"?"];
    [_showImgView sd_setImageWithURL:[NSURL URLWithString:url[0]] placeholderImage:[UIImage imageNamed:@"poi_bg_placeholder@2x"]];
    _titleLabel.text = model.index_title;
    _userLabel.text = user.name;
    [_userImgView sd_setImageWithURL:[NSURL URLWithString:user.cover] placeholderImage:[UIImage imageNamed:@"poi_bg_placeholder@2x"]];
}

-(void)setupWithJson:(SightModel *)model{
    
    NSArray *arr = [model.photo componentsSeparatedByString:@"?"];
    [_showImgView sd_setImageWithURL:[NSURL URLWithString:arr[0]]];
    _titleLabel.text = model.name;
}
@end
