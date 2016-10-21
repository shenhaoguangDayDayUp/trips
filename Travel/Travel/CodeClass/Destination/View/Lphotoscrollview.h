//
//  Lphotoscrollview.h
//  Travel
//
//  Created by lanou3g on 15/9/25.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LPhotoModel.h"
@interface Lphotoscrollview : UIScrollView<UIScrollViewDelegate>

@property (nonatomic,retain) UILabel *titleLabel;
@property (nonatomic,retain) UILabel *timeLabel;
@property (nonatomic,retain) UILabel *nameLabel;
@property (nonatomic,retain) UIImageView *picimage2;
@property (nonatomic,retain) UIImageView *picimage1;
@property (nonatomic,retain) UILabel *textLabel;
@property (nonatomic,retain) UIView *headerview;
@property (nonatomic,retain) UIScrollView *scrollview;
@property (nonatomic) NSInteger indexpath;
@property (nonatomic,retain) NSArray *imageArray;
-(instancetype)initWithFrame:(CGRect)frame photoArray:(NSArray *)photoArray target:(id)target index:(NSInteger)index;
- (void)scrolltolastPic;
- (void)scrolltonextPic;
- (void)setscrollviewWithIndex:(int)i model:(LPhotoModel *)model;
@end
