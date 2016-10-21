//
//  SearchBarCollectionViewCell.m
//  Travel
//
//  Created by 申浩光 on 15/10/7.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "SearchBarCollectionViewCell.h"

@implementation SearchBarCollectionViewCell
- (void)dealloc {
    [_area release];
    [_areaImg release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {
        
        _areaImg = [[UIImageView alloc] initWithFrame:(CGRectMake(0, 0, (kWidth - 70.0 / kAutoWidth) / 3 , 25.0 / kAutoHight))];
        _areaImg.contentMode = UIViewContentModeScaleAspectFill;
        _area.clipsToBounds = YES;
        _areaImg.backgroundColor = kBackColor;
        _areaImg.layer.masksToBounds = YES;
        _areaImg.layer.borderColor = [kPinkColor CGColor];
        _areaImg.layer.borderWidth = 0.5;
        _areaImg.layer.cornerRadius = 12.5 / kAutoHight;
        [self.contentView addSubview:_areaImg];
        
        
        _area = [[UILabel alloc] initWithFrame:(CGRectMake(0, 0, _areaImg.frame.size.width, _areaImg.bounds.size.height))];
        _area.text = @"中国";
        _area.textColor = kPinkColor;
        _area.textAlignment = NSTextAlignmentCenter;
        _area.font = [UIFont systemFontOfSize:15.0];
        [_areaImg addSubview:_area];
    
    }
    return self;
}


@end
