//
//  CustomAnnotation.m
//  Travel
//
//  Created by lanou3g on 15/9/23.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "CustomAnnotation.h"

@implementation CustomAnnotation
-(void)dealloc{
    [_title release];
    [_subtitle release];
    [super dealloc];
}
- (id)initWithCoordinate:(CLLocationCoordinate2D)coords{
    if (self = [super init]) {
        _coordinate = coords;
    }
    return self;
}

@end
