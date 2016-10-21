//
//  PhotoScrollView.h
//  Travel
//
//  Created by 申浩光 on 15/9/26.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DaysModel.h"
@interface PhotoScrollView : UIScrollView <UIScrollViewDelegate>

@property (nonatomic, assign) NSInteger currentIdx;
@property (nonatomic, retain) NSArray *imgArr;
- (instancetype)initWithFrame:(CGRect)frame imgArray:(NSArray *)imgArray target:(id)target currentIndex:(NSInteger)currentIndex ;

- (void)scrollToLastPic;
- (void)scrollToNextPic;

@end
