//
//  LdestinationCollectionViewCell.m
//  Travel
//
//  Created by lanou3g on 15/9/18.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "LdestinationCollectionViewCell.h"

@implementation LdestinationCollectionViewCell
-(void)dealloc{
    [_NameLabel release];
    [_destinaImage release];
    [_settingImage release];
    [super dealloc];
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
         CGFloat width = frame.size.width;
        
        _destinaImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, width)];
        //_destinaImage.backgroundColor = [UIColor orangeColor];
        _destinaImage.layer.masksToBounds = YES;
        _destinaImage.layer.cornerRadius = 10;
        _destinaImage.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_destinaImage];
        
        _NameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, width - 30, 150, 20)];
        _NameLabel.textColor = [UIColor whiteColor];
        _NameLabel.font = [UIFont boldSystemFontOfSize:15];
        [_destinaImage addSubview:_NameLabel];
        
        _settingImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, width)];
        //_settingImage.image = [UIImage imageNamed:@"pic_view_bottomshadow@2x"];
        [_destinaImage addSubview:_settingImage];
    }
    return self;
}

//给Label与imageview赋值
- (void)setUpdetinationModel:(LdestinationModel *)model{
    NSArray *str = [model.cover componentsSeparatedByString:@"?"];
    [_destinaImage sd_setImageWithURL:[NSURL URLWithString:str[0]] placeholderImage:[UIImage imageNamed:@"empty_content"]];
    _NameLabel.text = model.name;

}

@end
