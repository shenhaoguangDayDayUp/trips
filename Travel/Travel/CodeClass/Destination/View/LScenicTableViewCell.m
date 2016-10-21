//
//  LScenicTableViewCell.m
//  Travel
//
//  Created by lanou3g on 15/9/22.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "LScenicTableViewCell.h"

@implementation LScenicTableViewCell
-(void)dealloc{
    [_nameLabel release];
    [_scenicLabel release];
    [super dealloc];
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.backgroundColor = kBackColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0/kAutoWidth, 0, 150, 30)];
        _nameLabel.font = [UIFont boldSystemFontOfSize:18];
       // _nameLabel.backgroundColor = [UIColor orangeColor];
        [self.contentView addSubview:_nameLabel];
        
        _scenicLabel = [[UILabel alloc] initWithFrame:CGRectMake(_nameLabel.frame.origin.x, _nameLabel.frame.origin.y + 30, kWidth - 50, 50)];
        _scenicLabel.font = [UIFont systemFontOfSize:14];
        _scenicLabel.numberOfLines = 0;
        [self.contentView addSubview:_scenicLabel];
        
        
        _iconbutton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        _iconbutton.frame = CGRectMake(kWidth-30, 30, 20, 20);
        [self.contentView addSubview:_iconbutton];
        
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
