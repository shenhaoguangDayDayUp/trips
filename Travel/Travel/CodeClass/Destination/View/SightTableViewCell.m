//
//  SightTableViewCell.m
//  Travel
//
//  Created by lanou3g on 15/9/21.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "SightTableViewCell.h"

@implementation SightTableViewCell
-(void)dealloc{
    [_wish_to_go_countLabel release];
    [_picimage release];
    [_descripitionLabel release];
    [super dealloc];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellAccessoryNone;
        self.backgroundColor = kBackColor;
        _picimage = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth/(375/10.0), kHeight/(667/50.0), kWidth - 20, 150)];
        _picimage.userInteractionEnabled = YES;
        _picimage.layer.masksToBounds = YES;
        _picimage.contentMode = UIViewContentModeScaleAspectFill;
        _picimage.layer.cornerRadius = 10;
        [self.contentView addSubview:_picimage];
        
        _wish_to_go_countLabel = [[UILabel alloc] initWithFrame:CGRectMake(kWidth/(375/10), kHeight/(667/130.0), 100, 10)];
       // _wish_to_go_countLabel.backgroundColor = [UIColor redColor];
        _wish_to_go_countLabel.font = [UIFont systemFontOfSize:12];
        _wish_to_go_countLabel.textColor = [UIColor whiteColor];
        [_picimage addSubview:_wish_to_go_countLabel];
        
        _descripitionLabel = [[UILabel alloc] initWithFrame:CGRectMake(_wish_to_go_countLabel.frame.origin.x, 90, _picimage.frame.size.width - 30, 30)];
        _descripitionLabel.font = [UIFont boldSystemFontOfSize:12];
       // _descripitionLabel.textColor = [UIColor orangeColor];
        _descripitionLabel.textColor = [UIColor whiteColor];
        _descripitionLabel.numberOfLines = 0;
       
        [_picimage addSubview:_descripitionLabel];
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kWidth, 50)];
        _nameLabel.font = [UIFont boldSystemFontOfSize:20];
        _nameLabel.textAlignment = 1;
        _nameLabel.textColor = kPinkColor;
        [self.contentView addSubview:_nameLabel];
        
    }
    return self;
}

- (void)setUpwithmodel:(SightModel *)model{
    if ([model.cover isEqualToString:@""]) {
        _picimage.image = [UIImage imageNamed:@"trip_edit_cover_default@2x"];
    }else{
    NSArray *str = [model.cover componentsSeparatedByString:@"?"];
    [_picimage sd_setImageWithURL:[NSURL URLWithString:str[0]] placeholderImage:[UIImage imageNamed:@"trip_edit_title_shadow@2x"]];
    }
    _wish_to_go_countLabel.text = [NSString stringWithFormat:@"%@喜欢",model.wish_to_go_count];
    _descripitionLabel.text = model.Description;
    _nameLabel.text = [NSString stringWithFormat:@".%@.",model.name];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
