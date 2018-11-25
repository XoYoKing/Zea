//
//  GQHMapController.h
//  Xanthium
//
//  Created by GuanQinghao on 23/04/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import "GQHBaseController.h"


@interface GQHMapController : GQHBaseController

/// 起始地latitude纬度
@property (nonatomic, copy) NSString *qh_departureLatitude;
/// 起始地longitude经度
@property (nonatomic, copy) NSString *qh_departureLongitude;
/// 目的地latitude纬度
@property (nonatomic, copy) NSString *qh_destinationLatitude;
/// 目的地longitude经度
@property (nonatomic, copy) NSString *qh_destinationLongitude;

/// 车辆ID
@property (nonatomic, copy) NSString *qh_truckID;

@end
