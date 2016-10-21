//
//  StrategyDetailViewController.m
//  Travel
//
//  Created by lanou on 15/9/20.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "StrategyDetailViewController.h"
#import "StrategyDataBase.h"
#import "LoginViewController.h"
typedef void (^ChangeCollecColor)(void);

@interface StrategyDetailViewController ()<UIWebViewDelegate, UIScrollViewDelegate,UMSocialUIDelegate>
@property (nonatomic, retain) UIButton *bacTopBtn;
@property (nonatomic, retain) UIWebView *webView;
@property (nonatomic, retain) UIView *navigationBarView;
@property (nonatomic, copy) ChangeCollecColor changeCollectionColor;
@end

@implementation StrategyDetailViewController

- (void)dealloc
{
    _webView.delegate = nil;
    [_webView loadHTMLString:@"" baseURL:nil];
    [_webView stopLoading];
    [_webView removeFromSuperview];
    Block_release(_changeCollectionColor);
    Block_release(_refreshCollectionBlock);
    [_picUrl release];
    [_request release];
    [_navigationBarView release];
    [_webView release];
    [_url release];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.view.backgroundColor = [UIColor colorWithRed:0.969 green:0.949 blue:0.902 alpha:1.000];
    //NSLog(@"%@", self.url);
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, -85, kWidth, kHeight + 64 + 44)];
    _webView.scrollView.delegate = self;
    _webView.scrollView.bounces = NO;
    _webView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, -170, 0);
    
    [_webView loadRequest:self.request];

    [self.view addSubview:_webView];
    
    
    [self setBacToTopBtn];
    // Do any additional setup after loading the view.
}


- (void)setBacToTopBtn {
    _navigationBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 64)];
    _navigationBarView.backgroundColor = kBackColor;
    _navigationBarView.alpha = 0;
    [self.view addSubview:_navigationBarView];
    UIImageView *naviShadow = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, kWidth, 1)];
    naviShadow.alpha = 0.4;
    naviShadow.backgroundColor = [UIColor grayColor];
    
    [_navigationBarView addSubview:naviShadow];
    [naviShadow release];
    //返回顶部按钮
    self.bacTopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.bacTopBtn.frame = CGRectMake(kWidth - 60 - 20, kHeight - 40 - 20, 40, 40);
    self.bacTopBtn.alpha = 0;
    [self.bacTopBtn setBackgroundImage:[UIImage imageNamed:@"ic_bactoTop"] forState:UIControlStateNormal];
    [self.bacTopBtn addTarget:self action:@selector(bacToTopBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.bacTopBtn];
    

    
    //顶部返回按钮
    UIButton *bacBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    bacBtn.frame = CGRectMake(10, 24, 35, 35);
    [bacBtn setImage:[UIImage imageNamed:@"icon_nav_back_button"] forState:UIControlStateNormal];
    [bacBtn setTintColor:kBrownColor];
    [bacBtn addTarget:self action:@selector(bacBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bacBtn];
    
    UIButton *shareBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    shareBtn.frame = CGRectMake(kWidth - 15 - 25, 24, 35, 35);
    [shareBtn setImage:[UIImage imageNamed:@"tripview_share_highlight"] forState:(UIControlStateNormal)];
    [shareBtn setTintColor:kBrownColor];
    [shareBtn addTarget:self action:@selector(clickShare) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:shareBtn];
    
    
    UIButton *collectBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    collectBtn.frame = CGRectMake(shareBtn.frame.origin.x - 15 - 25, 24, 35, 35);
    [collectBtn setImage:[UIImage imageNamed:@"like_13x12_hl"] forState:(UIControlStateNormal)];
    
    UILabel *naviTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 190.0 / kAutoWidth, 35)];
    naviTitle.font = [UIFont boldSystemFontOfSize:18];
    naviTitle.text = @"最新攻略";
    naviTitle.textAlignment = NSTextAlignmentCenter;
    naviTitle.center = CGPointMake(kWidth / 2, bacBtn.center.y);
    naviTitle.textColor = kPinkColor;
    [_navigationBarView addSubview:naviTitle];
    [naviTitle release];
    
    //根据是否收藏确定收藏按钮颜色
    [collectBtn setTintColor:kBrownColor];
    self.changeCollectionColor = ^(void) {
        if ([[StrategyDataBase shareDataBase] jugdeIsCollectedWithTitle:self.webTitle ItemId:nil tourId:nil]) {
            [collectBtn setTintColor:kPinkColor];
        }else{
            [collectBtn setTintColor:kBrownColor];
        };
    };
    
    if ([[StrategyDataBase shareDataBase] isLogin]) {
        self.changeCollectionColor();
    }
    
    [collectBtn addTarget:self action:@selector(clickCollect) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:collectBtn];
    
    
    
}

#pragma mark ------点击事件------
- (void)bacBtn {
    [self dismissViewControllerAnimated:YES completion:nil];
    self.refreshCollectionBlock();
}

//收藏
- (void)clickCollect {
    if ([[StrategyDataBase shareDataBase] isLogin]) {
        [self clickAction];
    }else{
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        
        //登录之后执行
        loginVC.loginBlock = ^(void){
            
            if ([[StrategyDataBase shareDataBase] jugdeIsCollectedWithTitle:self.webTitle ItemId:nil tourId:nil]) {//如果已经收藏过，只改变收藏按钮颜色
                self.changeCollectionColor();
                
            }else{//没收藏过
                [self clickAction];
            }
        };
        [self presentViewController:loginVC animated:YES completion:nil];
        [loginVC release];
    }
}

//收藏方法
- (void)clickAction {
    if ([[StrategyDataBase shareDataBase] jugdeIsCollectedWithTitle:self.webTitle ItemId:nil tourId:nil]) {
        [[StrategyDataBase shareDataBase] deleteWebCollectionWithTitle:self.webTitle ItemId:nil tourId:nil];
    }else{
        [[StrategyDataBase shareDataBase] insertStrategyCollectionWithTitle:self.webTitle ZDetailModel:nil itemId:nil tourId:nil url:self.url picUrl:self.picUrl subTitle:self.subTitle];
    };    
    self.changeCollectionColor();
}

//分享
- (void)clickShare {
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.picUrl]];
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"55fd0ce3e0f55a305b002070"
                                      shareText:[NSString stringWithFormat:@"我在氢旅发现了一篇很有意思的游记哦快来看看吧%@%@",self.webTitle, self.url]
                                     shareImage:[UIImage imageWithData:data]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToSms,UMShareToDouban,UMShareToEmail,nil]
                                       delegate:self];
}

- (void)bacToTopBtn {
    [self.webView.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat y = scrollView.contentOffset.y ;
    //NSLog(@"%f", y);
    
    if (y >= 0) {
        self.navigationBarView.alpha = y/200.0;
    }else{
        self.navigationBarView.alpha = 0;
    }
    
    if (y >= kHeight) {
        [UIView animateWithDuration:0.5 animations:^{
            self.bacTopBtn.alpha = 0.5;
        }];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            self.bacTopBtn.alpha = 0;
        }];
    }
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"WebKitCacheModelPreferenceKey"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitDiskImageCacheEnabled"];//自己添加的，原文没有提到。
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitOfflineWebApplicationCacheEnabled"];//自己添加的，原文没有提到。
    [[NSUserDefaults standardUserDefaults] synchronize];
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
