//
//  TitleScrollView.m
//  Travel
//
//  Created by lanou on 15/9/18.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "TitleScrollView.h"
#define kButtonWidth 60.0 / 375 * kWidth
@implementation TitleScrollView
- (void)dealloc
{
    [_button release];
    [_lineView release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame titleArr:(NSArray *)titleArr target:(id)target action:(SEL)action controllEvent:(UIControlEvents)controllEvent {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = kPinkColor;
        //self.contentOffset = CGPointMake(kWidth, 0);
        self.contentSize = CGSizeMake(kButtonWidth * titleArr.count, 0);
        self.bounces = NO;
        self.showsHorizontalScrollIndicator = NO;
        
        //添加button
        for (int i = 0; i < titleArr.count; i++) {
            self.button = [UIButton buttonWithType:UIButtonTypeCustom];
            self.button.frame = CGRectMake(0 + kButtonWidth * i, 0, kButtonWidth, 30);
            self.button.tag = 10000 + i;
            //button.backgroundColor = [UIColor redColor];
            [self.button setTitle:titleArr[i] forState:UIControlStateNormal];
            [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            if (i == 0) {
                    self.button.transform = CGAffineTransformMakeScale(1.2, 1.2);
            }
            self.button.titleLabel.font = [UIFont boldSystemFontOfSize:14];
            self.button.titleLabel.textAlignment = NSTextAlignmentCenter;
            self.button.titleLabel.shadowColor = [UIColor blackColor];
            self.button.titleLabel.shadowOffset = CGSizeMake(0.5, 0.5);
            [self.button addTarget:target action:action forControlEvents:controllEvent];
            [self addSubview:self.button];
        }
        
        //添加button下面的白线
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 28, kButtonWidth, 2)];
        _lineView.backgroundColor = kBackColor;
        [self addSubview:_lineView];
        
        
    }
    return self;
}

- (void)setButtonToDefault {
    for (int i = 0; i < 7; i++) {
        UIButton *btn = (UIButton *)[self viewWithTag:10000 + i];
        [UIView animateWithDuration:0.2 animations:^{
            btn.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }];
        
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
