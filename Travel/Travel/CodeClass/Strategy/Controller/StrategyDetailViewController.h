//
//  StrategyDetailViewController.h
//  Travel
//
//  Created by lanou on 15/9/20.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UMSocial.h"
typedef void (^RefreshCollectioBlock)(void);
@interface StrategyDetailViewController : UIViewController
@property (nonatomic, copy) RefreshCollectioBlock refreshCollectionBlock;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, retain) NSURLRequest *request;
@property (nonatomic, copy)  NSString *webTitle;
@property (nonatomic, copy) NSString *picUrl;
@property (nonatomic, copy) NSString *subTitle;
@end
