//
//  AppDelegate.h
//  Travel
//
//  Created by lanou on 15/9/18.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Reachability.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    NetworkStatus status;
}
@property NetworkStatus status;
@property (retain, nonatomic) UIWindow *window;

@end

