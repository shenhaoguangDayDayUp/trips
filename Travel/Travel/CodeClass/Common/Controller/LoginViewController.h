//
//  LoginViewController.h
//  Travel
//
//  Created by 申浩光 on 15/10/5.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^LoginBlock)(void);
@interface LoginViewController : UIViewController
@property (nonatomic, copy) LoginBlock loginBlock;
@end
