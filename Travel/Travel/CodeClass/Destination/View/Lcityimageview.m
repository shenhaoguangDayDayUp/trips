//
//  Lcityimageview.m
//  Travel
//
//  Created by lanou3g on 15/9/20.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "Lcityimageview.h"

@implementation Lcityimageview
-(void)dealloc{
    [_nameLabel release];
    [_wish_to_go_countLabel release];
    [_likeLabel release];
    [_beenLabel release];
    [_visited_countLabel release];

    [super dealloc];
}

-(instancetype)initWithFrame:(CGRect)frame target:(id)target action:(SEL)action{
    self = [super initWithFrame:frame target:target action:action];
    if (self) {
        self.userInteractionEnabled = YES;
       // self.backgroundColor = [UIColor orangeColor];
        
        
        
        _nameLabel= [[UILabel alloc] initWithFrame:CGRectMake(kWidth/(375/10.0), 200.0/kAutoHight, 200, 40)];
       // _nameLabel.backgroundColor = [UIColor redColor];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.font = [UIFont boldSystemFontOfSize:25];
        _nameLabel.autoresizingMask= UIViewAutoresizingFlexibleTopMargin;
        [self addSubview:_nameLabel];
        
        _wish_to_go_countLabel = [[UILabel alloc] initWithFrame:CGRectMake(kWidth/(375/10.0), _nameLabel.frame.origin.y  + 60, 70, 10)];
       // _wish_to_go_countLabel.backgroundColor = [UIColor greenColor];
        _wish_to_go_countLabel.textColor = [UIColor whiteColor];
        _wish_to_go_countLabel.font = [UIFont systemFontOfSize:12];
         _wish_to_go_countLabel.autoresizingMask= UIViewAutoresizingFlexibleTopMargin;
        [self addSubview:_wish_to_go_countLabel];
        
        _beenLabel = [[UILabel alloc] initWithFrame:CGRectMake(_wish_to_go_countLabel.frame.origin.x + 35, _wish_to_go_countLabel.frame.origin.y,30, 10)];
        _beenLabel.text = @"去过";
        _beenLabel.textColor = [UIColor whiteColor];
        _beenLabel.font = [UIFont systemFontOfSize:12];
         _beenLabel.autoresizingMask= UIViewAutoresizingFlexibleTopMargin;
        [self addSubview:_beenLabel];
        
        _visited_countLabel = [[UILabel alloc] initWithFrame:CGRectMake(_beenLabel.frame.origin.x + 35, _wish_to_go_countLabel.frame.origin.y, 70, 10)];
        _visited_countLabel.textColor = [UIColor whiteColor];
        //_visited_countLabel.backgroundColor = [UIColor blueColor];
        _visited_countLabel.font = [UIFont systemFontOfSize:12];
         _visited_countLabel.autoresizingMask= UIViewAutoresizingFlexibleTopMargin;
        [self addSubview:_visited_countLabel];
        
        _likeLabel = [[UILabel alloc] initWithFrame:CGRectMake(_visited_countLabel.frame.origin.x + 35, _wish_to_go_countLabel.frame.origin.y, 30, 10)];
        _likeLabel.font = [UIFont systemFontOfSize:12];
        _likeLabel.textColor = [UIColor whiteColor];
        _likeLabel.autoresizingMask= UIViewAutoresizingFlexibleTopMargin;
        _likeLabel.text = @"喜欢";
        [self addSubview:_likeLabel];
        
        
        
    }
    return self;
}

- (void)setupJsonModel:(CountryModel *)model{
    _nameLabel.text = model.name;
    _wish_to_go_countLabel.text = model.wish_to_go_count;
    _visited_countLabel.text = model.visited_count;

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
