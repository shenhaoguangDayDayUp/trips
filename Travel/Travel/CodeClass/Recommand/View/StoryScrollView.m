//
//  StoryScrollView.m
//  Travel
//
//  Created by 申浩光 on 15/9/23.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "StoryScrollView.h"


@implementation StoryScrollView

- (void)dealloc {
    [_story release];
    [_storyShow release];
    [_time release];
    [_titleLabel release];
    [_Tline release];
    [_Bline release];
    [_Lline release];
    [_Rline release];
    [_toContent release];
    [_showImg release];
    [_showLabel release];

    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
//        self.contentSize = CGSizeMake(0, kHeight * 5);
//        self.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
//        self.contentOffset = CGPointMake(0, -kImgHeight);
        [self setUpHeaderView];
    }
    return self;
}

#pragma mark --------------- 实现头视图下拉图片 ----------------
- (void)setUpHeaderView {
   
    _userLabel = [[UILabel alloc] initWithFrame:(CGRectMake(50, 55, kWidth - 100, 10))];
    _userLabel.font = [UIFont systemFontOfSize:13.0];
    _userLabel.textColor = [UIColor grayColor];
    _userLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_userLabel];
    
    _titleLabel = [[UILabel alloc] initWithFrame:(CGRectMake(10, _userLabel.frame.origin.y + _userLabel.bounds.size.height + 10, kWidth - 20, 60))];
    _titleLabel.font = [UIFont systemFontOfSize:20.0];
    _titleLabel.numberOfLines = 0;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_titleLabel];
    
    _Tline = [[UIImageView alloc] initWithFrame:(CGRectMake(10, _titleLabel.frame.origin.y + _titleLabel.bounds.size.height + 10, kWidth - 20, 0.5))];
    _Tline.image = [UIImage imageNamed:@"poi_seperator_line"];
    [self addSubview:_Tline];
    
    _Lline = [[UIView alloc] initWithFrame:(CGRectMake((kWidth - 20) / 3.0, _Tline.frame.origin.y + 10, 0.5, 30))];
    _Lline.backgroundColor = [UIColor grayColor];
    [self addSubview:_Lline];
    
    _Rline = [[UIView alloc] initWithFrame:(CGRectMake(((kWidth - 20) / 3.0) * 2, _Tline.frame.origin.y + 10, 0.5, 30))];
    _Rline.backgroundColor = [UIColor grayColor];
    [self addSubview:_Rline];
    
    _date = [[UILabel alloc] initWithFrame:(CGRectMake(10, _Tline.frame.origin.y + 10, (kWidth -20) / 3.0, 10))];
    _date.font = [UIFont systemFontOfSize:13.0];
    _date.textAlignment = NSTextAlignmentCenter;
    _date.text = @"日期";
    [self addSubview:_date];
    
    _dateShow = [[UILabel alloc] initWithFrame:(CGRectMake(_date.frame.origin.x, _date.frame.origin.y + _date.bounds.size.height + 10, (kWidth -20) / 3.0, 10))];
    _dateShow.font = [UIFont systemFontOfSize:13.0];
    _dateShow.textAlignment = NSTextAlignmentCenter;
    _dateShow.textColor = [UIColor grayColor];
    [self addSubview:_dateShow];
    
    _journeyday = [[UILabel alloc] initWithFrame:(CGRectMake(_Lline.frame.origin.x, _Tline.frame.origin.y + 10, (kWidth -20) / 3.0, 10))];
    _journeyday.font = [UIFont systemFontOfSize:13.0];
    _journeyday.textAlignment = NSTextAlignmentCenter;
    _journeyday.text = @"行程";
    [self addSubview:_journeyday];
    
    _journeyShow = [[UILabel alloc] initWithFrame:(CGRectMake(_journeyday.frame.origin.x, _journeyday.frame.origin.y + _journeyday.bounds.size.height + 10, (kWidth -20) / 3.0, 10))];
    _journeyShow.font = [UIFont systemFontOfSize:13.0];
    _journeyShow.textAlignment = NSTextAlignmentCenter;
    _journeyShow.textColor = [UIColor grayColor];
    _journeyShow.text = @"1天";
    [self addSubview:_journeyShow];
    
    _story = [[UILabel alloc] initWithFrame:(CGRectMake(_Rline.frame.origin.x, _Tline.frame.origin.y + 10, (kWidth -20) / 3.0, 10))];
    _story.font = [UIFont systemFontOfSize:13.0];
    _story.textAlignment = NSTextAlignmentCenter;
    _story.text = @"地点故事";
    [self addSubview:_story];
    
    _storyShow = [[UILabel alloc] initWithFrame:(CGRectMake(_story.frame.origin.x, _story.frame.origin.y + _story.bounds.size.height + 10, (kWidth -20) / 3.0, 10))];
    _storyShow.font = [UIFont systemFontOfSize:13.0];
    _storyShow.textAlignment = NSTextAlignmentCenter;
    _storyShow.textColor = [UIColor grayColor];
    _storyShow.text = @"1个";
    [self addSubview:_storyShow];
    
    _time = [[UILabel alloc] initWithFrame:(CGRectMake(0, _Tline.frame.origin.y + 100, kWidth, 10))];
    _time.textColor = [UIColor grayColor];
    _time.textAlignment = NSTextAlignmentCenter;
    _time.text = @"2015.09.22 星期二";
    _time.font = [UIFont systemFontOfSize:14.0];
    [self addSubview:_time];
    
    _Bline = [[UIImageView alloc] initWithFrame:(CGRectMake(10, _time.frame.origin.y + _time.bounds.size.height + 15, kWidth - 20, 0.5))];
    _Bline.image = [UIImage imageNamed:@"poi_seperator_line"];
    [self addSubview:_Bline];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
