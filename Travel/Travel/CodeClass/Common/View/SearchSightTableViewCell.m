//
//  SearchSightTableViewCell.m
//  Travel
//
//  Created by lanou3g on 15/10/9.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "SearchSightTableViewCell.h"

@implementation SearchSightTableViewCell
-(void)dealloc{
    [_picimage release];
    [_label release];
    [super dealloc];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = kBackColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _picimage = [[UIImageView alloc] initWithFrame:CGRectMake(10/kAutoWidth, 10/kAutoHight, 30, 30)];
        _picimage.backgroundColor = kBackColor;
        [self.contentView addSubview:_picimage];
        
        _label = [[UILabel alloc] initWithFrame:CGRectMake(_picimage.frame.origin.x + 30 + 10, _picimage.frame.origin.y, kWidth - _picimage.frame.origin.x - 40, 30)];
        _label.font = [UIFont boldSystemFontOfSize:18];
        _label.backgroundColor = kBackColor;
        [self.contentView addSubview:_label];
        
    }
    return self;
}

- (void)setupWithModel:(SearchSightModel *)model{
    [_picimage sd_setImageWithURL:[NSURL URLWithString:@"http://media.breadtrip.com/images/icons/province.png"]];
    _label.text = model.name;

}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
