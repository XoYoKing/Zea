//
//  GQHImagePickerConfiger.m
//  GQHKit
//
//  Created by GuanQinghao on 30/01/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import "GQHImagePickerConfiger.h"
#import "NSBundle+GQHImagePicker.h"

@implementation GQHImagePickerConfiger

+ (instancetype)qh_sharedImagePickerConfiger {
    
    static GQHImagePickerConfiger *configer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        configer = [[GQHImagePickerConfiger alloc] init];
        configer.qh_preferredLanguage = nil;
    });
    
    return configer;
}

- (void)setQh_preferredLanguage:(NSString *)qh_preferredLanguage {
    
    _qh_preferredLanguage = qh_preferredLanguage;
    
    if (!qh_preferredLanguage || !qh_preferredLanguage.length) {
        
        qh_preferredLanguage = [NSLocale preferredLanguages].firstObject;
    }
    if ([qh_preferredLanguage rangeOfString:@"zh-Hans"].location != NSNotFound) {
        
        qh_preferredLanguage = @"zh-Hans";
    } else if ([qh_preferredLanguage rangeOfString:@"zh-Hant"].location != NSNotFound) {
        
        qh_preferredLanguage = @"zh-Hant";
    } else {
        
        qh_preferredLanguage = @"en";
    }
    
    _qh_languageBundle = [NSBundle bundleWithPath:[[NSBundle qh_imagePickerBundle] pathForResource:qh_preferredLanguage ofType:@"lproj"]];
}

@end

