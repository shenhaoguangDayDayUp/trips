//
//  GalleryScrollView.h
//  Travel
//
//  Created by lanou on 15/9/25.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GalleryScrollView : UIScrollView<UIScrollViewDelegate>
@property (nonatomic, assign) NSInteger currentIdx;
@property (nonatomic, retain) NSArray *imgArr;
- (instancetype)initWithFrame:(CGRect)frame imgArray:(NSArray *)imgArray target:(id)target currentIndex:(NSInteger)currentIndex ;

- (void)scrollToLastPic;
- (void)scrollToNextPic;
@end
