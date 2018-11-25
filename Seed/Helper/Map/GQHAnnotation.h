//
//  GQHAnnotation.h
//  Xanthium
//
//  Created by GuanQinghao on 26/04/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


typedef enum : NSUInteger {
    GQHAnnotationTypeDefaut, // 默认系统样式
    GQHAnnotationTypeCar, // 车辆样式
} GQHAnnotationType;


@interface GQHAnnotation : NSObject <MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy, nullable) NSString *title;
@property (nonatomic, copy, nullable) NSString *subtitle;
@property (nonatomic, assign) GQHAnnotationType type;

@end
