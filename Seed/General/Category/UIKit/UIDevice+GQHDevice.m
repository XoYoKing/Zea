//
//  UIDevice+GQHDevice.m
//  Seed
//
//  Created by GuanQinghao on 21/03/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import "UIDevice+GQHDevice.h"

#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <sys/sysctl.h>
#import <mach/mach.h>


@implementation UIDevice (GQHDevice)

/// 运营商信息
- (NSString *)qh_carrierName {
    
    NSString *carrierName = @"";
    
    CTTelephonyNetworkInfo *netInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [netInfo subscriberCellularProvider];
    
    if (carrier) {
        
        carrierName = [[carrier carrierName] copy];
    }
    
    return carrierName;
}

/// 运营商代码
- (NSString *)qh_carrierCode {
    
    NSString *carrierCode = @"";
    
    CTTelephonyNetworkInfo *netInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [netInfo subscriberCellularProvider];
    
    if (carrier) {
        
        NSString *mcc = [carrier mobileCountryCode];
        NSString *mnc = [carrier mobileNetworkCode];
        carrierCode = [NSString stringWithFormat:@"%@%@", mcc, mnc];
    }
    
    return carrierCode;
}

/// 手机磁盘总量(GB)
- (CGFloat)qh_diskTotalSize {
    
    CGFloat size = 0.0f;
    NSError *error;
    NSDictionary *dictionary = [NSFileManager.defaultManager attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    
    if (error) {
        
        NSLog(@"error: %@", error.localizedDescription);
    } else {
        
        NSNumber *number = [dictionary objectForKey:NSFileSystemSize];
        size = [number doubleValue]/1000.0f/1000.0f/1000.0f;
    }
    
    return size;
}

/// 手机可用磁盘容量(GB)
- (CGFloat)qh_diskFreeSize {
    
    CGFloat size = 0.0f;
    NSError *error;
    NSDictionary *dictionary = [NSFileManager.defaultManager attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    
    if (error) {
        
        NSLog(@"error: %@", error.localizedDescription);
    } else {
        
        NSNumber *number = [dictionary objectForKey:NSFileSystemFreeSize];
        size = [number doubleValue]/1000.0f/1000.0f/1000.0f;
    }
    
    return size;
}

/// 手机可用内存容量
- (CGFloat)qh_memoryFreeSize {
    
    vm_statistics_data_t vmStatus;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t) & vmStatus, &infoCount);
    
    if (kernReturn != KERN_SUCCESS) {
        
        return NSNotFound;
    }
    
    return (vm_page_size * vmStatus.free_count) / 1000.0f / 1000.0f;
}

@end
