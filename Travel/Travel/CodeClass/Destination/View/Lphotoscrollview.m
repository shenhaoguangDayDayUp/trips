//
//  Lphotoscrollview.m
//  Travel
//
//  Created by lanou3g on 15/9/25.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "Lphotoscrollview.h"

#import "UILabel+VerticalAlignment.h"
@implementation Lphotoscrollview
- (void)dealloc{
    [_scrollview release];
    [_titleLabel release];
    [_nameLabel release];
    [_timeLabel release];
    [_textLabel release];
    [_headerview release];
    [_picimage1 release];
    [_picimage2 release];
    [super dealloc];
}
-(instancetype)initWithFrame:(CGRect)frame photoArray:(NSArray *)photoArray target:(id)target index:(NSInteger)index{
    self = [super initWithFrame:frame];
    self.indexpath = index;
    self.imageArray = photoArray;
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        self.contentSize = CGSizeMake(kWidth * 3, 0);
        self.pagingEnabled = YES;
        self.delegate = target;
        for(int i = 0;i < 3;i++){
//            NSLog(@"%d",photoArray.count);
            _scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(i*kWidth, 0, kWidth, kHeight)];
            _scrollview.delegate = self;
            _scrollview.minimumZoomScale = 1;
            _scrollview.maximumZoomScale = 2;
            _scrollview.tag = 1000+i;
            _scrollview.contentSize = CGSizeMake(kWidth, kWidth);
            [self addSubview:_scrollview];
            
            LPhotoModel *model = nil;
            if (index == 0) {
                model = photoArray[index + i];
                self.contentOffset = CGPointMake(0, 0);
            }else if(index == photoArray.count - 1)
            {
                model = photoArray[index - 2 + i];
                self.contentOffset = CGPointMake(kWidth * 2, 0);
            }else{
                model = photoArray[index - 1 + i];
                self.contentOffset = CGPointMake(kWidth, 0);
            }
            
            
           
            float picH = 0;
            if (![model.w isEqualToString:@"0"]) {
                picH = kWidth * [model.h floatValue] / [model.w floatValue];
                if (picH >= 330) {
                    picH = 330;
                }
            }
            UIImageView *picimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWidth, picH)];
            //picimage.backgroundColor = [UIColor redColor];
            picimage.tag = 2000+i;
            picimage.clipsToBounds = YES;
           picimage.contentMode = UIViewContentModeScaleAspectFill;
            NSArray *str = [model.photo componentsSeparatedByString:@"?"];
            [picimage sd_setImageWithURL:[NSURL URLWithString:str[0]]];
            picimage.center = CGPointMake(kWidth/2, kHeight/2);
            [_scrollview addSubview:picimage];
            [picimage release];
            
            
            _headerview = [[UIView alloc] initWithFrame:CGRectMake(0, 0 , kWidth, 64)];
            _headerview.backgroundColor = [UIColor blackColor];
            _headerview.alpha = 0.5;
            _headerview.userInteractionEnabled = YES;
            [_scrollview addSubview:_headerview];
            
            
            _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kWidth, 64)];
            _titleLabel.text = model.trip_name;
            _titleLabel.tag = 6000 + i;
            _titleLabel.textColor = [UIColor whiteColor];
            _titleLabel.textAlignment = 1;
            _titleLabel.font = [UIFont systemFontOfSize:18];
            [_headerview addSubview:_titleLabel];
            
            
            UIView *footview = [[UIView alloc] initWithFrame:CGRectMake(0, 567.0/kAutoHight, kWidth, 100)];
            //footview.backgroundColor = [UIColor whiteColor];
            footview.alpha = 0.5;
            [_scrollview addSubview:footview];

            _picimage1 = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth/(375/10.0), kHeight/(667/65.0), 20, 20)];
            _picimage1.image = [UIImage imageNamed:@"attraction_icon"];
            [footview addSubview:_picimage1];
            
            _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_picimage1.frame.origin.x + 20, _picimage1.frame.origin.y, 130, 20)];
            //_nameLabel.backgroundColor = [UIColor redColor];
            _nameLabel.tag = 3000 + i;
            _nameLabel.textColor = [UIColor whiteColor];
            _nameLabel.font = [UIFont systemFontOfSize:14];
            _nameLabel.text = [model.poi objectForKey:@"name"];
            [footview addSubview:_nameLabel];
            
            _picimage2 = [[UIImageView alloc] initWithFrame:CGRectMake(_nameLabel.frame.origin.x + 100, kHeight/(667/75), 20, 20)];
            _picimage2.image = [UIImage imageNamed:@"trip_edit_section_time~ipad"];
            [footview addSubview:_picimage2];
            
            _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(_picimage2.frame.origin.x + 40, _picimage1.frame.origin.y, 150, 20)];
            //_timeLabel.backgroundColor = [UIColor redColor];
            _timeLabel.tag = 4000+i;
            _timeLabel.font = [UIFont systemFontOfSize:14];
            _timeLabel.textColor = [UIColor whiteColor];
            _timeLabel.text = model.local_time;
            [footview addSubview:_timeLabel];
            
            _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0/kAutoWidth, -(30.0/kAutoHight), kWidth-20, 85)];
            _textLabel.textColor = [UIColor whiteColor];
            _textLabel.tag = 5000+i;
            _textLabel.numberOfLines = 0;
           // _textLabel.verticalAlignment = NSVerticalAlignmentTop;
            _textLabel.text = model.text;
            _textLabel.font = [UIFont systemFontOfSize:14];
            [footview addSubview:_textLabel];
            [footview release];
            

        
    }
        self.contentOffset = CGPointMake(kWidth , 0);
    }
    return self;
}

