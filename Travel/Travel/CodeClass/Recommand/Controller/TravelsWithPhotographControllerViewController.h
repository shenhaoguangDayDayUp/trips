//
//  TravelsWithPhotographControllerViewController.h
//  Travel
//
//  Created by 申浩光 on 15/9/26.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^TravelBlock)(NSInteger);

@interface TravelsWithPhotographControllerViewController : UIViewController
@property (nonatomic, retain) NSMutableArray *daysArr;
@property (nonatomic, assign) CGFloat currentIndex;
@property (nonatomic, copy) TravelBlock block;
@end
