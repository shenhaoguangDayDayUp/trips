//
//  LdestinationCollectionViewCell.h
//  Travel
//
//  Created by lanou3g on 15/9/18.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LdestinationModel.h"
@interface LdestinationCollectionViewCell : UICollectionViewCell
@property (nonatomic,retain) UIImageView *settingImage;
@property (nonatomic,retain) UIImageView *destinaImage;
@property (nonatomic,retain) UILabel *NameLabel;

- (void)setUpdetinationModel:(LdestinationModel *)model;


@end
