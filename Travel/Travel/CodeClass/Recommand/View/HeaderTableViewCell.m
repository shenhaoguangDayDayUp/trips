//
//  HeaderTableViewCell.m
//  Travel
//
//  Created by 申浩光 on 15/9/24.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "HeaderTableViewCell.h"

@implementation HeaderTableViewCell

- (void)dealloc {
    [_totalText release];
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = kBackColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _totalText = [[UILabel alloc] initWithFrame:(CGRectMake(10, 10, kWidth - 20, 100))];
        _totalText.font = [UIFont systemFontOfSize:15.0];
        _totalText.numberOfLines = 0;
        _totalText.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_totalText];
    }
    return self;
}

- (void)setValueWithText:(NSString *)text {
    _totalText.text = text;
    [_totalText sizeToFit];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
