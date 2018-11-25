//
//  GQHMapController.m
//  Xanthium
//
//  Created by GuanQinghao on 23/04/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#pragma mark Macro
#import "GQHHeader.h"

#pragma mark Model

#pragma mark Object
#import "GQHAnnotation.h"
#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotation.h>
#import <CoreLocation/CoreLocation.h>

#pragma mark View

#pragma mark Controller
#import "GQHMapController.h"

#pragma mark CocoaPods

#pragma mark ----------Header End----------

@interface GQHMapController () <MKMapViewDelegate,MKAnnotation,CLLocationManagerDelegate,MKAnnotation> {
    
#pragma mark Data
    /// 车辆位置
    CLLocation *truckLocation;
    /// 定位管理器
    CLLocationManager *locationManager;
#pragma mark View
    /// 地图
    MKMapView *mapView;
}

@end


@implementation GQHMapController

#pragma mark --Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    DLog();
    
    /// 加载地图
    [self loadMapView];
    
    /// 加载车辆定位
    [self loadUserLocation];
    [self loadTruckLocation];
    
    /// 加载规划路线
    [self loadDirections];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    DLog();
    
    [self.qh_titleButton setTitle:@"路线信息" forState:UIControlStateNormal];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    DLog();
    
}

#pragma mark --Delegate
/// 自定义大头针
- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
    
    if ([annotation isKindOfClass:[GQHAnnotation class]]) {
        
        static NSString *identifier = @"annotation";
        MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (!annotationView) {
            
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        }
        
        GQHAnnotation *customAnnotation = annotation;
        if (customAnnotation.type == GQHAnnotationTypeCar) {
            
            annotationView.image = [UIImage imageNamed:@"me_from_to"];
            annotationView.canShowCallout = YES;
            
            return annotationView;
        }
    }
    
    return nil;
}

/// 渲染地图遮盖视图 (规划路线图)
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        
        MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
        
        renderer.strokeColor = [UIColor redColor];
        renderer.lineWidth = 3.0f;
        renderer.lineJoin = kCGLineJoinRound;
        renderer.lineCap = kCGLineCapRound;
        
        return renderer;
    }
    
    return nil;
}

#pragma mark --TargetMethod

#pragma mark --PrivateMethod
/// 获取车辆定位信息
- (void)loadTruckLocation {
    
//    if (_qh_truckID) {
//
//        /// 获取车辆位置
//        NSString *APIURLString = [[NSString qh_APIURLString] stringByAppendingPathComponent:@"/localtion/1/list"];
//        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//        [parameters setObject:_qh_truckID forKey:@"userId"];
//
//        [GQHNetHelper qh_requestGET:APIURLString parameters:parameters success:^(NSNumber *code, NSString *message, NSDictionary *data) {
//            DLog(@"%@---%@---%@",code,message,data);
//
//            if (0 == [code integerValue]) {
//
//                NSArray *truckLocationArray = [data objectForKey:@"list"];
//                NSDictionary *truckLocationDictionary = [truckLocationArray lastObject];
//
//                /// 重置定位
//                CLLocationCoordinate2D truckCoordinate;
//                if (![[truckLocationDictionary objectForKey:@"latitude"] isKindOfClass:[NSNull class]]) {
//
//                    // latitude纬度
//                    truckCoordinate.latitude = [[truckLocationDictionary objectForKey:@"latitude"] doubleValue];
//                } else {
//
//                    // latitude纬度
//                    truckCoordinate.latitude = 34.234805;
//                }
//                if (![[truckLocationDictionary objectForKey:@"longitude"] isKindOfClass:[NSNull class]]) {
//
//                    // longitude经度
//                    truckCoordinate.longitude = [[truckLocationDictionary objectForKey:@"longitude"] doubleValue];
//                } else {
//
//                    // longitude经度
//                    truckCoordinate.longitude = 108.942165;
//                }
//
//                truckLocation = [[CLLocation alloc] initWithLatitude:truckCoordinate.latitude longitude:truckCoordinate.longitude];
//
//                /// 重置地图视图中心为车辆位置
//                [self resetMapViewWithLocation:truckLocation];
//
//                /// 设置车辆大头针
//                GQHAnnotation *annotation = [[GQHAnnotation alloc] init];
//                annotation.coordinate = truckLocation.coordinate;
//                annotation.title = @"运输车辆";
//                [mapView addAnnotation:annotation];
//
//            } else {
//
//                [self showToastWithText:message];
//            }
//        } failure:^(NSError *error) {
//
//            NSString *errorString = [NSString stringWithFormat:@"网络出错:%@,code:%ld", error.domain, (long)error.code];
//            [self showToastWithText:errorString];
//        }];
//    }
}

