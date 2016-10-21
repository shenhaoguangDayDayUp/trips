//
//  StoryDetailScrollView.m
//  Travel
//
//  Created by 申浩光 on 15/9/21.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "StoryDetailScrollView.h"

@implementation StoryDetailScrollView

-(void)dealloc {
    [_showView release];
    [_time release];
    [_title release];
    [_totitle release];
    [_totalLabel release];
    [_more release];
    [_littleT release];
    [_userImg release];
    [_showImg release];
    [_showLabel release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame target:(id)target action:(SEL)action {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.7];
        self.contentInset = UIEdgeInsetsMake(240.0 / kAutoWidth, 0, 110.0 / kAutoWidth, 0);
        
        // 标题上方介绍
        _littleT = [[UILabel alloc] initWithFrame:(CGRectMake(40, -(280.0 / kAutoWidth - 30.0 / kAutoWidth) / 2, kWidth - 80, 10))];
        _littleT.font = [UIFont systemFontOfSize:13.0];
        _littleT.textAlignment = NSTextAlignmentCenter;
        _littleT.textColor = [UIColor whiteColor];
        [self addSubview:_littleT];
        
        _totitle = [[UILabel alloc] initWithFrame:(CGRectMake(40, -(280.0 / kAutoWidth - 45.0 / kAutoWidth) / 2, kWidth - 80, 55))];
        _totitle.font = [UIFont boldSystemFontOfSize:21.0];
        _totitle.numberOfLines = 0;
        _totitle.textAlignment = NSTextAlignmentCenter;
        _totitle.textColor = [UIColor whiteColor];
        [self addSubview:_totitle];
        
        _showView = [[UIView alloc] init];
        _showView.backgroundColor = [UIColor colorWithRed:0.969 green:0.949 blue:0.902 alpha:1.000];
        _showView.layer.masksToBounds = YES;
        _showView.layer.cornerRadius = 5;
        _showView.frame = CGRectMake(0, 0, kWidth, kHeight);
        [self addSubview:_showView];
        
        _userImg = [[UIImageView alloc] initWithFrame:(CGRectMake(15, 30, 50, 50))];
        ;
        _userImg.backgroundColor = [UIColor whiteColor];
        _userImg.layer.masksToBounds = YES;
        _userImg.layer.cornerRadius = _userImg.bounds.size.height / 2;
        [_showView addSubview:_userImg];
        
        _title = [[UILabel alloc] initWithFrame:(CGRectMake(_userImg.bounds.size.width + 30, _userImg.frame.origin.y + 10, kWidth - 2 * (_userImg.bounds.size.width + 30), 15))];
        _title.font = [UIFont boldSystemFontOfSize:19.0];
        _title.numberOfLines = 0;
        [_showView addSubview:_title];
        
        _time = [[UILabel alloc] initWithFrame:(CGRectMake(_title.frame.origin.x, _title.bounds.size.height + 50, _title.bounds.size.width, 10))];
        _time.font = [UIFont systemFontOfSize:14.0];
        _time.textColor = [UIColor grayColor];
        [_showView addSubview:_time];
        
        _totalLabel = [[UILabel alloc] initWithFrame:(CGRectMake(10, 20 + _userImg.frame.origin.y + _userImg.bounds.size.height, kWidth - 20, 10))];
        _totalLabel.font = [UIFont systemFontOfSize:15.0];
        _totalLabel.numberOfLines = 0;
        _totalLabel.textAlignment = NSTextAlignmentLeft;
        [_showView addSubview:_totalLabel];
        
        TapimageView *tapView = [[TapimageView alloc] initWithFrame:(CGRectMake(0, - 280 + 64 * 2, kWidth, (280 - 128))) target:target action:action];
        tapView.backgroundColor = [UIColor clearColor];
        [self addSubview:tapView];
    }
    return self;
}

