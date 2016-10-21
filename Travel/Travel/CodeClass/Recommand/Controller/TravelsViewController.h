//
//  TravelsViewController.h
//  Travel
//
//  Created by 申浩光 on 15/9/25.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^RefreshCollectioBlock)(void);
@interface TravelsViewController : UIViewController
@property (nonatomic, copy) RefreshCollectioBlock refreshCollectionBlock;
@property (nonatomic, retain) NSString *ID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *picUrl;
@end
