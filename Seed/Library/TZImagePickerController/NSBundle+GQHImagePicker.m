//
//  NSBundle+GQHImagePicker.m
//  GQHKit
//
//  Created by GuanQinghao on 29/01/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import "NSBundle+GQHImagePicker.h"
#import "GQHImagePickerController.h"
#import "GQHImagePickerConfiger.h"

@implementation NSBundle (GQHImagePicker)

+ (NSBundle *)qh_imagePickerBundle {
    
    NSBundle *bundle = [NSBundle bundleForClass:[GQHImagePickerController class]];
    NSURL *url = [bundle URLForResource:@"TZImagePickerController" withExtension:@"bundle"];
    bundle = [NSBundle bundleWithURL:url];
    
    return bundle;
}

+ (NSString *)qh_localizedStringForKey:(NSString *)key {
    
    return [self qh_localizedStringForKey:key value:@""];
}

+ (NSString *)qh_localizedStringForKey:(NSString *)key value:(NSString *)vlaue {
    
    NSBundle *bundle = [GQHImagePickerConfiger qh_sharedImagePickerConfiger].qh_languageBundle;
    
    return [bundle localizedStringForKey:key value:vlaue table:nil];
}

@end
