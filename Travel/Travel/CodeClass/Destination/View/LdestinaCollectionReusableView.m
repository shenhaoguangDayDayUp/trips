//
//  LdestinaCollectionReusableView.m
//  Travel
//
//  Created by lanou3g on 15/9/18.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "LdestinaCollectionReusableView.h"

@implementation LdestinaCollectionReusableView
-(void)dealloc{
    [_titleLabel release];
    [_Morebutton release];
    [_colorLbel release];
    [super dealloc];
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _colorLbel = [[UILabel alloc] initWithFrame:CGRectMake(kWidth/(375/10.0), 20.0 / kAutoWidth, kWidth/(375/6.5), kWidth/(375/15.0))];
        _colorLbel.layer.masksToBounds = YES;
        _colorLbel.layer.cornerRadius = 2;
        _colorLbel.backgroundColor = kPinkColor;
        CGPoint center = _colorLbel.center;
        [self addSubview:_colorLbel];
        
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_colorLbel.frame.size.width + 20.0 / kAutoWidth, 20.0 / kAutoWidth, 200, _colorLbel.frame.size.height)];
       // _titleLabel.backgroundColor = [UIColor blueColor];
        _titleLabel.font = [UIFont systemFontOfSize:16.0];
        [self addSubview:_titleLabel];
        
        
        _Morebutton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _Morebutton.frame = CGRectMake(kWidth - 40.0 / kAutoWidth, center.y, 20, 20);
        _Morebutton.center = CGPointMake(kWidth - 40.0 / kAutoWidth / 2, center.y);
        [self addSubview:_Morebutton];
        
    }
    return self;
}


@end
