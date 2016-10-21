//
//  ScrollViewController.m
//  Travel
//
//  Created by 申浩光 on 15/10/2.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "ScrollViewController.h"

@interface ScrollViewController ()

@end

@implementation ScrollViewController

- (void)dealloc {
    [_url release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 10, kWidth, kHeight - 10)];
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://web.breadtrip.com/trips/%@", self.url]]]];
    [self.view addSubview:web];
    web.scrollView.bounces = NO;
    [web release];
    
    
    UIView *navigationBar = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, kWidth , 64))];
    navigationBar.backgroundColor = kBackColor;
    [self.view addSubview:navigationBar];
    [navigationBar release];
    UIView *line = [[UIView alloc] initWithFrame:(CGRectMake(0, 64, kWidth, 1))];
    line.backgroundColor = [UIColor grayColor];
    line.alpha = 0.6;
    [self.view addSubview:line];
    [line release];
    UIButton *backBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    backBtn.frame = CGRectMake(15, 30, 25, 25);
    [backBtn setImage:[UIImage imageNamed:@"icon_nav_back_button"] forState:(UIControlStateNormal)];
    [backBtn setTintColor:kBrownColor];
    [backBtn addTarget:self action:@selector(clickBack) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:backBtn];
    
}

- (void)clickBack {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
