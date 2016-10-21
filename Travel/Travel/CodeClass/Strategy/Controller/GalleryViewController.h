//
//  GalleryViewController.h
//  Travel
//
//  Created by lanou on 15/9/24.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GalleryScrollView.h"

typedef void (^GalleryBlock)(NSInteger);

@interface GalleryViewController : UIViewController

@property (nonatomic, copy) GalleryBlock bolck;
@property (nonatomic, retain) NSArray *dataArr;
@property (nonatomic) float currentIndex;
@property (nonatomic, retain) GalleryScrollView *galleryView;
@property (nonatomic, retain) NSString *photoTitle;
@end
