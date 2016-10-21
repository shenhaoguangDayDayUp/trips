//
//  DetailCollectionViewCell.m
//  Travel
//
//  Created by lanou on 15/9/21.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "DetailCollectionViewCell.h"

@implementation DetailCollectionViewCell

- (void)dealloc
{
    [_title release];
    [_imgView release];
    [_viewCount release];
    [_likeCount release];
    [_picCount release];
    [_authorImgView release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        CGFloat width = self.bounds.size.width;
        CGFloat height = self.bounds.size.height;
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height - 70.0 / kAutoHight)];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        //_imgView.backgroundColor = [UIColor colorWithRed:0.000 green:0.502 blue:1.000 alpha:1.000];
        [self addSubview:_imgView];
        
        UIImageView *coverImg = [[UIImageView alloc] initWithFrame:_imgView.bounds];
        coverImg.image = [UIImage imageNamed:@"trip_edit_title_shadow"];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5.0;        

        [_imgView addSubview:coverImg];
        [coverImg release];
        
        _title = [[UILabel alloc] initWithFrame:CGRectMake(10.0 / kAutoWidth, _imgView.bounds.size.height + 5.0 /kAutoHight, width - 30.0 / kAutoWidth, 40.0 / kAutoHight)];
        //_title.backgroundColor = [UIColor blueColor];
        _title.text = @"冬季去喀纳斯看雪";
        _title.numberOfLines = 0;
        //[_title sizeToFit];
        _title.textColor = [UIColor blackColor];
        _title.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_title];
        
        
        //下面几个统一的高度
        float iconHeight = height - 20.0 / kAutoWidth;
        UIImageView *eyeImg = [[UIImageView alloc] initWithFrame:CGRectMake(10.0 / kAutoWidth, iconHeight, 14.0 / kAutoWidth, 14.0 / kAutoWidth)];
        eyeImg.image = [UIImage imageNamed:@"icon_view_trip"];
        //eyeImg.alpha = 0.7;
        //[eyeImg setTintColor:kPinkColor];
        [coverImg addSubview:eyeImg];
        [eyeImg release];
        
        _viewCount = [[UILabel alloc] initWithFrame:CGRectMake( eyeImg.bounds.size.width + 13.0 / kAutoWidth , iconHeight, 40.0 / kAutoWidth, 13.0 / kAutoWidth)];
        _viewCount.text = @"43.9k";
        //_viewCount.backgroundColor = [UIColor redColor];
        _viewCount.font = [UIFont systemFontOfSize:10];
        _viewCount.textColor = [UIColor colorWithWhite:0.200 alpha:1.000];
        [coverImg addSubview:_viewCount];
        
        UIImageView *likeImg = [[UIImageView alloc] initWithFrame:CGRectMake(_viewCount.bounds.size.width + 30.0 / kAutoWidth , iconHeight,  15.0 / kAutoWidth, 15.0 / kAutoWidth)];
        likeImg.image = [UIImage imageNamed:@"icon_like_white_34"];
        likeImg.layer.masksToBounds = YES;
        likeImg.tintColor = kPinkColor;
        [coverImg addSubview:likeImg];
        [likeImg release];
        
        _likeCount = [[UILabel alloc] initWithFrame:CGRectMake(likeImg.frame.origin.x + 12.0 / kAutoWidth + 6,  iconHeight, 40.0 / kAutoWidth, 15.0 / kAutoWidth)];
        _likeCount.textColor = [UIColor colorWithWhite:0.200 alpha:1.000];
        _likeCount.text = @"770";
        _likeCount.font = [UIFont systemFontOfSize:10];
        [coverImg addSubview:_likeCount];
    }
    return self ;
}

- (void)setCellWithModel:(StrategyModel *)model {
    _title.text = model.title;
    if (model.viewCnt.length > 4) {
        CGFloat viewCount = [model.viewCnt floatValue] / 1000;
        _viewCount.text = [NSString stringWithFormat:@"%.1fk",viewCount];
    }else {
        _viewCount.text = model.viewCnt;
    }
    _likeCount.text = model.likeCnt;
    
    [_imgView sd_setImageWithURL:[NSURL URLWithString:model.coverpic] placeholderImage:[UIImage imageNamed:@"empty_content@2x"]];
}

@end
