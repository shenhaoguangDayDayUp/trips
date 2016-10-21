//
//  StrategyTableViewCell.h
//  Travel
//
//  Created by lanou on 15/9/18.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewStrategyModel.h"
@interface StrategyTableViewCell : UITableViewCell
@property (nonatomic, retain) UIImageView *coverImg;
@property (nonatomic, retain) UIImageView *imgView;
@property (nonatomic, retain) UILabel *title;
@property (nonatomic, retain) UILabel *subtitle;

- (void)setCellWithNewStrategyModel:(NewStrategyModel *)model;
- (void)setCellWithHotStrategyModel:(NewStrategyModel *)model;
@end
