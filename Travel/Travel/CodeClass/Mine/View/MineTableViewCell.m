//
//  MineTableViewCell.m
//  Travel
//
//  Created by 申浩光 on 15/10/4.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "MineTableViewCell.h"

@implementation MineTableViewCell

- (void)dealloc {
    [_arrowImg release];
    [_DNswitch release];
    [_text release];
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
        _text = [[UILabel alloc] initWithFrame:(CGRectMake(15.0 / kAutoWidth, 15.0 / kAutoWidth, (kWidth - 15.0 / kAutoWidth), 10.0 / kAutoHight))];
        _text.font = [UIFont systemFontOfSize:16.0];
        [self.contentView addSubview:_text];
        
        _arrowImg = [[UIImageView alloc] initWithFrame:(CGRectMake((kWidth - 30.0 / kAutoWidth), _text.frame.origin.y, 10.0 / kAutoWidth, 15.0 / kAutoHight))];
        _arrowImg.image = [UIImage imageNamed:@"poi_arrow_icon@2x"];
        [self.contentView addSubview:_arrowImg];
        
        _DNswitch = [[UISwitch alloc] initWithFrame:(CGRectMake((kWidth - 55.0 / kAutoWidth), _text.frame.origin.y - 13.0 / kAutoWidth, 40.0 / kAutoWidth, 15.0 / kAutoHight))];
        _DNswitch.transform = CGAffineTransformMakeScale(0.7, 0.7);
        _DNswitch.tintColor = kPinkColor;
        _DNswitch.onTintColor = kPinkColor;
        _DNswitch.alpha = 0;
        [self.contentView addSubview:_DNswitch];

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
