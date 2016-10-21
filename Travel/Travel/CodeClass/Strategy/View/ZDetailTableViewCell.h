//
//  ZDetailTableViewCell.h
//  Travel
//
//  Created by lanou on 15/9/23.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZRecodModel.h"
@interface ZDetailTableViewCell : UITableViewCell
@property (nonatomic, retain) UIImageView *imgView;
@property (nonatomic, retain) UILabel *text;
@property (nonatomic, retain) UIView *bacView;

- (void)setCellWithModel:(ZRecodModel *)model;
@end
