//
//  TapimageView.m
//  Travel
//
//  Created by lanou3g on 15/9/18.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "TapimageView.h"

@implementation TapimageView
- (instancetype)initWithFrame:(CGRect)frame target:(id)target action:(SEL)action{
    self = [super initWithFrame:frame];
    if (self) {
        //创建一个点击事件的imageview;
        //加入一个轻拍手势
        UITapGestureRecognizer *Tapimage = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
        
        //把当前用户交互打开
        self.userInteractionEnabled = YES;
        
        //把手势加入到当前类中
        [self addGestureRecognizer:Tapimage];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
