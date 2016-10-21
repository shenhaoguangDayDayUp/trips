//
//  BaseTabBarViewController.m
//  Travel
//
//  Created by lanou on 15/9/18.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "BaseTabBarViewController.h"
#import "MineViewController.h"
#import "RecommandViewController.h"
#import "StrategyViewController.h"
#import "DestinationViewController.h"
#import "StrategyDataBase.h"

#import "SDImageCache.h"

@interface BaseTabBarViewController ()

@end

@implementation BaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad]; 
    
    [[StrategyDataBase shareDataBase] createSqliteWithLogin];
    //推荐
    RecommandViewController *recommandVC = [[[RecommandViewController alloc] init] autorelease];
    [self addChildVC:recommandVC title:@"推荐" imageName:@"ic_tabbar_dicovery@2x" selectImgName:@"ic_tabbar_dicovery_selected@2x"];
    
    //目的地
    DestinationViewController *destinationVC = [[[DestinationViewController alloc] init] autorelease];
    [self addChildVC:destinationVC title:@"目的地" imageName:@"ic_tabbar_local@2x" selectImgName:@"ic_tabbar_local_selected@2x"];
    
    //攻略
    StrategyViewController *strateVC = [[[StrategyViewController alloc] init] autorelease];
    [self addChildVC:strateVC title:@"攻略" imageName:@"ic_tabbar_mall@2x" selectImgName:@"ic_tabbar_mall_selected@2x"];
    
    //我的
    MineViewController *mineVC = [[[MineViewController alloc] init] autorelease];
    [self addChildVC:mineVC title:@"我的" imageName:@"ic_tabbar_mine@2x" selectImgName:@"ic_tabbar_mine_select@2x"];
    // Do any additional setup after loading the view.
}


#pragma mark ------添加item的方法------
- (void)addChildVC:(UIViewController *)childVC title:(NSString *)title imageName:(NSString *)imageName selectImgName:(NSString *)selectImgName {
    
    //设置导航控制器
    UINavigationController *childNC = [[[UINavigationController alloc] initWithRootViewController:childVC] autorelease];
    
    //导航控制器标题
    childVC.navigationItem.title = title;
    
    //导航栏颜色
    childNC.navigationBar.barTintColor = kBackColor;
    
    //tabBar字体颜色
    self.tabBar.tintColor = kPinkColor;
    
    //tabBar上面的item的标题
    childNC.tabBarItem.title = title;
    
    //item图标
    [childNC.tabBarItem setImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    [childNC.tabBarItem setSelectedImage:[[UIImage imageNamed:selectImgName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    [self addChildViewController:childNC];
    
    //设置导航栏字体颜色
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:kPinkColor,NSForegroundColorAttributeName, nil];
    [childNC.navigationBar setTitleTextAttributes:attributes];
    
}

- (void)didReceiveMemoryWarning {
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [[SDImageCache sharedImageCache] clearMemory];
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
