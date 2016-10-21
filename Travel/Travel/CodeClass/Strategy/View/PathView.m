//
//  PathView.m
//  Travel
//
//  Created by lanou on 15/9/21.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "PathView.h"

@implementation PathView

- (void)dealloc
{
    [_name1 release];
    [_name2 release];
    [_name3 release];
    [super dealloc];
}
- (instancetype)initWithFrame:(CGRect)frame nameArray:(NSArray *)array {
    self = [super initWithFrame:frame];
    if (self) {
        self.length = 0;
        if (array.count == 1) {
            _name1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 24)];
            _name1.text = array[0];
            [self setLabel:_name1];
            [_name1 sizeToFit];
            UIImageView *img = [[UIImageView alloc] init];
            img.frame = CGRectMake(0, 0, _name1.bounds.size.width + 14, 24);
            _name1.center = img.center;
            UIEdgeInsets ed = UIEdgeInsetsMake(0, 10, 0, 10);
            //img.alpha = 0.7;
            [img.image resizableImageWithCapInsets:ed];
            [img setImage:[[UIImage imageNamed:@"bg_crumbs"] resizableImageWithCapInsets:ed]];
            [img addSubview:_name1];
            [self addSubview:img];
            [img release];
            self.length = self.length + _name1.bounds.size.width + 14;
            
        }else if (array.count == 2) {
            
            _name1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 24)];
            _name1.text = array[0];
            [self setLabel:_name1];
            [_name1 sizeToFit];
            UIImageView *img = [[UIImageView alloc] init];
            //img.alpha = 0.7;
            img.frame = CGRectMake(0, 0, _name1.bounds.size.width + 14, 24);
            _name1.center = img.center;
            UIEdgeInsets ed = UIEdgeInsetsMake(0, 10, 0, 10);
            [img.image resizableImageWithCapInsets:ed];
            [img setImage:[[UIImage imageNamed:@"bg_crumbs"] resizableImageWithCapInsets:ed]];
            [img addSubview:_name1];
            [self addSubview:img];
            [img release];
            self.length = self.length + _name1.bounds.size.width + 14;
            
            _name2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 24)];
            _name2.text = array[1];
            [self setLabel:_name2];
            [_name2 sizeToFit];
            UIImageView *img2 = [[UIImageView alloc] init];
            //img2.alpha = 0.7;
            img2.frame = CGRectMake(img.bounds.size.width + 5, 0, _name2.bounds.size.width + 14, 24);
            _name2.frame = CGRectMake(7, 0, _name2.bounds.size.width, 24);
            
            UIEdgeInsets ed2 = UIEdgeInsetsMake(0, 10, 0, 10);
            [img2.image resizableImageWithCapInsets:ed2];
            [img2 setImage:[[UIImage imageNamed:@"bg_crumbs"] resizableImageWithCapInsets:ed]];
            [img2 addSubview:_name2];
            [self addSubview:img2];
            [img2 release];
            self.length = self.length + _name2.bounds.size.width + 14 + 5;
            
        }else if (array.count == 3) {
            _name1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 24)];
            _name1.text = array[0];
            [self setLabel:_name1];
            [_name1 sizeToFit];
            UIImageView *img = [[UIImageView alloc] init];
            //img.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.400];
            img.frame = CGRectMake(0, 0, _name1.bounds.size.width + 14, 24);
            _name1.center = img.center;
            UIEdgeInsets ed = UIEdgeInsetsMake(0, 10, 0, 10);
            [img.image resizableImageWithCapInsets:ed];
            [img setImage:[[UIImage imageNamed:@"bg_crumbs"] resizableImageWithCapInsets:ed]];
            [img addSubview:_name1];
            [self addSubview:img];
            [img release];
            self.length = self.length + _name1.bounds.size.width + 14;
            
            _name2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 24)];
            _name2.text = array[1];
            [self setLabel:_name2];
            [_name2 sizeToFit];
            UIImageView *img2 = [[UIImageView alloc] init];
            //img2.alpha = 0.7;
            img2.frame = CGRectMake(img.bounds.size.width + 5, 0, _name2.bounds.size.width + 14, 24);
            _name2.frame = CGRectMake(7, 0, _name2.bounds.size.width, 24);
            
            UIEdgeInsets ed2 = UIEdgeInsetsMake(0, 10, 0, 10);
            [img2.image resizableImageWithCapInsets:ed2];
            [img2 setImage:[[UIImage imageNamed:@"bg_crumbs"] resizableImageWithCapInsets:ed]];
            [img2 addSubview:_name2];
            [self addSubview:img2];
            [img2 release];
            self.length = self.length + _name2.bounds.size.width + 14 + 5;
            
            _name3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 24)];
            _name3.text = array[2];
            [self setLabel:_name3];
            [_name3 sizeToFit];
            UIImageView *img3 = [[UIImageView alloc] init];
            //img3.alpha = 0.7;
            img3.frame = CGRectMake(self.length + 5, 0, _name3.bounds.size.width + 14, 24);
            _name3.frame = CGRectMake(7, 0, _name3.bounds.size.width, 24);
            
            UIEdgeInsets ed3 = UIEdgeInsetsMake(0, 10, 0, 10);
            [img3.image resizableImageWithCapInsets:ed3];
            [img3 setImage:[[UIImage imageNamed:@"bg_crumbs"] resizableImageWithCapInsets:ed]];
            [img3 addSubview:_name3];
            [self addSubview:img3];
            [img3 release];
            self.length = self.length + _name3.bounds.size.width + 14 + 5;

        }
    }
    return self;
}

- (void)setLabel:(UILabel *)label {
    label.font = [UIFont boldSystemFontOfSize:15];
    label.textColor = [UIColor whiteColor];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
