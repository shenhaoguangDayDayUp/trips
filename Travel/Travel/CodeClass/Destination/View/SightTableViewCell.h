//
//  SightTableViewCell.h
//  Travel
//
//  Created by lanou3g on 15/9/21.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SightModel.h"

@interface SightTableViewCell : UITableViewCell
@property (nonatomic,retain) UILabel *descripitionLabel;
@property (nonatomic,retain) UILabel *wish_to_go_countLabel;
@property (nonatomic,retain) UIImageView *picimage;
@property (nonatomic,retain) UILabel *nameLabel;
- (void)setUpwithmodel:(SightModel *)model;
@end
