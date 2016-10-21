//
//  DetailCollectionViewCell.h
//  Travel
//
//  Created by lanou on 15/9/21.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StrategyModel.h"
@interface DetailCollectionViewCell : UICollectionViewCell
@property (nonatomic, retain) UIImageView *imgView;
@property (nonatomic, retain) UILabel *title;
@property (nonatomic, retain) UILabel *viewCount;
@property (nonatomic, retain) UILabel *likeCount;
@property (nonatomic, retain) UILabel *picCount;
@property (nonatomic, retain) UIImageView *authorImgView;

- (void)setCellWithModel:(StrategyModel *)model;

@end
