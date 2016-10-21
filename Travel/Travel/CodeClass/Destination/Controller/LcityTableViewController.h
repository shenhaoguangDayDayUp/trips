//
//  LcityTableViewController.h
//  Travel
//
//  Created by lanou3g on 15/9/24.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LdestinationModel.h"
@interface LcityTableViewController : UITableViewController
@property (nonatomic,retain) LdestinationModel *model;
@property (nonatomic,retain) NSString *picstring;
@property (nonatomic,retain) NSString *titleName;

@end
