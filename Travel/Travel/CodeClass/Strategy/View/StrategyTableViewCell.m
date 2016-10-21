//
//  StrategyTableViewCell.m
//  Travel
//
//  Created by lanou on 15/9/18.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "StrategyTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation StrategyTableViewCell
- (void)dealloc
{
    [_coverImg release];
    [_imgView release];
    [_title release];
    [_subtitle release];
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = NO;
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10.0 / kAutoWidth, 10.0 / kAutoHight, kWidth - (10.0 / kAutoWidth) * 2, 110.0 / kAutoHight)];
        self.backgroundColor = [UIColor colorWithRed:0.969 green:0.949 blue:0.902 alpha:1.000];
        _imgView.layer.masksToBounds = YES;
        _imgView.layer.cornerRadius = 3;
        _imgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_imgView];
        
        _coverImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWidth - (10.0 / kAutoWidth) * 2, 110.0 / kAutoHight)];
        _coverImg.image = [UIImage imageNamed:@"trip_edit_title_shadow"];
        [_imgView addSubview:_coverImg];
        
        
        _title = [[UILabel alloc] initWithFrame:CGRectMake(10, _imgView.bounds.size.height / 2 - 15.0 / kAutoHight, 250.0 / kAutoWidth, 30.0 / kAutoHight)];
        //_title.backgroundColor = [UIColor redColor];
        //_title.text = @"走到冰天雪地去";
        _title.textColor = [UIColor whiteColor];
        _title.shadowColor = [UIColor blackColor];
        _title.shadowOffset = CGSizeMake(0.8, 0.8);
        _title.font = [UIFont boldSystemFontOfSize:19];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        [_imgView addSubview:_title];
        
        
        _subtitle = [[UILabel alloc] initWithFrame:CGRectMake(10, _imgView.bounds.size.height / 2 - 5.0 / kAutoHight + 30.0 / kAutoHight, 200.0 / kAutoWidth, 20.0 / kAutoHight)];
        //_subtitle.text = @"约会芬兰最美的冬季";
        _subtitle.textColor = [UIColor whiteColor];
        _subtitle.shadowColor = [UIColor blackColor];
        _subtitle.shadowOffset = CGSizeMake(0.5, 0.5);
        _subtitle.font = [UIFont systemFontOfSize:14];
        [_imgView addSubview:_subtitle];

        
    }
    return self;
}

- (void)setCellWithNewStrategyModel:(NewStrategyModel *)model {
    _title.text = model.title;
    _subtitle.text = model.subtitle;
    [_imgView sd_setImageWithURL:model.banners[@"img_high"] placeholderImage:[UIImage imageNamed:@"cell_empty_icon"]];
}

- (void)setCellWithHotStrategyModel:(NewStrategyModel *)model {
    
    if (model.describe.length == 0) {
        _title.text = model.name;
    }else{
        _title.text = model.describe;
        _subtitle.text = model.name;
    }
    
    NSString *url = [NSString stringWithFormat:@"http://img.117go.com/timg/p750/%@", model.coverpic];
    [_imgView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"cell_empty_icon"]];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