/// 获取用户定位信息
-(void)loadUserLocation{
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = 500;
    locationManager.allowsBackgroundLocationUpdates = YES;
    
    if ([CLLocationManager locationServicesEnabled]) {
        DLog(@"设备启用定位服务");
        
        /// 检测当前应用程序的定位服务权限状态
        CLAuthorizationStatus authorizationStatus = [CLLocationManager authorizationStatus];
        
        if (authorizationStatus == kCLAuthorizationStatusAuthorizedAlways || authorizationStatus == kCLAuthorizationStatusAuthorizedWhenInUse) {
            
            /// 定位服务权限状态为 Always 或 WhenInUse, 开始定位
            [locationManager startUpdatingLocation];
        } else {
            
            /// 请求定位服务权限 Always 状态
            if ([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
                
                [locationManager requestAlwaysAuthorization];
            }
        }
    } else {
        NSLog(@"设备未启用定位服务 (关闭定位服务、飞行模式)");
        
        /// 弹窗提醒开启设备定位服务
//        [[[UIApplication sharedApplication] keyWindow] showToastWithText:@"定位服务未授权，请授权定位服务以便获取位置信息"];
    }
}

/// 准备规划路线
- (void)loadDirections {
    
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    
    double departureLatitude = [_qh_departureLatitude doubleValue];
    double departureLongitude = [_qh_departureLongitude doubleValue];
    CLLocationCoordinate2D departureLocation = CLLocationCoordinate2DMake(departureLatitude, departureLongitude);
    /// 设置起始地大头针
    GQHAnnotation *departureAnnotation = [[GQHAnnotation alloc] init];
    departureAnnotation.coordinate = departureLocation;
    departureAnnotation.title = @"起始地";
    [mapView addAnnotation:departureAnnotation];
    
    double destinationLatitude = [_qh_destinationLatitude doubleValue];
    double destinationLongitude = [_qh_destinationLongitude doubleValue];
    CLLocationCoordinate2D destinationLocation = CLLocationCoordinate2DMake(destinationLatitude, destinationLongitude);
    /// 设置起始地大头针
    GQHAnnotation *destinationAnnotation = [[GQHAnnotation alloc] init];
    destinationAnnotation.coordinate = destinationLocation;
    destinationAnnotation.title = @"目的地";
    [mapView addAnnotation:destinationAnnotation];
    
    if (departureLatitude != 0 && departureLongitude != 0 && destinationLatitude != 0 && destinationLongitude != 0) {
        
        CLLocation *departureLocation = [[CLLocation alloc] initWithLatitude:departureLatitude longitude:departureLongitude];
        CLLocation *destinationLocation = [[CLLocation alloc] initWithLatitude:destinationLatitude longitude:destinationLongitude];
        
        /// 地理编码 根据经纬度获取地图位置，误差较大
        [geoCoder reverseGeocodeLocation:departureLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            
            MKMapItem *departureItem = [[MKMapItem alloc]initWithPlacemark:[[MKPlacemark alloc]initWithPlacemark:[placemarks lastObject]]];
            
            /// 让地图跳转到起点所在的区域
            [self resetMapViewWithLocation:departureLocation];
            
            [geoCoder reverseGeocodeLocation:destinationLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
                
                MKMapItem *destinationItem = [[MKMapItem alloc]initWithPlacemark:[[MKPlacemark alloc]initWithPlacemark:[placemarks lastObject]]];
                /// 规划路线
                [self directionsWith:departureItem destination:destinationItem];
            }];
        }];
    }
}

/// 根据起始地和目的地规划路线
- (void)directionsWith:(MKMapItem *)departure destination:(MKMapItem *)destination {
    
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
    request.source = departure;
    request.destination = destination;
    
    MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse * _Nullable response, NSError * _Nullable error) {
        
        NSArray<MKRoute *> *routeArray = response.routes;
        
        /**
        /// 显示所有路线
        for (MKRoute *route in routeArray) {
            
            NSArray <MKRouteStep *> *stepArray = route.steps;
            for (MKRouteStep *step in stepArray) {
                
                [mapView addOverlay:step.polyline];
            }
        }
         */
        
        /// 显示最后一条路线
        NSArray <MKRouteStep *> *stepArray = [routeArray lastObject].steps;
        for (MKRouteStep *step in stepArray) {
            
            [mapView addOverlay:step.polyline];
        }
    }];
}

/// 重置地图视图位置
- (void)resetMapViewWithLocation:(CLLocation *)location {
    
    
    /// 定义显示的范围 span 范围
    MKCoordinateSpan theSpan = MKCoordinateSpanMake(10, 10);
    /// 定义显示的区域 region 区域范围
    MKCoordinateRegion theRegion = MKCoordinateRegionMake(location.coordinate, theSpan);
    /// 设置地图显示
    [mapView setRegion:theRegion];
}

#pragma mark --Setter

#pragma mark --Getter

#pragma mark --View
/// 初始化地图
- (void)loadMapView {
    
    mapView = [[MKMapView alloc] init];
    mapView.delegate = self;
    mapView.showsCompass = YES;
    mapView.showsScale = YES;
    mapView.showsUserLocation = YES;
    mapView.mapType = MKMapTypeStandard;
    mapView.userTrackingMode = MKUserTrackingModeFollow;
    [self.view addSubview:mapView];
    [mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.view).with.inset(self.view.qh_statusBarHeight + self.view.qh_navigationBarHeight);
        make.left.and.right.and.bottom.mas_equalTo(self.view);
    }];
}

@end
