//
//  LoginView.h
//  Travel
//
//  Created by 申浩光 on 15/10/5.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginView : UIView

@property (nonatomic, retain) UITextField *user;

@property (nonatomic, retain) UITextField *password;

@property (nonatomic, retain) UIButton *loginBtn;

@property (nonatomic, retain) UIButton *weibo;

@property (nonatomic, retain) UIButton *zone;

@property (nonatomic, retain) UIButton *registBtn;

- (instancetype)initWithFrame:(CGRect)frame delegate:(id)delegate action:(SEL)action;
@end
