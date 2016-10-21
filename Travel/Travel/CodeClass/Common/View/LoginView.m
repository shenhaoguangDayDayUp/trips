//
//  LoginView.m
//  Travel
//
//  Created by 申浩光 on 15/10/5.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView
- (void)dealloc {
    [_user release];
    [_password release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame delegate:(id)delegate action:(SEL)action {

    self = [super initWithFrame:frame];
    
    CGFloat width = frame.size.width;
    
    if (self) {
        
        self.backgroundColor = kPinkColor;
        
        _user = [[UITextField alloc] initWithFrame:(CGRectMake(0, 0, width, 20.0 / kAutoWidth))];
        _user.placeholder = @"请输入邮箱";
        _user.backgroundColor = kPinkColor;
        _user.tintColor = kBackColor;
        _user.textColor = kBackColor;
        [_user setValue:[UIColor colorWithRed:0.969 green:0.949 blue:0.902 alpha:0.500] forKeyPath:@"_placeholderLabel.textColor"];
        _user.delegate = delegate;
        _user.tag = 5000;
        [self addSubview:_user];
        
        
        UIView *line = [[UIView alloc] initWithFrame:(CGRectMake(_user.frame.origin.x, _user.frame.origin.y + _user.bounds.size.height + 10.0 / kAutoWidth, width, 0.5))];
        line.backgroundColor = [UIColor whiteColor];
        [self addSubview:line];
        [line release];
        
        
        _password = [[UITextField alloc] initWithFrame:(CGRectMake(_user.frame.origin.x, line.frame.origin.y + line.bounds.size.height + 20.0 / kAutoWidth, width, 20.0 / kAutoWidth))];
        _password.tintColor = kBackColor;
        _password.placeholder = @"输入登陆密码,至少6位";
        _password.secureTextEntry = YES;
        _password.textColor = kBackColor;
        _password.backgroundColor = kPinkColor;
        [_password setValue:[UIColor colorWithRed:0.969 green:0.949 blue:0.902 alpha:0.500] forKeyPath:@"_placeholderLabel.textColor"];
        _password.delegate = delegate;
        _password.tag = 6000;
        [self addSubview:_password];
        
        
        UIView *line2 = [[UIView alloc] initWithFrame:(CGRectMake(_user.frame.origin.x, _password.frame.origin.y + _password.bounds.size.height + 10.0 / kAutoWidth, width, 0.5))];
        line2.backgroundColor = [UIColor whiteColor];
        [self addSubview:line2];
        [line2 release];

        
        _loginBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        _loginBtn.frame = CGRectMake(0, 0, 200.0 / kAutoWidth, 40.0 / kAutoHight);
        _loginBtn.center = CGPointMake(width / 2, line2.frame.origin.y + 60.0 / kAutoHight);
        _loginBtn.layer.masksToBounds = YES;
        _loginBtn.layer.borderWidth = 1;
        _loginBtn.layer.borderColor = [kBackColor CGColor];
        _loginBtn.layer.cornerRadius = 20.0 / kAutoWidth;
        _loginBtn.backgroundColor = kBackColor;
        [_loginBtn setTitleColor:kPinkColor forState:(UIControlStateNormal)];
        [_loginBtn setTitle:@"立即登录" forState:(UIControlStateNormal)];
        [_loginBtn addTarget:delegate action:action forControlEvents:(UIControlEventTouchUpInside)];
        _loginBtn.tag = 10000;
        [self addSubview:_loginBtn];
        
        
        UIView *line3 = [[UIView alloc] initWithFrame:(CGRectMake(_user.frame.origin.x, _loginBtn.frame.origin.y + _loginBtn.bounds.size.height + 45.0 / kAutoWidth, width, 1))];
        line3.backgroundColor = [UIColor colorWithWhite:1 alpha:0.6];
        [self addSubview:line3];
        [line3 release];

        
        UILabel *label = [[UILabel alloc] initWithFrame:(CGRectMake(60.0 / kAutoWidth, line3.frame.origin.y + line3.bounds.size.height, width - 120.0 / kAutoWidth, 10.0 / kAutoWidth))];
        label.center = CGPointMake(width / 2, line3.frame.origin.y + line3.bounds.size.height / 2);
        label.textColor = [UIColor colorWithRed:0.969 green:0.949 blue:0.902 alpha:0.700];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"社交平台授权登陆";
        label.font = [UIFont systemFontOfSize:14.0];
        label.backgroundColor = kPinkColor;
        [self addSubview:label];
        [label release];
        
        UIView *line4 = [[UIView alloc] initWithFrame:(CGRectMake(_user.frame.origin.x, label.frame.origin.y + label.bounds.size.height + 40.0 / kAutoWidth, 0.5, 60.0 / kAutoHight))];
        line4.center = CGPointMake(width / 2, label.frame.origin.y + label.bounds.size.height + 80);
        line4.backgroundColor = [UIColor colorWithWhite:1 alpha:0.4];
        [self addSubview:line4];
        [line4 release];

        
        _weibo = [UIButton buttonWithType:(UIButtonTypeSystem)];
        _weibo.frame = CGRectMake((width / 2 - 60.0 / kAutoWidth) / 2, label.frame.origin.y + label.bounds.size.height + 40.0 / kAutoWidth, 60.0 / kAutoWidth, 60.0 / kAutoWidth);
        _weibo.backgroundColor = kPinkColor;
        [_weibo setImage:[UIImage imageNamed:@"weibo@2x"] forState:(UIControlStateNormal)];
        _weibo.tintColor = kBackColor;
        [self addSubview:_weibo];
        [_weibo addTarget:delegate action:action forControlEvents:(UIControlEventTouchUpInside)];
        _weibo.tag = 20000;

        
        UILabel *weibo = [[UILabel alloc] initWithFrame:CGRectMake(_weibo.frame.origin.x, _weibo.frame.origin.y + _weibo.bounds.size.height + 5.0 / kAutoWidth, 65.0 / kAutoWidth, 10.0 / kAutoWidth)];
        weibo.text = @"微博登陆";
        weibo.textColor = kBackColor;
        weibo.font = [UIFont systemFontOfSize:13.0];
        weibo.textAlignment = NSTextAlignmentCenter;
        [self addSubview:weibo];
        [weibo release];
        
        _zone = [UIButton buttonWithType:(UIButtonTypeSystem)];
        _zone.frame = CGRectMake(((width / 2 - 60.0 / kAutoWidth) / 2) + width / 2, label.frame.origin.y + label.bounds.size.height + 40.0 / kAutoWidth, 60.0 / kAutoWidth, 60.0 / kAutoWidth);
        _zone.backgroundColor = kPinkColor;
        [_zone setImage:[UIImage imageNamed:@"zone@2x"] forState:(UIControlStateNormal)];
        _zone.tintColor = kBackColor;
        [self addSubview:_zone];
        [_zone addTarget:delegate action:action forControlEvents:(UIControlEventTouchUpInside)];
        _zone.tag = 30000;

        
        UILabel *zone = [[UILabel alloc] initWithFrame:CGRectMake(_zone.frame.origin.x, _zone.frame.origin.y + _zone.bounds.size.height + 5.0 / kAutoWidth, 65.0 / kAutoWidth, 10.0 / kAutoWidth)];
        zone.text = @"腾讯微博";
        zone.textColor = kBackColor;
        zone.font = [UIFont systemFontOfSize:13.0];
        zone.textAlignment = NSTextAlignmentCenter;
        [self addSubview:zone];
        [zone release];
        
        UIView *line5 = [[UIView alloc] initWithFrame:(CGRectMake(_user.frame.origin.x, weibo.frame.origin.y + weibo.bounds.size.height + 55.0 / kAutoWidth, width, 1))];
        line5.backgroundColor = [UIColor colorWithWhite:1 alpha:0.6];
        [self addSubview:line5];
        [line5 release];
        
        _registBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        _registBtn.frame = CGRectMake((width - 200.0 / kAutoWidth)/ 2, line5.frame.origin.y + line5.bounds.size.height + 40.0 / kAutoWidth, 200.0 / kAutoWidth, 40.0 / kAutoWidth);
        [_registBtn setTitle:@"注册账号" forState:(UIControlStateNormal)];
        [_registBtn setTitleColor:kBackColor forState:(UIControlStateNormal)];
        _registBtn.backgroundColor = kPinkColor;
        _registBtn.layer.masksToBounds = YES;
        _registBtn.layer.borderWidth = 1;
        _registBtn.layer.cornerRadius = 20.0 / kAutoWidth;
        _registBtn.layer.borderColor = [kBackColor CGColor];
        [self addSubview:_registBtn];
        [_registBtn addTarget:delegate action:action forControlEvents:(UIControlEventTouchUpInside)];
        _registBtn.tag = 50000;

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
