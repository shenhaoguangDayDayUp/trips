//
//  LocationCollectionReusableView.m
//  Travel
//
//  Created by lanou on 15/9/22.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "LocationCollectionReusableView.h"

@implementation LocationCollectionReusableView

- (void)dealloc
{
    [_count release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10.0 / kAutoWidth, 20.0 / kAutoHight, 4.0 / kAutoWidth, 20.0 / kAutoHight)];
        view.backgroundColor = kPinkColor;
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = view.bounds.size.width/ 2;
        [self addSubview:view];
        [view release];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(23.0 / kAutoWidth, 18.0 / kAutoHight, 300.0 / kAutoHight, 25.0 / kAutoHight)];
        title.text = @"精彩攻略";
        title.font = [UIFont systemFontOfSize:16];
        [self addSubview:title];
        [title release];
        
//        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(20.0 / kAutoWidth, 45.0 / kAutoHight, 130.0 / kAutoWidth, 1)];
//        lineView.backgroundColor = [UIColor colorWithWhite:0.702 alpha:1.000];
//        [self addSubview:lineView];
//        [lineView release];
        

        
        
    }
    return  self;
}

@end
