//
//  AuthorInfoView.m
//  Travel
//
//  Created by lanou on 15/9/22.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "AuthorInfoView.h"

@implementation AuthorInfoView

- (void)dealloc
{
    [_authorIcon release];
    [_authorInfo release];
    [_date release];
    [_tags release];
    [super dealloc];
}


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _authorIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40.0 / kAutoWidth, 40.0 / kAutoWidth)];
        _authorIcon.layer.masksToBounds = YES;
        _authorIcon.layer.cornerRadius = _authorIcon.bounds.size.width / 2;
        _authorIcon.backgroundColor = kBackColor;
        [self addSubview:_authorIcon];
        
        _title = [[UILabel alloc] initWithFrame:CGRectMake(_authorIcon.bounds.size.width + 10.0 / kAutoWidth, 0, 300.0 / kAutoWidth, 18.0 / kAutoHight)];
        //_title.backgroundColor = [UIColor redColor];
        _title.textColor = [UIColor whiteColor];
        _title.shadowColor = [UIColor blackColor];
        _title.shadowOffset = CGSizeMake(0.5, 0.5);
        _title.text = @"圣城雅典";
        _title.font = [UIFont boldSystemFontOfSize:17];
        [self addSubview:_title];
        
        _authorInfo = [[UILabel alloc] initWithFrame:CGRectMake(_authorIcon.bounds.size.width + 10.0 / kAutoWidth, _title.frame.origin.y + _title.bounds.size.height + 8.0 / kAutoHight, 200.0 / kAutoWidth, 14.0 / kAutoHight)];
        //_authorInfo.backgroundColor = [UIColor redColor];
        _authorInfo.textColor = [UIColor whiteColor];
        _authorInfo.text = @"by Devin_lu";
        _authorInfo.shadowColor = [UIColor blackColor];
        _authorInfo.shadowOffset = CGSizeMake(0.5, 0.5);
        _authorInfo.font = [UIFont boldSystemFontOfSize:14];
        [self addSubview:_authorInfo];
        
        _date = [[UILabel alloc] initWithFrame:CGRectMake(_authorIcon.bounds.size.width + 10.0 / kAutoWidth, _authorInfo.frame.origin.y + _authorInfo.bounds.size.height + 8.0 / kAutoHight , 300.0 / kAutoWidth, 14.0 / kAutoHight)];
        _date.textColor = [UIColor whiteColor];
        _date.text = @"2013.08.08 | 2天";
        _date.shadowColor = [UIColor blackColor];
        _date.shadowOffset = CGSizeMake(0.5, 0.5);
        _date.font = [UIFont boldSystemFontOfSize:14];
        [self addSubview:_date];
        
        _tags = [[UILabel alloc] initWithFrame:CGRectMake(_authorIcon.bounds.size.width + 10.0 / kAutoWidth, _date.frame.origin.y + _date.bounds.size.height + 8.0, 300.0 / kAutoWidth, 14.0 / kAutoHight)];
        _tags.textColor = [UIColor whiteColor];
        _tags.text = @"美食 度假 穷游 户外 摄影";
        _tags.shadowColor = [UIColor blackColor];
        _tags.shadowOffset = CGSizeMake(0.5, 0.5);
        _tags.font = [UIFont boldSystemFontOfSize:14];
        [self addSubview:_tags];
    }
    return self;
}

- (void)setUpViewWithDetailModel:(ZDetailModel *)model {
    _tags.text = model.tags;
    _title.text = model.title;
    _date.text = [NSString stringWithFormat:@"%@ | %@天",model.startdate, model.days];
    _authorInfo.text = [NSString stringWithFormat:@"by %@", model.owner[@"nickname"]];
    NSString *authorIcon = [NSString stringWithFormat:@"http://img.117go.com/demo27/img/ava102/%@",model.owner[@"avatar"]];
    [_authorIcon sd_setImageWithURL:[NSURL URLWithString:authorIcon] placeholderImage:nil];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
