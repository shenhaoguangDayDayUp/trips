//
//  ZDetailTableViewCell.m
//  Travel
//
//  Created by lanou on 15/9/23.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "ZDetailTableViewCell.h"

@implementation ZDetailTableViewCell

- (void)dealloc
{
    [_imgView release];
    [_bacView release];
    [_text release];
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = NO;
        
        self.backgroundColor = [UIColor colorWithRed:0.969 green:0.949 blue:0.902 alpha:1.000];
        _bacView = [[UIView alloc] initWithFrame:CGRectMake(10.0 / kAutoWidth, 10.0 / kAutoHight, kWidth - 20.0 / kAutoHight, 80)];
        _bacView.backgroundColor = [UIColor whiteColor];
        _bacView.layer.masksToBounds = YES;
        _bacView.layer.cornerRadius = 5.0;
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWidth - 20.0 / kAutoHight, 40)];
        _imgView.userInteractionEnabled = YES;
        
        _text = [[UILabel alloc] initWithFrame:CGRectMake(5.0 / kAutoWidth, 40, kWidth - 30.0 / kAutoHight, 40)];
        _text.numberOfLines = 0;
        _text.font = [UIFont systemFontOfSize:15];
        [_bacView addSubview:_imgView];
        [_bacView addSubview:_text];
        [self.contentView addSubview:_bacView];
    }
    return  self;
}

- (void)setCellWithModel:(ZRecodModel *)model {
    float picH = 0;
    if (![model.picw isEqualToString:@"0"]) {
        picH = (kWidth - 20.0 / kAutoWidth) * [model.pich floatValue] / [model.picw floatValue];
        if (picH > 260.0 / kAutoHight) {
            picH = 260.0 / kAutoHight;
        }
        //NSLog(@"%f",picH);
    }
    _text.text = model.words;
    
    [_text sizeToFit];
    float height = picH + _text.bounds.size.height + 20.0 / kAutoHight;
    
    _bacView.frame = CGRectMake(10.0 / kAutoWidth, 10.0 / kAutoHight, kWidth - 20.0 / kAutoHight, height);
    _bacView.backgroundColor = [UIColor whiteColor];
    
    _imgView.frame = CGRectMake(0, 0, _bacView.bounds.size.width, picH);
    _imgView.contentMode = UIViewContentModeScaleAspectFill;
    [_imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://img.117go.com/timg/p750/%@", model.picfile]] placeholderImage:[UIImage imageNamed:@"empty_content@2x"]];
    _text.frame =  CGRectMake(5.0 / kAutoWidth, _imgView.bounds.size.height + 15.0 / kAutoWidth, kWidth - 30.0 / kAutoHight, _text.bounds.size.height);
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
