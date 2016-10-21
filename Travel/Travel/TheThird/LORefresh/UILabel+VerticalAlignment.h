//
//  UILabel+VerticalAlignment.h
//  SingleMusic
//
//  Created by wer_chen on 15/9/1.
//  Copyright (c) 2015年 werchen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, NSVerticalAlignment) {
    NSVerticalAlignmentTop = 0,
    NSVerticalAlignmentBottom
};

@interface UILabel (VerticalAlignment)

//  竖直方向排列方式
@property (nonatomic) NSVerticalAlignment verticalAlignment;

@end
