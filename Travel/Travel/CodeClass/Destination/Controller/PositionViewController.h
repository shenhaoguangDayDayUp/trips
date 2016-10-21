//
//  PositionViewController.h
//  Travel
//
//  Created by lanou3g on 15/9/23.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
@interface PositionViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate>{
    MKMapView *map;
    CLLocationManager *locationManager;

}
@property (nonatomic,retain) NSDictionary *Position;
@property (nonatomic,retain) NSString *name;

@end
