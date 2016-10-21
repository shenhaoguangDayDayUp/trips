//
//  AppDelegate.m
//  Travel
//
//  Created by lanou on 15/9/18.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseTabBarViewController.h"
#import "UMSocial.h"
#import "Reachability.h"
#import "ZWIntroductionViewController.h"
#import "StrategyDataBase.h"
#import "DXAlertView.h"
#import "XGPush.h"
#import "XGSetting.h"

#define _IPHONE80_ 80000
#import <SystemConfiguration/SystemConfiguration.h>
@interface AppDelegate ()
@property (nonatomic, strong) ZWIntroductionViewController *introductionView;
@end

@implementation AppDelegate
@synthesize status;
- (void)dealloc
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

     [UMSocialData setAppKey:@"55fd0ce3e0f55a305b002070"];

    self.window.backgroundColor = [UIColor whiteColor];
    
    
    if ([[StrategyDataBase shareDataBase] isFirstGuide]) {
        //引导图
        NSArray *coverImageNames = @[@"img_index_01txt", @"img_index_02txt", @"img_index_03txt"];
        NSArray *backgroundImageNames = @[@"img_index_01bg", @"img_index_02bg", @"img_index_03bg"];
        self.introductionView = [[ZWIntroductionViewController alloc] initWithCoverImageNames:coverImageNames backgroundImageNames:backgroundImageNames];
        [self.window addSubview:self.introductionView.view];
        __weak AppDelegate *weakSelf = self;
        self.introductionView.didSelectedEnter = ^() {
            [weakSelf.introductionView.view removeFromSuperview];
            weakSelf.introductionView = nil;
            BaseTabBarViewController *baseVC = [[BaseTabBarViewController alloc] init];
            weakSelf.window.rootViewController = baseVC;
            
            //    [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleLightContent)];
            //开启网络状况的监听
            [[NSNotificationCenter defaultCenter] addObserver:weakSelf selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
            
            //[self performSelector:@selector(reachabilityChanged:) withObject:nil afterDelay:2.0];
            Reachability *r = [Reachability reachabilityWithHostName:@"www.baidu.com"];
            [r startNotifier];
            
            // 夜间模式
            [[NSNotificationCenter defaultCenter] addObserver:weakSelf selector:@selector(switchOn) name:@"switchOn" object:nil];
            [[NSNotificationCenter defaultCenter] addObserver:weakSelf selector:@selector(switchOff) name:@"switchOff" object:nil];
            [[StrategyDataBase shareDataBase] createSqliteGuider];

        };
    }else{
        BaseTabBarViewController *baseVC = [[BaseTabBarViewController alloc] init];
        self.window.rootViewController = baseVC;
        
        //    [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleLightContent)];
        //开启网络状况的监听
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
        Reachability *r = [Reachability reachabilityWithHostName:@"www.baidu.com"];
        [r startNotifier];
        
        // 夜间模式
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(switchOn) name:@"switchOn" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(switchOff) name:@"switchOff" object:nil];
        

    }
    
    [[StrategyDataBase shareDataBase] createSqliteGuider];
    
    int cacheSizeMemory = 4*1024*1024; // 4MB
    int cacheSizeDisk = 32*1024*1024; // 32MB
    //内存缓存
    NSURLCache *sharedCache = [[NSURLCache alloc] initWithMemoryCapacity:cacheSizeMemory diskCapacity:cacheSizeDisk diskPath:@"nsurlcache"];
    [NSURLCache setSharedURLCache:sharedCache];
//
    //注册信鸽推送服务
    [XGPush startApp:2200152777 appKey:@"IUEFR21755JB"];
    
    //通知推送的方法在8.0之后有变化，需要进行判断。注册推送服务
    if ([UIDevice currentDevice].systemVersion.floatValue >=
        8.0) {
        
        //注册推送的声音、角标、提醒
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:nil];
        [application registerForRemoteNotifications];
        [application registerUserNotificationSettings:settings];
        application.delegate = self;
    }else {//8.0以前的注册推送服务
        
        [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert];//第一次打开应用的时候
    }
    
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)switchOn {
    self.window.alpha = 0.5;
}

- (void)switchOff {
    self.window.alpha = 1;
}



//获取token
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *str = [XGPush registerDevice:deviceToken];
    //NSLog(@"---------------%@", str);
}

//向apns发送申请
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    [application registerForRemoteNotifications];//注册下
}


- (void)updateInterfaceWithRwachability:(Reachability *)curReach;
{
     status = [curReach currentReachabilityStatus];
    if (status == NotReachable) {
        DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"温馨提示" contentText:@"网络连接失败,请检查网络" leftButtonTitle:nil rightButtonTitle:@"确定"];
        [alert show];
        //[alert release];
    }else if(status == ReachableViaWWAN){
        DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"温馨提示" contentText:@"请注意，您正在使用手机流量上网" leftButtonTitle:nil rightButtonTitle:@"确定"];
        [alert show];
        //[alert release];
    }else if(status == ReachableViaWiFi){
        //NSLog(@"网络已连接WiFi信号");
    }
}


- (void)reachabilityChanged:(NSNotification *)note
{
    Reachability *currReach = [note object];
    NSParameterAssert([currReach isKindOfClass:[Reachability class]]);
    
    //对连接改变做出响应处理动作
    [self updateInterfaceWithRwachability:currReach];


}





- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



@end