- (void)scrolltolastPic{
    if (self.indexpath > 1) {
        self.indexpath -= 1;
        if (self.indexpath == self.imageArray.count - 2) {
            self.indexpath = self.imageArray.count - 3;
        }
        for(int i = 0;i < 3;i++){
            LPhotoModel *model = self.imageArray[self.indexpath - 1 + i];
            [self setscrollviewWithIndex:i model:model];
        }
        self.contentOffset = CGPointMake(kWidth, 0);
    }
}

- (void)scrolltonextPic{
    if (self.indexpath < self.imageArray.count - 2) {
        self.indexpath += 1;
        if (self.indexpath == 1) {
            self.indexpath = 2;
        }
        for(int i = 0;i < 3;i++){
            LPhotoModel *model = self.imageArray[self.indexpath - 1 + i];
            [self setscrollviewWithIndex:i model:model];
        }
        self.contentOffset = CGPointMake(kWidth, 0);
    }
}

- (void)setscrollviewWithIndex:(int)i model:(LPhotoModel *)model{
        UIScrollView *scrollview = (UIScrollView *)[self viewWithTag:1000 + i];
        scrollview.zoomScale = 1.0;
    
    UIImageView *image = (UIImageView *)[self viewWithTag:2000 + i];
    image.clipsToBounds = YES;
    image.contentMode = UIViewContentModeScaleAspectFill;
    CGRect frame = image.frame;
    float picH = 0;
    if (![model.w isEqualToString:@"0"]) {
        picH = kWidth * [model.h floatValue] / [model.w floatValue];
        if (picH >= 330) {
            picH = 330;
        }
    }
    frame.size.height = picH;
    image.frame = frame;
    image.center = CGPointMake(kWidth/2, kHeight/2);
    UILabel *nameLanel = (UILabel *)[self viewWithTag:3000 + i];
    UILabel *timeLabel = (UILabel *)[self viewWithTag:4000 + i];
    UILabel *textLabel = (UILabel *)[self viewWithTag:5000 + i];
    UILabel *titlelabel1 = (UILabel *)[self viewWithTag:6000 + i];
    NSArray *str = [model.photo componentsSeparatedByString:@"?"];
    [image sd_setImageWithURL:[NSURL URLWithString:str[0]]];
    nameLanel.text = [model.poi objectForKey:@"name"];
    timeLabel.text = model.local_time;
    textLabel.text = model.text;
    titlelabel1.text = model.trip_name;
    


}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
