//
//  StrategyCollectTableViewCell.m
//  Travel
//
//  Created by lanou on 15/10/5.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "StrategyCollectTableViewCell.h"

@implementation StrategyCollectTableViewCell

- (void)dealloc
{
    [_bacView release];
    [_pic release];
    [_titleLabel release];
    [_subTitleLabel release];
    [super dealloc];
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _bacView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, kWidth - 20, 90.0 / kAutoWidth)];
        _bacView.layer.masksToBounds = YES;
        _bacView.layer.cornerRadius = 5;
        UIVisualEffectView *bacVisual = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
        bacVisual.frame = _bacView.bounds;
        [_bacView addSubview:bacVisual];
        
        [self.contentView addSubview:_bacView];
        [bacVisual release];
        
        
        _pic = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 90.0 / kAutoWidth, 90.0 / kAutoWidth)];
        _pic.layer.masksToBounds = YES;
        _pic.contentMode = UIViewContentModeScaleAspectFill;
        _pic.layer.cornerRadius = 5;
        [_bacView addSubview:_pic];
        self.backgroundColor = kBackColor;
        self.selectionStyle = NO;
        
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_pic.bounds.size.width + 10, 10, kWidth - (_pic.bounds.size.width + 40), 25)];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:19];
        _titleLabel.shadowColor = [UIColor colorWithWhite:0.200 alpha:1.000];
        _titleLabel.shadowOffset = CGSizeMake(0.5, 0.5);
        //_titleLabel.backgroundColor = [UIColor redColor];
        [_bacView addSubview:_titleLabel];
        
        _subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_titleLabel.frame.origin.x, _titleLabel.frame.origin.y + _titleLabel.bounds.size.height + 5, _titleLabel.bounds.size.width, 100 - (_titleLabel.frame.origin.y + _titleLabel.bounds.size.height + 25))];
        
        _subTitleLabel.font = [UIFont boldSystemFontOfSize:14];
        _subTitleLabel.textColor = [UIColor colorWithWhite:0.902 alpha:1.000];
        _subTitleLabel.shadowColor = [UIColor colorWithWhite:0.298 alpha:1.000];
        _subTitleLabel.shadowOffset = CGSizeMake(0.2, 0.2);
        _subTitleLabel.numberOfLines = 0;
        //_subTitleLabel.backgroundColor = [UIColor redColor];
        [_bacView addSubview:_subTitleLabel];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