- (void)setUpShowContent:(NSMutableArray *)array target:(id)target action:(SEL)action {
    float tHeight = _totalLabel.frame.origin.y + _totalLabel.bounds.size.height;
    float indexHeight = 0.0;
    for (int i = 0; i < array.count; i++) {
        
        // 得到解析好的数据
        DetailList *model = array[i];
        
        // 按比例计算不同图片的高度
        CGFloat height = (kWidth - 20) * [model.photo_height floatValue] / [model.photo_width floatValue];
        
        // 循环创建展示图片
        _showImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, tHeight + 20 + indexHeight, kWidth - 20, height)];
        _showImg.clipsToBounds = YES;
        _showImg.contentMode = UIViewContentModeScaleAspectFill;
        _showImg.backgroundColor = [UIColor whiteColor];
        [_showView addSubview:_showImg];
        [_showImg sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:[UIImage imageNamed:@"poi_bg_placeholder@2x"]];
        
        // 创建内容
        _showLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10 + tHeight + height + 20 + indexHeight, kWidth - 20, 10)];
        _showLabel.text = model.text;
        _showLabel.font = [UIFont systemFontOfSize:15.0];
        _showLabel.numberOfLines = 0;
        [_showLabel sizeToFit];
        [_showView addSubview:_showLabel];
        
        UIImageView *arrow = [[UIImageView alloc] initWithFrame:(CGRectMake(30, height - 5, 12, 5))];
        arrow.image = [UIImage imageNamed:@"up_triangle.png"];
        [_showImg addSubview:arrow];
        [arrow release];
        
        indexHeight = indexHeight + height + _showLabel.bounds.size.height + 20;
        
        if (i == array.count - 1) {
            CGFloat Height = _showLabel.frame.origin.y + _showLabel.bounds.size.height + 40;
            _showView.frame = CGRectMake(0, 0, kWidth, Height);
            self.contentSize = CGSizeMake(0, Height);
        }
        
        // 判断label中是否有文字
        if (model.text == nil) {
            _showLabel.frame = CGRectMake(10, 10 + tHeight + height + 20 + indexHeight, kWidth - 20, 0);
        }

    }
    
    CGSize scrollSize = self.contentSize;
    CGFloat scrollHeight = scrollSize.height;
    //NSLog(@"%.4f", scrollHeight);
    
    // 故事详情链接
    _more = [[UILabel alloc] initWithFrame:(CGRectMake(40, scrollHeight + 40, kWidth - 80, 55))];
    _more.textColor = [UIColor whiteColor];
    _more.numberOfLines = 0;
    _more.font = [UIFont boldSystemFontOfSize:21.0];
    _more.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_more];
    
    TapimageView *tapViewButtom = [[TapimageView alloc] initWithFrame:(CGRectMake(0, scrollHeight, kWidth, (280 - 128))) target:target action:action];
    tapViewButtom.backgroundColor = [UIColor clearColor];
    [self addSubview:tapViewButtom];
    
    
    // 更多故事
    UILabel *moreStroy = [[UILabel alloc] initWithFrame:(CGRectMake(40, scrollHeight + 30, kWidth - 80, 10))];
    moreStroy.textColor = [UIColor whiteColor];
    moreStroy.text = @"探索更多地点故事";
    moreStroy.font = [UIFont systemFontOfSize:13.0];
    moreStroy.textAlignment = NSTextAlignmentCenter;
    [self addSubview:moreStroy];
    [moreStroy release];
    
    UIImageView *detailBtn = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth - 30.0 / kAutoWidth, scrollHeight + 50.0 / kAutoWidth, 10, 15)];
    detailBtn.image = [UIImage imageNamed:@"poi_arrow_icon@2x"];
    [self addSubview:detailBtn];
    [detailBtn release];
}

- (void)setValuesWithModel:(EveryDayModel *)every userInfo:(UserInfo *)user {
    
    _more.text = every.name;
    
    // 大标题
    _totitle.text = every.name;
    
    
    // 第一段的概述
    _totalLabel.text = every.text;
    [_totalLabel sizeToFit];
    
    // 作者图片
    [_userImg sd_setImageWithURL:[NSURL URLWithString:user.avatar_l] placeholderImage:nil];
    
    // 小标题
    if ([every.primary isEqualToString:@""]) {
        _title.text = @"在 路上 的故事";
    } else {
        _title.text = [NSString stringWithFormat:@"在 %@ 的故事", every.primary];
    }
    
    // 修改时间
    NSString *btime = [every.date_added substringWithRange:NSMakeRange(0, 10)];
    NSString *beginTime = [btime stringByReplacingOccurrencesOfString:@"-" withString:@"."];
    NSString *endTime = [every.date_added substringWithRange:NSMakeRange(11, 5)];
    _time.text = [NSString stringWithFormat:@"%@ %@", beginTime, endTime];
    
    _littleT.text = [NSString stringWithFormat:@"此故事由 %@ 收录于", user.name];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
