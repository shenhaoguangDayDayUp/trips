//
//  TitleScrollView.h
//  Travel
//
//  Created by lanou on 15/9/18.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//  攻略页面上一排小标题

#import <UIKit/UIKit.h>

@interface TitleScrollView : UIScrollView
@property (nonatomic, retain) UIButton *button;
@property (nonatomic, retain) UIView *lineView;

//根据传进来的标题数组创建上面的一排按钮
- (instancetype)initWithFrame:(CGRect)frame titleArr:(NSArray *)titleArr target:(id)target action:(SEL)action controllEvent:(UIControlEvents)controllEvent;

- (void)setButtonToDefault;

@end
