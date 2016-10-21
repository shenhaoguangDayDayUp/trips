//
//  LocationViewController.h
//  Travel
//
//  Created by lanou on 15/9/20.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewStrategyModel.h"
@interface LocationViewController : UIViewController
@property (nonatomic, copy) NSString *itemId;
@property (nonatomic, copy) NSString *coverPic;
@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, retain) UIImageView *zoomImageView;
@property (nonatomic, retain) NewStrategyModel *model;
@property (nonatomic, retain) UILabel *locationName;

@end
