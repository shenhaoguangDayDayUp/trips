//
//  StoryViewController.h
//  Travel
//
//  Created by 申浩光 on 15/9/23.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoryViewController : UIViewController

@property (nonatomic, retain) NSString *photo;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *text;
@property (nonatomic, retain) NSString *userName;
@property (nonatomic, retain) NSString *avatar_l;
@property (nonatomic, retain) NSString *date_added;
@property (nonatomic, retain) NSMutableArray *detailArr;
@property (nonatomic, retain) NSString *dayCout;
@property (nonatomic, retain) NSString *storyCount;

@end
