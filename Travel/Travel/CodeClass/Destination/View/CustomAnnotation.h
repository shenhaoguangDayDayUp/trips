//
//  CustomAnnotation.h
//  Travel
//
//  Created by lanou3g on 15/9/23.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface CustomAnnotation : NSObject<MKAnnotation>{
}

- (id)initWithCoordinate:(CLLocationCoordinate2D)coords;
@property (nonatomic,readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *subtitle;
@end
