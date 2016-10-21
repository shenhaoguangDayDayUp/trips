//
//  ScenicViewController.h
//  Travel
//
//  Created by lanou3g on 15/9/22.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SightModel.h"
#import <MapKit/MapKit.h>
typedef void (^Resfreshtableview)(NSInteger);
@interface ScenicViewController : UIViewController
@property (nonatomic,retain) SightModel *model;

//导航条标题
@property (nonatomic,retain) NSString *titleName;

@property (nonatomic,retain) UIButton *backbutton;

@property (nonatomic,retain) UIButton *collectbutton;

@property (nonatomic,retain) UIButton *sharebutton;

@property (nonatomic,retain) UIButton *deletebutton;

@property (nonatomic,copy) Resfreshtableview resfresh;

@property (nonatomic) NSInteger index;

@end
