//
//  GQHImagePickerConfiger.h
//  GQHKit
//
//  Created by GuanQinghao on 30/01/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GQHImagePickerConfiger : NSObject

// 应用首选语言
@property (nonatomic, copy) NSString *qh_preferredLanguage;

// 语言资源包
@property (nonatomic, strong) NSBundle *qh_languageBundle;

// 图片可选
@property (nonatomic, assign) BOOL qh_isSelectableImage;

// 视频可选
@property (nonatomic, assign) BOOL qh_isSelectableVideo;


// 图片选择配置单例
+ (instancetype)qh_sharedImagePickerConfiger;

@end
