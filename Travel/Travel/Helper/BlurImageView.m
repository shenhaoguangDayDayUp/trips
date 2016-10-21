//
//  BlurImageView.m
//  WJQMusicPlayer
//
//  Created by vidonia on 15/8/31.
//  Copyright (c) 2015年 vidonia. All rights reserved.
//

#import "BlurImageView.h"

@implementation BlurImageView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpBlurImageView];
        
    }
    return self;
}

- (void)setUpBlurImageView {
    
    UIVisualEffectView *backVisualView = [[[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:(UIBlurEffectStyleDark)]] autorelease];
    
    backVisualView.alpha = 0.2;
    
    backVisualView.frame = CGRectMake(0, 0, kWidth, 180.0 / kAutoHight);
    
    self.image = [UIImage imageNamed:@"catalog_head_bg3"];
    
    [self addSubview:backVisualView];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
