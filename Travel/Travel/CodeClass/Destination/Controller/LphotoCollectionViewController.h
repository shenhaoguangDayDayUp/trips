//
//  LphotoCollectionViewController.h
//  Travel
//
//  Created by lanou3g on 15/10/4.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
#import "LPhotoModel.h"
typedef void (^refrestableview)(void);
@interface LphotoCollectionViewController : UICollectionViewController
@property (nonatomic,retain) LPhotoModel *model;
@property (nonatomic,retain) NSString *type;
@property (nonatomic,retain) NSString *ID;
@property (nonatomic,retain) NSNumber *count;
@property (nonatomic,copy) refrestableview tableblock;
@end
