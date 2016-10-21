//
//  LphotoCollectionViewCell.m
//  Travel
//
//  Created by lanou3g on 15/9/24.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "LphotoCollectionViewCell.h"

@implementation LphotoCollectionViewCell
-(void)dealloc{
    [_Photoimage release];
    [super dealloc];
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat width = frame.size.width;
        
        _Photoimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, width)];
       // _Photoimage.backgroundColor = [UIColor orangeColor];
        _Photoimage.layer.masksToBounds = YES;
        _Photoimage.clipsToBounds = YES;
        _Photoimage.contentMode = UIViewContentModeScaleAspectFill;
        _Photoimage.layer.cornerRadius = 10;
        [self addSubview:_Photoimage];
    }
    return self;
}

- (void)setUpdetinationModel:(LPhotoModel *)model{
    NSArray *str = [model.photo componentsSeparatedByString:@"?"];
    [_Photoimage sd_setImageWithURL:[NSURL URLWithString:str[0]] placeholderImage:[UIImage imageNamed:@"trip_edit_title_shadow"]];
    
}
@end
