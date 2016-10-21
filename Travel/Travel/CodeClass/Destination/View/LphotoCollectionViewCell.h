//
//  LphotoCollectionViewCell.h
//  Travel
//
//  Created by lanou3g on 15/9/24.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LPhotoModel.h"
@interface LphotoCollectionViewCell : UICollectionViewCell
@property (nonatomic,retain) UIImageView *Photoimage;
- (void)setUpdetinationModel:(LPhotoModel *)model;
@end
