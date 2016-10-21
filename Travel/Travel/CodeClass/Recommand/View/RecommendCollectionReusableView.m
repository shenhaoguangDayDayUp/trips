//
//  RecommendCollectionReusableView.m
//  Travel
//
//  Created by 申浩光 on 15/9/18.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "RecommendCollectionReusableView.h"

@implementation RecommendCollectionReusableView

-(void)dealloc {
    [_titleLabel release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *lineView = [[UIView alloc] initWithFrame:(CGRectMake((kWidth / (375.0 / 10)), (kWidth / (375.0 / 20)), (kWidth / (375.0 / 6.5)), (kWidth / (375.0 / 15))))];
        lineView.center = CGPointMake(3.25 / kAutoWidth + 10.0 / kAutoWidth, 20.0 / kAutoWidth / 2 + 15.0 / kAutoWidth);
        lineView.backgroundColor = [UIColor colorWithRed:0.886 green:0.2588 blue:0.3411 alpha:1];
        lineView.layer.masksToBounds = YES;
        lineView.layer.cornerRadius = 2;
        [self addSubview:lineView];
        [lineView release];
        
        _titleLabel = [[UILabel alloc] initWithFrame:(CGRectMake(lineView.frame.origin.x + (kWidth / (375.0 / 6.5)) + (kWidth / (375.0 / 10)), lineView.frame.origin.y + (kWidth / (375.0 / 4)), (kWidth / (375.0 / 160)), (kWidth / (375.0 / 15))))];
        _titleLabel.center = CGPointMake(lineView.frame.origin.x + (kWidth / (375.0 / 6.5)) + 160.0 / kAutoWidth / 2 + 10, 15.0 / kAutoWidth + 10.0 / kAutoWidth);
        _titleLabel.font = [UIFont systemFontOfSize:16.0];
        [self addSubview:_titleLabel];
    
        
        _arrowBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        _arrowBtn.frame = CGRectMake(kWidth - (kWidth / (375.0 / 55)), _titleLabel.frame.origin.y, (kWidth / (375.0 / 40)), (kWidth / (375.0 / 15)));
        [_arrowBtn setTintColor:[UIColor grayColor]];
        [self addSubview:_arrowBtn];
    }
    return self;
}
@end
