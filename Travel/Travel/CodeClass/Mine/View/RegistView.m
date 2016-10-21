//
//  RegistView.m
//  Travel
//
//  Created by 申浩光 on 15/10/5.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "RegistView.h"

@implementation RegistView

- (void)dealloc {
    [_user release];
    [_password release];
    [_repwd release];
    [_registBtn release];
    
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame delegate:(id)delegate action:(SEL)action {
    
    self = [super initWithFrame:frame];
    CGFloat width = frame.size.width;

    if (self) {
        
        self.backgroundColor = kPinkColor;
        
        
        _user = [[UITextField alloc] initWithFrame:(CGRectMake(0, 0, width, 20))];
        _user = [[UITextField alloc] initWithFrame:(CGRectMake(0, 0, width, 20.0 / kAutoWidth))];
        _user.placeholder = @"用户名";
        _user.backgroundColor = kPinkColor;
        _user.tintColor = kBackColor;
        _user.textColor = kBackColor;
        [_user setValue:[UIColor colorWithRed:0.969 green:0.949 blue:0.902 alpha:0.500] forKeyPath:@"_placeholderLabel.textColor"];
        _user.delegate = delegate;
        _user.tag = 6666;
        [self addSubview:_user];
        
        
        UIView *line = [[UIView alloc] initWithFrame:(CGRectMake(_user.frame.origin.x, _user.frame.origin.y + _user.bounds.size.height + 10, width, 0.5))];
        line.backgroundColor = [UIColor whiteColor];
        [self addSubview:line];
        [line release];
        
        
        _email = [[UITextField alloc] initWithFrame:(CGRectMake(_user.frame.origin.x, line.frame.origin.y + line.bounds.size.height + 20.0 / kAutoWidth, width, 20.0 / kAutoWidth))];
        _email.tintColor = kBackColor;
        _email.placeholder = @"邮箱地址";
        _email.textColor = kBackColor;
        _email.backgroundColor = kPinkColor;
        [_email setValue:[UIColor colorWithRed:0.969 green:0.949 blue:0.902 alpha:0.500] forKeyPath:@"_placeholderLabel.textColor"];
        _email.delegate = delegate;
        _email.tag = 7777;
        [self addSubview:_email];
        
        
        UIView *line1 = [[UIView alloc] initWithFrame:(CGRectMake(_user.frame.origin.x, _email.frame.origin.y + _email.bounds.size.height + 10, width, 0.5))];
        line1.backgroundColor = [UIColor whiteColor];
        [self addSubview:line1];
        [line1 release];
        
        
        _password = [[UITextField alloc] initWithFrame:(CGRectMake(_user.frame.origin.x, line1.frame.origin.y + line1.bounds.size.height + 20.0 / kAutoWidth, width, 20.0 / kAutoWidth))];
        _password.tintColor = kBackColor;
        _password.placeholder = @"输入密码,至少6位";
        _password.secureTextEntry = YES;
        _password.textColor = kBackColor;
        _password.backgroundColor = kPinkColor;
        [_password setValue:[UIColor colorWithRed:0.969 green:0.949 blue:0.902 alpha:0.500] forKeyPath:@"_placeholderLabel.textColor"];
        _password.delegate = delegate;
        _password.tag = 9999;
        [self addSubview:_password];
        
        
        UIView *line2 = [[UIView alloc] initWithFrame:(CGRectMake(_user.frame.origin.x, _password.frame.origin.y + _password.bounds.size.height + 10, width, 0.5))];
        line2.backgroundColor = [UIColor whiteColor];
        [self addSubview:line2];
        [line2 release];
        
        
        _repwd = [[UITextField alloc] initWithFrame:(CGRectMake(_user.frame.origin.x, line2.frame.origin.y + line2.bounds.size.height + 20.0 / kAutoWidth, width, 20.0 / kAutoWidth))];
        _repwd.tintColor = kBackColor;
        _repwd.placeholder = @"重新输入密码";
        _repwd.secureTextEntry = YES;
        _repwd.textColor = kBackColor;
        _repwd.backgroundColor = kPinkColor;
        [_repwd setValue:[UIColor colorWithRed:0.969 green:0.949 blue:0.902 alpha:0.500] forKeyPath:@"_placeholderLabel.textColor"];
        _repwd.delegate = delegate;
        _repwd.tag = 8888;
        [self addSubview:_repwd];
        
        
        UIView *line3 = [[UIView alloc] initWithFrame:(CGRectMake(_user.frame.origin.x, _repwd.frame.origin.y + _repwd.bounds.size.height + 10, width, 0.5))];
        line3.backgroundColor = [UIColor whiteColor];
        [self addSubview:line3];
        [line3 release];
        
        
        _registBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        _registBtn.frame = CGRectMake(0, 0, 200 / kAutoWidth, 40 / kAutoHight);
        _registBtn.center = CGPointMake(width / 2, line3.frame.origin.y + 60.0 / kAutoHight);
        _registBtn.layer.masksToBounds = YES;
        _registBtn.layer.borderWidth = 1;
        _registBtn.layer.borderColor = [kBackColor CGColor];
        _registBtn.layer.cornerRadius = 20.0 / kAutoWidth;
        _registBtn.backgroundColor = kBackColor;
        [_registBtn setTitleColor:kPinkColor forState:(UIControlStateNormal)];
        [_registBtn setTitle:@"注册账户" forState:(UIControlStateNormal)];
        [_registBtn addTarget:delegate action:action forControlEvents:(UIControlEventTouchUpInside)];
        _registBtn.tag = 88888;
        [self addSubview:_registBtn];
        
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
