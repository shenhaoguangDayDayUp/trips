//
//  SearchSightTableViewCell.h
//  Travel
//
//  Created by lanou3g on 15/10/9.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchSightModel.h"
@interface SearchSightTableViewCell : UITableViewCell
@property (nonatomic,retain) UIImageView *picimage;
@property (nonatomic,retain) UILabel *label;
- (void)setupWithModel:(SearchSightModel *)model;
@end
