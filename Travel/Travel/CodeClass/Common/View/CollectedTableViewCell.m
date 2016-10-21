//
//  CollectedTableViewCell.m
//  Travel
//
//  Created by 申浩光 on 15/10/5.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "CollectedTableViewCell.h"
#import "SightModel.h"
@implementation CollectedTableViewCell

- (void)dealloc {
    [_arrowImg release];
    [_text release];
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
        _text = [[UILabel alloc] initWithFrame:(CGRectMake(15, 15, kWidth - 15, 10))];
        _text.font = [UIFont systemFontOfSize:16.0];
        [self.contentView addSubview:_text];
        
        _arrowImg = [[UIImageView alloc] initWithFrame:(CGRectMake(kWidth - 30, _text.frame.origin.y, 10, 15))];
        _arrowImg.image = [UIImage imageNamed:@"next_hl.png"];
        [self.contentView addSubview:_arrowImg];

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
