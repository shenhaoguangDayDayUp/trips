//
//  PositionViewController.m
//  Travel
//
//  Created by lanou3g on 15/9/23.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "PositionViewController.h"
#import "CustomAnnotation.h"
@interface PositionViewController ()

@end

@implementation PositionViewController

- (void)viewDidLoad {
    // Do any additional setup after loading the view.
    map = [[MKMapView alloc] initWithFrame:[self.view bounds]];
    map.showsUserLocation = YES;
    map.mapType = MKMapTypeStandard;
    [self.view addSubview:map];
    
    //返回按钮
    UIButton *backbutton = [UIButton buttonWithType:(UIButtonTypeInfoLight)];
    backbutton.frame = CGRectMake(20/kAutoWidth, 20/kAutoHight, 30, 30);
    [backbutton setImage:[UIImage imageNamed:@"add_new_poi_back_btn"] forState:(UIControlStateNormal)];
    backbutton.tintColor = kBrownColor;
    [backbutton addTarget:self action:@selector(backbutton) forControlEvents:(UIControlEventTouchUpInside)];
    [map addSubview:backbutton];
    
    [super viewDidLoad];
    //指定的经纬度
    
    float lat = [[self.Position objectForKey:@"lat"] floatValue];
    float lng = [[self.Position objectForKey:@"lng"] floatValue];
    
    CLLocationCoordinate2D coords = CLLocationCoordinate2DMake(lat, lng);
    float zoomLevel = 0.02;
    MKCoordinateRegion region = MKCoordinateRegionMake(coords, MKCoordinateSpanMake(zoomLevel, zoomLevel));
    [map setRegion:[map regionThatFits:region] animated:YES];
    
    [self createAnnotationWithCoords:coords];
    
    //定位到当前位置并获取当前的经纬度
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
}

- (void)backbutton{
    [self dismissViewControllerAnimated:NO completion:nil];
}


#pragma mark ------实现协议方法收到定位成功后的经纬度--------
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    [ locationManager stopUpdatingLocation];
    
    NSString *strLat = [NSString stringWithFormat:@"%.4f",newLocation.coordinate.latitude];
    NSString *strLng = [NSString stringWithFormat:@"%.4f",newLocation.coordinate.longitude];
    //NSLog(@"Lat:%@ Lng:%@",strLat,strLng);
    
    CLLocationCoordinate2D coords = CLLocationCoordinate2DMake(newLocation.coordinate.latitude, newLocation.coordinate.longitude);
    float zoomLevel = 0.02;
    MKCoordinateRegion region = MKCoordinateRegionMake(coords, MKCoordinateSpanMake(zoomLevel, zoomLevel));
    
    [map setRegion:[map regionThatFits:region] animated:YES];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    //NSLog(@"locError%@",error);
}





-(void)createAnnotationWithCoords:(CLLocationCoordinate2D) coords {
    CustomAnnotation *annotation = [[CustomAnnotation alloc] initWithCoordinate:
                                    coords];
    annotation.title = self.name;
    annotation.subtitle = nil;
    [map addAnnotation:annotation];
    [annotation release];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
