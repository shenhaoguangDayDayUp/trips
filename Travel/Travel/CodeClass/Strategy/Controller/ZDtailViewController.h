//
//  ZDtailViewController.h
//  Travel
//
//  Created by lanou on 15/9/23.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UMSocial.h"
typedef void (^RefreshCollectioBlock)(void);
@interface ZDtailViewController : UIViewController
@property (nonatomic, copy) RefreshCollectioBlock refreshCollectionBlock;
@property (nonatomic, copy) NSString *itemId;
@property (nonatomic, copy) NSString *tourId;
@property (nonatomic, retain) UIImageView *zoomImageView;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, copy) NSString *locationTitle;
@end
