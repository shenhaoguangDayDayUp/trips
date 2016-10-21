//
//  StoryDetailViewController.h
//  Travel
//
//  Created by 申浩光 on 15/9/21.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EveryDayModel.h"
typedef void (^RefreshCollectioBlock)(void);

@interface StoryDetailViewController : UIViewController
@property (nonatomic, copy) RefreshCollectioBlock refreshCollectionBlock;
@property (nonatomic, copy) NSString *spot_id;
@property (nonatomic, copy) NSString *picUrl;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *name;

@end
