//
//  SearchCollectionReusableView.m
//  Travel
//
//  Created by 申浩光 on 15/10/7.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "SearchCollectionReusableView.h"

@implementation SearchCollectionReusableView

- (void)dealloc {
    [_title release];
    [_Tline release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        _Tline = [[UIView alloc] initWithFrame:(CGRectMake(15, 0, kWidth - 30, 2))];
        _Tline.backgroundColor = kPinkColor;
        [self addSubview:_Tline];
        [_Tline release];
        
        _title = [[UILabel alloc] initWithFrame:(CGRectMake(_Tline.frame.origin.x, _Tline.frame.origin.y + _Tline.bounds.size.height + 20 / kAutoHight, kWidth - 20, 10))];
        _title.textColor = kPinkColor;
        _title.font = [UIFont boldSystemFontOfSize:18.0];
        [self addSubview:_title];
        
        UIView *Bline = [[UIView alloc] initWithFrame:(CGRectMake(_Tline.frame.origin.x, _title.frame.origin.y + _title.bounds.size.height + 20 / kAutoHight, kWidth - 30, 2))];
        Bline.backgroundColor = kPinkColor;
        [self addSubview:Bline];
        [Bline release];
    }
    return self;
}

@end
