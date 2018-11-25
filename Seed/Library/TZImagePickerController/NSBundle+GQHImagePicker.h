//
//  NSBundle+GQHImagePicker.h
//  GQHKit
//
//  Created by GuanQinghao on 29/01/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSBundle (GQHImagePicker)

+ (NSBundle *)qh_imagePickerBundle;

+ (NSString *)qh_localizedStringForKey:(NSString *)key;

+ (NSString *)qh_localizedStringForKey:(NSString *)key value:(NSString *)vlaue;

@end
