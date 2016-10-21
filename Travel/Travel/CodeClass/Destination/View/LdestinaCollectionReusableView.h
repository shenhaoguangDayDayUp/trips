//
//  LdestinaCollectionReusableView.h
//  Travel
//
//  Created by lanou3g on 15/9/18.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LdestinationModel.h"
@interface LdestinaCollectionReusableView : UICollectionReusableView
//标头标题
@property (nonatomic,retain) UILabel *titleLabel;
//更多国家按钮
@property (nonatomic,retain) UIButton *Morebutton;
//标头颜色
@property (nonatomic,retain) UILabel *colorLbel;


@end
