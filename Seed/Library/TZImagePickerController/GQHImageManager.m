//
//  GQHImageManager.m
//  GQHKit
//
//  Created by GuanQinghao on 31/01/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#define SCREEN_WIDTH    CGRectGetWidth([UIScreen mainScreen].bounds)            // 屏幕的总宽度

#import "GQHImageManager.h"
#import "GQHAssetModel.h"
#import "GQHAlbumModel.h"
#import "GQHImagePickerConfiger.m"
#import "GQHImagePickerController.h"
#import <ImageIO/ImageIO.h>


@interface GQHImageManager () <GQHImagePickerControllerDelegate> {
    
    CGSize assetGridThumbnailSize;
    CGFloat scale;
}

@end


@implementation GQHImageManager
#pragma mark --Lifecycle  生命周期
#pragma mark --Delegate  代理
#pragma mark --EventMethod
#pragma mark --PrivateMethod  私有方法
#pragma mark --PublicMethod  共有方法
#pragma mark --Setter
#pragma mark --Getter



+ (instancetype)qh_manager {
    
    static GQHImageManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[GQHImageManager alloc] init];
        [manager configureScale];
    });
    
    return manager;
}

- (void)configureScale {
    
    scale = 2.0f;
    if (SCREEN_WIDTH > 700) {
        
        scale = 1.5f;
    }
}

// 某资源是否包含在资源数组中
- (BOOL)qh_containsAsset:(PHAsset *)asset withinAssetArray:(NSArray<PHAsset *> *)assetArray {
    
    return [assetArray containsObject:asset];
}

// 从资源查询结果中获取资源
- (void)qh_fetchAssetsFromResult:(PHFetchResult *)result completion:(void(^)(NSArray<GQHAssetModel *> *))completion {
    
    GQHImagePickerConfiger *configer = [GQHImagePickerConfiger qh_sharedImagePickerConfiger];
    [self qh_fetchAssetsFromResult:result selectableImage:configer.qh_isSelectableImage selectableVideo:configer.qh_isSelectableVideo completion:completion];
    
}

- (void)qh_fetchAssetsFromResult:(PHFetchResult *)result
                 selectableImage:(BOOL)isSelectableImage
                 selectableVideo:(BOOL)isSelectableVideo
                      completion:(void(^)(NSArray<GQHAssetModel *> *))completion {
    
    NSMutableArray *assetArray = [NSMutableArray array];
    [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        GQHAssetModel *assetModel = [self qh_fetchAssetModelWithAsset:obj selectableImage:isSelectableImage selectableVideo:isSelectableVideo];
        if (assetModel) {
            
            [assetArray addObject:assetModel];
        }
    }];
    if (completion) {
        
        completion(assetArray);
    }
}

- (GQHAssetModel *)qh_fetchAssetModelWithAsset:(id)asset selectableImage:(BOOL)isSelectableImage selectableVideo:(BOOL)isSelectableVideo {
    
    BOOL selectable = YES;
    if ([self.qh_delegate respondsToSelector:@selector(qh_isSelectable:)]) {
        
        selectable = [self.qh_delegate qh_isSelectable:asset];
    }
    if (!selectable) {
        
        return nil;
    }
    
    GQHAssetModel *assetModel;
    GQHAssetModelMediaType mediaType = [self assetMediaType:asset];
    
    if (!isSelectableVideo && mediaType == GQHAssetModelMediaTypeVideo) {
        
        return nil;
    }
    if (!isSelectableImage && mediaType == GQHAssetModelMediaTypePhoto) {
        
        return nil;
    }
    if (!isSelectableImage && mediaType == GQHAssetModelMediaTypeGIFPhoto) {
        
        return nil;
    }
    PHAsset *phAsset = (PHAsset *)asset;
    if (self.qh_hidesIfUnselectable) {
        
        if (![self qh_checkSelectableStatusWithAsset:phAsset]) {
            
            return nil;
        }
    }
    NSString *duration = mediaType == GQHAssetModelMediaTypeVideo ? [NSString stringWithFormat:@"%.0f",phAsset.duration] : @"0";
    duration = [self timeFormatWithDuration:duration.integerValue];
    assetModel = [GQHAssetModel qh_modelWithAsset:phAsset mediaType:mediaType duration:duration];
    
    return assetModel;
}

// 秒数转时分秒 (不超过100小时)
- (NSString *)timeFormatWithDuration:(NSUInteger)duration {
    
    NSString *time;
    NSInteger second = duration % 60;
    NSInteger minute = duration % 3600 / 60;
    NSInteger hour = duration / 3600;
    if (duration < 3600) {
        
        time = [NSString stringWithFormat:@"%02lu:%02lu",minute,second];
    } else {
        
        time = [NSString stringWithFormat:@"%02lu:%02lu:%02lu",hour,minute,second];
    }
    
    return time;
}

// 资源媒体类型(不支持现场照片)
- (GQHAssetModelMediaType)assetMediaType:(PHAsset *)asset {
    
    GQHAssetModelMediaType mediaType = GQHAssetModelMediaTypePhoto;
    if (asset.mediaType == PHAssetMediaTypeVideo) {
        
        mediaType = GQHAssetModelMediaTypeVideo;
    }
    if (asset.mediaType == PHAssetMediaTypeAudio) {
        
        mediaType = GQHAssetModelMediaTypeAudio;
    }
    if (asset.mediaType == PHAssetMediaTypeImage) {
        
        if ([[asset valueForKey:@"filename"] hasSuffix:@"GIF"]) {
            
            mediaType = GQHAssetModelMediaTypeGIFPhoto;
        }
    }
    
    return mediaType;
}

// 检查照片大小是否满足最小可选要求
- (BOOL)qh_checkSelectableStatusWithAsset:(PHAsset *)asset {
    
    CGSize size = CGSizeMake(asset.pixelWidth, asset.pixelHeight);
    if (self.qh_minSelectableWidth > size.width || self.qh_minSelectableHeight > size.height) {
        
        return NO;
    }
    return YES;
}


// 获取相册的照片
- (int32_t)qh_fetchPhotoWithAsset:(PHAsset *)asset
                completionHandler:(void (^)(UIImage *photo, NSDictionary *info, BOOL isDegraded))completionHandler {
    
    CGFloat photoWidth = SCREEN_WIDTH;
    if (photoWidth > _qh_photoPreviewMaxWidth) {
        
        photoWidth = _qh_photoPreviewMaxWidth;
    }
    
    return [self qh_fetchPhotoWithAsset:asset
                             photoWidth:photoWidth
                   networkAccessAllowed:YES
                        progressHandler:nil
                      completionHandler:completionHandler];
}

// 获取相册里的照片
- (int32_t)qh_fetchPhotoWithAsset:(PHAsset *)asset
                       photoWidth:(CGFloat)photoWidth
                completionHandler:(void (^)(UIImage *photo, NSDictionary *info, BOOL isDegraded))completionHandler {
    
    return [self qh_fetchPhotoWithAsset:asset
                             photoWidth:photoWidth
                   networkAccessAllowed:YES
                        progressHandler:nil
                      completionHandler:completionHandler];
}

// 获取相册里的照片
- (int32_t)qh_fetchPhotoWithAsset:(PHAsset *)asset
             networkAccessAllowed:(BOOL)networkAccessAllowed
                  progressHandler:(void (^)(double progress, NSError *error, BOOL *stop, NSDictionary *info))progressHandler
                completionHandler:(void (^)(UIImage *photo, NSDictionary *info, BOOL isDegraded))completionHandler {
    
    CGFloat photoWidth = SCREEN_WIDTH;
    if (photoWidth > _qh_photoPreviewMaxWidth) {
        
        photoWidth = _qh_photoPreviewMaxWidth;
    }
    
    return [self qh_fetchPhotoWithAsset:asset
                             photoWidth:photoWidth
                   networkAccessAllowed:networkAccessAllowed
                        progressHandler:progressHandler
                      completionHandler:completionHandler];
}

// 获取相册里的照片
- (int32_t)qh_fetchPhotoWithAsset:(PHAsset *)asset
                       photoWidth:(CGFloat)photoWidth
             networkAccessAllowed:(BOOL)networkAccessAllowed
                  progressHandler:(void (^)(double progress, NSError *error, BOOL *stop, NSDictionary *info))progressHandler
                completionHandler:(void (^)(UIImage *photo, NSDictionary *info, BOOL isDegraded))completionHandler {
    
    CGSize imageSize;
    if (photoWidth < SCREEN_WIDTH && photoWidth < _qh_photoPreviewMaxWidth) {
        
        imageSize = assetGridThumbnailSize;
    } else {
        
        CGFloat aspectRatio = asset.pixelWidth / asset.pixelHeight;
        CGFloat pixelWidth = photoWidth * scale * 1.5;
        
        // 超宽相片
        if (aspectRatio > 1.8) {
            
            pixelWidth = pixelWidth *aspectRatio;
        }
        // 超高相片
        if (aspectRatio < 0.2) {
            
            pixelWidth = pixelWidth * 0.5;
        }
        CGFloat pixelHeight = pixelWidth / aspectRatio;
        imageSize = CGSizeMake(pixelWidth, pixelHeight);
    }
    
    __block UIImage *aImage;
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.resizeMode = PHImageRequestOptionsResizeModeFast;
    int32_t imageRequestID = [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:imageSize contentMode:PHImageContentModeAspectFill options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        
        if (result) {
            
            aImage = result;
        }
        
        BOOL finished = (![[info objectForKey:PHImageCancelledKey] boolValue] && ![[info objectForKey:PHImageErrorKey] boolValue]);
        if (finished && result) {
            
            result = [self qh_fixOrientation:result];
            if (completionHandler) {
                
                completionHandler(result,info,[[info objectForKey:PHImageResultIsDegradedKey] boolValue]);
            }
        }
        
        // 从iCloud下载图片
        if ([info objectForKey:PHImageResultIsInCloudKey] && !result && networkAccessAllowed) {
            
            PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
            options.progressHandler = ^(double progress, NSError * _Nullable error, BOOL * _Nonnull stop, NSDictionary * _Nullable info) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    if (progressHandler) {
                        progressHandler(progress,error,stop,info);
                    };
                });
            };
            options.networkAccessAllowed = YES;
            options.resizeMode = PHImageRequestOptionsResizeModeFast;
            [[PHImageManager defaultManager] requestImageDataForAsset:asset options:options resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
                
                UIImage *image = [UIImage imageWithData:imageData scale:0.1];
                image = [self qh_scaleImage:image toSize:imageSize];
                if (!image) {
                    
                    image = aImage;
                }
                image = [self qh_fixOrientation:image];
                if (completionHandler) {
                    
                    completionHandler(image,info,NO);
                }
            }];
        }
    }];
    
    return imageRequestID;
}

// 修正图片转向
- (UIImage *)qh_fixOrientation:(UIImage *)aImage {
    
    if (!self.qh_isFixedOrientation) {
        
        return aImage;
    }
    if (aImage.imageOrientation == UIImageOrientationUp) {
        
        return aImage;
    }
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored: {
            
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
        }
            break;
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored: {
            
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
        }
            break;
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored: {
            
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
        }
            break;
        default:
            break;
    }
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored: {
            
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
        }
            break;
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored: {
            
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
        }
            break;
            
        default:
            break;
    }
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height, CGImageGetBitsPerComponent(aImage.CGImage), 0, CGImageGetColorSpace(aImage.CGImage), CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored: {
            
            CGContextDrawImage(ctx, CGRectMake(0, 0, aImage.size.height, aImage.size.width), aImage.CGImage);
        }
            break;
        default: {
            
            CGContextDrawImage(ctx, CGRectMake(0, 0, aImage.size.width, aImage.size.height), aImage.CGImage);
        }
            break;
    }
    
    CGImageRef cgImage = CGBitmapContextCreateImage(ctx);
    UIImage *image = [UIImage imageWithCGImage:cgImage];
    CGContextRelease(ctx);
    CGImageRelease(cgImage);
    
    return image;
}

// 图片缩放到指定尺寸
- (UIImage *)qh_scaleImage:(UIImage *)aImage toSize:(CGSize)size {
    
    if (aImage.size.width > size.width) {
        
        UIGraphicsBeginImageContext(size);
        [aImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return image;
    } else {
        
        return aImage;
    }
}

// 获取照片原图
- (void)qh_fetchOriginalPhotoWithAsset:(PHAsset *)asset completionHandler:(void (^)(UIImage *photo, NSDictionary *info, BOOL isDegraded))completionHandler {
    
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.networkAccessAllowed = YES;
    options.resizeMode = PHImageRequestOptionsResizeModeFast;
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeAspectFit options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        
        BOOL finished = (![[info objectForKey:PHImageCancelledKey] boolValue] && ![info objectForKey:PHImageErrorKey]);
        if (finished && result) {
            
            result = [self qh_fixOrientation:result];
            BOOL isDegraded = [[info objectForKey:PHImageResultIsDegradedKey] boolValue];
            
            if (completionHandler) {
                
                completionHandler(result,info,isDegraded);
            }
        }
    }];
}

// 获取照片原图
- (void)qh_fetchOriginalPhotoDataWithAsset:(PHAsset *)asset completionHandler:(void (^)(NSData *data, NSDictionary *info, BOOL isDegraded))completionHandler {
    
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.networkAccessAllowed = YES;
    options.resizeMode = PHImageRequestOptionsResizeModeFast;
    [[PHImageManager defaultManager] requestImageDataForAsset:asset options:options resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
        
        BOOL finished = (![[info objectForKey:PHImageCancelledKey] boolValue] && ![info objectForKey:PHImageErrorKey]);
        if (finished && imageData) {
            
            if (completionHandler) {
                
                completionHandler(imageData,info,NO);
            }
        }
    }];
}


// 获取视频
- (void)qh_fetchVideoWithAsset:(PHAsset *)asset completionHandler:(void (^)(AVPlayerItem *, NSDictionary *))completionHandler {
    
    [self qh_fetchVideoWithAsset:asset progressHandler:nil completionHandler:completionHandler];
}

// 获取视频
- (void)qh_fetchVideoWithAsset:(PHAsset *)asset progressHandler:(void (^)(double progress, NSError *error, BOOL *stop, NSDictionary *info))progressHandler completionHandler:(void (^)(AVPlayerItem *, NSDictionary *))completionHandler {
    
    PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc] init];
    options.networkAccessAllowed = YES;
    options.progressHandler = ^(double progress, NSError * _Nullable error, BOOL * _Nonnull stop, NSDictionary * _Nullable info) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (progressHandler) {
                
                progressHandler(progress,error,stop,info);
            }
        });
    };
    
    [[PHImageManager defaultManager] requestPlayerItemForVideo:asset options:options resultHandler:^(AVPlayerItem * _Nullable playerItem, NSDictionary * _Nullable info) {
        
        if (completionHandler) {
            
            completionHandler(playerItem,info);
        }
    }];
}


// 导出视频
- (void)qh_exportVideoWithAsset:(PHAsset *)anAsset success:(void(^)(NSString *outputPath))success failure:(void(^)(NSString *errorMessage,NSError *error))failure {
    
    [self qh_exportVideoWithAsset:anAsset presetName:AVAssetExportPreset640x480 success:success failure:failure];
}

// 导出视频
- (void)qh_exportVideoWithAsset:(PHAsset *)anAsset presetName:(NSString *)presetName success:(void(^)(NSString *outputPath))success failure:(void(^)(NSString *errorMessage,NSError *error))failure {
    
    PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc] init];
    options.version = PHVideoRequestOptionsVersionOriginal;
    options.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;
    options.networkAccessAllowed = YES;
    
    [[PHImageManager defaultManager] requestAVAssetForVideo:anAsset options:options resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
        
        AVURLAsset *videoAsset = (AVURLAsset *)asset;
        [self startExportingVideoWithVideoAsset:videoAsset presetName:presetName success:success failure:failure];
    }];
}

// 开始导出视频
- (void)startExportingVideoWithVideoAsset:(AVURLAsset *)videoAsset presetName:(NSString *)presetName success:(void(^)(NSString *outputPath))success failure:(void(^)(NSString *errorMessage,NSError *error))failure {
    
    NSArray *presets = [AVAssetExportSession exportPresetsCompatibleWithAsset:videoAsset];
    
//     Begin to compress video
//     Now we just compress to low resolution if it supports
//     If you need to upload to the server, but server does't support to upload by streaming,
//     You can compress the resolution to lower. Or you can support more higher resolution.
    if ([presets containsObject:presetName]) {
        
        AVAssetExportSession *session = [[AVAssetExportSession alloc] initWithAsset:videoAsset presetName:presetName];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd-HH:mm:ss-SSS"];
        NSString *outputPath = [NSHomeDirectory() stringByAppendingFormat:@"/tmp/output-%@.mp4",[formatter stringFromDate:[NSDate date]]];
        NSLog(@"video outputPath is %@",outputPath);
        session.outputURL = [NSURL fileURLWithPath:outputPath];
        
        // 优化网络
        session.shouldOptimizeForNetworkUse = YES;
        
        NSArray *supportedFileTypeArray = session.supportedFileTypes;
        if ([supportedFileTypeArray containsObject:AVFileTypeMPEG4]) {
            
            session.outputFileType = AVFileTypeMPEG4;
        } else if (supportedFileTypeArray.count == 0) {
            
            if (failure) {
                
                failure(@"该视频类型暂不支持导出",nil);
            }
            NSLog(@"No supported file types 视频类型暂不支持导出");
            
            return;
        } else {
            
            session.outputFileType = [supportedFileTypeArray objectAtIndex:0];
        }
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:[NSHomeDirectory() stringByAppendingFormat:@"/tmp"]]) {
            
            [[NSFileManager defaultManager] createDirectoryAtPath:[NSHomeDirectory() stringByAppendingFormat:@"/tmp"] withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        AVMutableVideoComposition *videoComposition = [self fixedCompositionWithAsset:videoAsset];
        if (videoComposition.renderSize.width) {
            
            // 修正视频转向
            session.videoComposition = videoComposition;
        }
        
        // Begin to export video to the output path asynchronously.
        [session exportAsynchronouslyWithCompletionHandler:^{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                switch (session.status) {
                    case AVAssetExportSessionStatusUnknown: {
                        
                        NSLog(@"AVAssetExportSessionStatusUnknown");
                    }
                        break;
                    case AVAssetExportSessionStatusWaiting: {
                        
                        NSLog(@"AVAssetExportSessionStatusWaiting");
                    }
                        break;
                    case AVAssetExportSessionStatusExporting: {
                        
                        NSLog(@"AVAssetExportSessionStatusExporting");
                    }
                        break;
                    case AVAssetExportSessionStatusCompleted: {
                        
                        NSLog(@"AVAssetExportSessionStatusCompleted");
                        if (success) {
                            
                            success(outputPath);
                        }
                    }
                        break;
                    case AVAssetExportSessionStatusFailed: {
                        
                        NSLog(@"AVAssetExportSessionStatusFailed");
                        if (failure) {
                            
                            failure(@"视频导出失败",session.error);
                        }
                    }
                        break;
                    case AVAssetExportSessionStatusCancelled: {
                        
                        NSLog(@"AVAssetExportSessionStatusCancelled");
                        if (failure) {
                            
                            failure(@"视频导出已被取消", nil);
                        }
                    }
                        break;
                    default:
                        break;
                }
            });
        }];
    } else {
        
        if (failure) {
            
            NSString *errorMessage = [NSString stringWithFormat:@"当前设备不支持该预设:%@",presetName];
            failure(errorMessage,nil);
        }
    }
}

// 获取优化后的视频转向信息
- (AVMutableVideoComposition *)fixedCompositionWithAsset:(AVAsset *)asset {
    
    AVMutableVideoComposition *videoComposition = [AVMutableVideoComposition videoComposition];
    int degrees = [self degreesFromVideoWithAsset:asset];
    if (0 != degrees) {
        
        CGAffineTransform transform;
        CGAffineTransform mixedTransform;
        videoComposition.frameDuration = CMTimeMake(1, 30);
        
        NSArray *tracks = [asset tracksWithMediaType:AVMediaTypeVideo];
        AVAssetTrack *videoTrack = [tracks objectAtIndex:0];
        AVMutableVideoCompositionInstruction *roateInstruction = [AVMutableVideoCompositionInstruction videoCompositionInstruction];
        roateInstruction.timeRange = CMTimeRangeMake(kCMTimeZero, [asset duration]);
        
        AVMutableVideoCompositionLayerInstruction *roateLayerInstruction = [AVMutableVideoCompositionLayerInstruction videoCompositionLayerInstructionWithAssetTrack:videoTrack];
        
        if (90 == degrees) {
            
            // 顺时针旋转90°
            transform = CGAffineTransformMakeTranslation(videoTrack.naturalSize.height, 0);
            mixedTransform = CGAffineTransformRotate(transform, M_PI_2);
            videoComposition.renderSize = CGSizeMake(videoTrack.naturalSize.height, videoTrack.naturalSize.width);
            [roateLayerInstruction setTransform:mixedTransform atTime:kCMTimeZero];
        } else if (180 == degrees) {
            
            // 顺时针旋转180°
            transform = CGAffineTransformMakeTranslation(videoTrack.naturalSize.width, videoTrack.naturalSize.height);
            mixedTransform = CGAffineTransformRotate(transform,M_PI);
            videoComposition.renderSize = CGSizeMake(videoTrack.naturalSize.width,videoTrack.naturalSize.height);
            [roateLayerInstruction setTransform:mixedTransform atTime:kCMTimeZero];
        } else if (270 == degrees) {
            
            // 顺时针旋转270°
            transform = CGAffineTransformMakeTranslation(0, videoTrack.naturalSize.width);
            mixedTransform = CGAffineTransformRotate(transform,3 * M_PI_2);
            videoComposition.renderSize = CGSizeMake(videoTrack.naturalSize.height,videoTrack.naturalSize.width);
            [roateLayerInstruction setTransform:mixedTransform atTime:kCMTimeZero];
        }
        
        roateInstruction.layerInstructions = @[roateLayerInstruction];
        videoComposition.instructions = @[roateInstruction];
    }
    
    return videoComposition;
}

// 获取视频角度
- (int)degreesFromVideoWithAsset:(AVAsset *)asset {
    
    int degrees = 0;
    NSArray *tracks = [asset tracksWithMediaType:AVMediaTypeVideo];
    if ([tracks count] > 0) {
        
        AVAssetTrack *assetTrack = [tracks objectAtIndex:0];
        CGAffineTransform transform = assetTrack.preferredTransform;
        if (transform.a == 0 && transform.b == 1.0 && transform.c == -1.0 && transform.d == 0) {
            
            // Portrait
            degrees = 90;
        } else if (transform.a == 0 && transform.b == -1.0 && transform.c == 1.0 && transform.d == 0) {
            
            // PortraitUpsideDown
            degrees = 270;
        } else if (transform.a == 1.0 && transform.b == 0 && transform.c == 0 && transform.d == 1.0) {
            
            // LandscapeRight
            degrees = 0;
        } else if (transform.a == -1.0 && transform.b == 0 && transform.c == 0 && transform.d == -1.0) {
            
            // LandscapeLeft
            degrees = 180;
        }
    }
    
    return degrees;
}

// 获取封面图
- (void)qh_fetchPosterImageWithAlbumModel:(GQHAlbumModel *)albumModel completionHandler:(void(^)(UIImage *))completionHandler {
    
    PHAsset *asset = [albumModel.qh_result lastObject];
    if (!self.qh_sortAscendingByModificationDate) {
        
        asset = [albumModel.qh_result firstObject];
    }
    
    [[GQHImageManager qh_manager] qh_fetchPhotoWithAsset:asset photoWidth:80 completionHandler:^(UIImage *photo, NSDictionary *info, BOOL isDegraded) {
        
        if (completionHandler) {
            
            completionHandler(photo);
        }
    }];
}




@end
#pragma mark ---------------------------------------------------------------------------------------






@interface TZImageManager ()
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
@property (nonatomic, strong) ALAssetsLibrary *assetLibrary;
@end

@implementation TZImageManager

CGSize AssetGridThumbnailSize;
CGFloat TZScreenWidth;
CGFloat TZScreenScale;


- (void)setPhotoWidth:(CGFloat)photoWidth {
    _photoWidth = photoWidth;
    TZScreenWidth = photoWidth / 2;
}

- (void)setColumnNumber:(NSInteger)columnNumber {
    [self configTZScreenWidth];
    
    _columnNumber = columnNumber;
    CGFloat margin = 4;
    CGFloat itemWH = (TZScreenWidth - 2 * margin - 4) / columnNumber - margin;
    AssetGridThumbnailSize = CGSizeMake(itemWH * TZScreenScale, itemWH * TZScreenScale);
}

- (void)configTZScreenWidth {
    TZScreenWidth = [UIScreen mainScreen].bounds.size.width;
    // 测试发现，如果scale在plus真机上取到3.0，内存会增大特别多。故这里写死成2.0
    TZScreenScale = 2.0;
    if (TZScreenWidth > 700) {
        TZScreenScale = 1.5;
    }
}

- (ALAssetsLibrary *)assetLibrary {
    if (_assetLibrary == nil) _assetLibrary = [[ALAssetsLibrary alloc] init];
    return _assetLibrary;
}

/// Return YES if Authorized 返回YES如果得到了授权
- (BOOL)authorizationStatusAuthorized {
    NSInteger status = [self.class authorizationStatus];
    if (status == 0) {
        /**
         * 当某些情况下AuthorizationStatus == AuthorizationStatusNotDetermined时，无法弹出系统首次使用的授权alertView，系统应用设置里亦没有相册的设置，此时将无法使用，故作以下操作，弹出系统首次使用的授权alertView
         */
        [self requestAuthorizationWithCompletion:nil];
    }
    
    return status == 3;
}

+ (NSInteger)authorizationStatus {
    if (iOS8Later) {
        return [PHPhotoLibrary authorizationStatus];
    } else {
        return [ALAssetsLibrary authorizationStatus];
    }
    return NO;
}

- (void)requestAuthorizationWithCompletion:(void (^)(void))completion {
    void (^callCompletionBlock)(void) = ^(){
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion) {
                completion();
            }
        });
    };
    
    if (iOS8Later) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                callCompletionBlock();
            }];
        });
    }
    
}

#pragma mark - Get Album

/// Get Album 获得相册/相册数组
- (void)getCameraRollAlbum:(BOOL)allowPickingVideo allowPickingImage:(BOOL)allowPickingImage completion:(void (^)(TZAlbumModel *))completion{
    __block TZAlbumModel *model;
    if (iOS8Later) {
        PHFetchOptions *option = [[PHFetchOptions alloc] init];
        if (!allowPickingVideo) option.predicate = [NSPredicate predicateWithFormat:@"mediaType == %ld", PHAssetMediaTypeImage];
        if (!allowPickingImage) option.predicate = [NSPredicate predicateWithFormat:@"mediaType == %ld",
                                                    PHAssetMediaTypeVideo];
        // option.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"modificationDate" ascending:self.sortAscendingByModificationDate]];
        if (!self.sortAscendingByModificationDate) {
            option.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:self.sortAscendingByModificationDate]];
        }
        PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
        for (PHAssetCollection *collection in smartAlbums) {
            // 有可能是PHCollectionList类的的对象，过滤掉
            if (![collection isKindOfClass:[PHAssetCollection class]]) continue;
            if ([self isCameraRollAlbum:collection]) {
                PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:collection options:option];
                model = [self modelWithResult:fetchResult name:collection.localizedTitle isCameraRoll:YES];
                if (completion) completion(model);
                break;
            }
        }
    }
}

- (void)getAllAlbums:(BOOL)allowPickingVideo allowPickingImage:(BOOL)allowPickingImage completion:(void (^)(NSArray<TZAlbumModel *> *))completion{
    NSMutableArray *albumArr = [NSMutableArray array];
    if (iOS8Later) {
        PHFetchOptions *option = [[PHFetchOptions alloc] init];
        if (!allowPickingVideo) option.predicate = [NSPredicate predicateWithFormat:@"mediaType == %ld", PHAssetMediaTypeImage];
        if (!allowPickingImage) option.predicate = [NSPredicate predicateWithFormat:@"mediaType == %ld",
                                                    PHAssetMediaTypeVideo];
        // option.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"modificationDate" ascending:self.sortAscendingByModificationDate]];
        if (!self.sortAscendingByModificationDate) {
            option.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:self.sortAscendingByModificationDate]];
        }
        // 我的照片流 1.6.10重新加入..
        PHFetchResult *myPhotoStreamAlbum = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumMyPhotoStream options:nil];
        PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
        PHFetchResult *topLevelUserCollections = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];
        PHFetchResult *syncedAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumSyncedAlbum options:nil];
        PHFetchResult *sharedAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumCloudShared options:nil];
        NSArray *allAlbums = @[myPhotoStreamAlbum,smartAlbums,topLevelUserCollections,syncedAlbums,sharedAlbums];
        for (PHFetchResult *fetchResult in allAlbums) {
            for (PHAssetCollection *collection in fetchResult) {
                // 有可能是PHCollectionList类的的对象，过滤掉
                if (![collection isKindOfClass:[PHAssetCollection class]]) continue;
                PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:collection options:option];
                if (fetchResult.count < 1) continue;
                
                if ([self.pickerDelegate respondsToSelector:@selector(isAlbumCanSelect:result:)]) {
                    if (![self.pickerDelegate isAlbumCanSelect:collection.localizedTitle result:fetchResult]) {
                        continue;
                    }
                }
                
                if ([collection.localizedTitle tz_containsString:@"Hidden"] || [collection.localizedTitle isEqualToString:@"已隐藏"]) continue;
                if ([collection.localizedTitle tz_containsString:@"Deleted"] || [collection.localizedTitle isEqualToString:@"最近删除"]) continue;
                if ([self isCameraRollAlbum:collection]) {
                    [albumArr insertObject:[self modelWithResult:fetchResult name:collection.localizedTitle isCameraRoll:YES] atIndex:0];
                } else {
                    [albumArr addObject:[self modelWithResult:fetchResult name:collection.localizedTitle isCameraRoll:NO]];
                }
            }
        }
        if (completion && albumArr.count > 0) completion(albumArr);
    }
}

#pragma mark - Get Assets

/// Get Assets 获得照片数组
- (void)getAssetsFromFetchResult:(id)result completion:(void (^)(NSArray<TZAssetModel *> *))completion {
    TZImagePickerConfig *config = [TZImagePickerConfig sharedInstance];
    return [self getAssetsFromFetchResult:result allowPickingVideo:config.allowPickingVideo allowPickingImage:config.allowPickingImage completion:completion];
}

- (void)getAssetsFromFetchResult:(id)result allowPickingVideo:(BOOL)allowPickingVideo allowPickingImage:(BOOL)allowPickingImage completion:(void (^)(NSArray<TZAssetModel *> *))completion {
    NSMutableArray *photoArr = [NSMutableArray array];
    if ([result isKindOfClass:[PHFetchResult class]]) {
        PHFetchResult *fetchResult = (PHFetchResult *)result;
        [fetchResult enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            TZAssetModel *model = [self assetModelWithAsset:obj allowPickingVideo:allowPickingVideo allowPickingImage:allowPickingImage];
            if (model) {
                [photoArr addObject:model];
            }
        }];
        if (completion) completion(photoArr);
    }
}

///  Get asset at index 获得下标为index的单个照片
///  if index beyond bounds, return nil in callback 如果索引越界, 在回调中返回 nil
- (void)getAssetFromFetchResult:(id)result atIndex:(NSInteger)index allowPickingVideo:(BOOL)allowPickingVideo allowPickingImage:(BOOL)allowPickingImage completion:(void (^)(TZAssetModel *))completion {
    if ([result isKindOfClass:[PHFetchResult class]]) {
        PHFetchResult *fetchResult = (PHFetchResult *)result;
        PHAsset *asset;
        @try {
            asset = fetchResult[index];
        }
        @catch (NSException* e) {
            if (completion) completion(nil);
            return;
        }
        TZAssetModel *model = [self assetModelWithAsset:asset allowPickingVideo:allowPickingVideo allowPickingImage:allowPickingImage];
        if (completion) completion(model);
    }
}

- (TZAssetModel *)assetModelWithAsset:(id)asset allowPickingVideo:(BOOL)allowPickingVideo allowPickingImage:(BOOL)allowPickingImage {
    BOOL canSelect = YES;
    if ([self.pickerDelegate respondsToSelector:@selector(isAssetCanSelect:)]) {
        canSelect = [self.pickerDelegate isAssetCanSelect:asset];
    }
    if (!canSelect) return nil;
    
    TZAssetModel *model;
    TZAssetModelMediaType type = [self getAssetType:asset];
    if ([asset isKindOfClass:[PHAsset class]]) {
        if (!allowPickingVideo && type == TZAssetModelMediaTypeVideo) return nil;
        if (!allowPickingImage && type == TZAssetModelMediaTypePhoto) return nil;
        if (!allowPickingImage && type == TZAssetModelMediaTypePhotoGif) return nil;
        
        PHAsset *phAsset = (PHAsset *)asset;
        if (self.hideWhenCanNotSelect) {
            // 过滤掉尺寸不满足要求的图片
            if (![self isPhotoSelectableWithAsset:phAsset]) {
                return nil;
            }
        }
        NSString *timeLength = type == TZAssetModelMediaTypeVideo ? [NSString stringWithFormat:@"%0.0f",phAsset.duration] : @"";
        timeLength = [self getNewTimeFromDurationSecond:timeLength.integerValue];
        model = [TZAssetModel modelWithAsset:asset type:type timeLength:timeLength];
    } else {
        if (!allowPickingVideo){
            model = [TZAssetModel modelWithAsset:asset type:type];
            return model;
        }
        /// Allow picking video
        if (type == TZAssetModelMediaTypeVideo) {
            NSTimeInterval duration = [[asset valueForProperty:ALAssetPropertyDuration] doubleValue];
            NSString *timeLength = [NSString stringWithFormat:@"%0.0f",duration];
            timeLength = [self getNewTimeFromDurationSecond:timeLength.integerValue];
            model = [TZAssetModel modelWithAsset:asset type:type timeLength:timeLength];
        } else {
            if (self.hideWhenCanNotSelect) {
                // 过滤掉尺寸不满足要求的图片
                if (![self isPhotoSelectableWithAsset:asset]) {
                    return nil;
                }
            }
            model = [TZAssetModel modelWithAsset:asset type:type];
        }
    }
    return model;
}

- (TZAssetModelMediaType)getAssetType:(id)asset {
    TZAssetModelMediaType type = TZAssetModelMediaTypePhoto;
    if ([asset isKindOfClass:[PHAsset class]]) {
        PHAsset *phAsset = (PHAsset *)asset;
        if (phAsset.mediaType == PHAssetMediaTypeVideo)      type = TZAssetModelMediaTypeVideo;
        else if (phAsset.mediaType == PHAssetMediaTypeAudio) type = TZAssetModelMediaTypeAudio;
        else if (phAsset.mediaType == PHAssetMediaTypeImage) {
            if (iOS9_1Later) {
                // if (asset.mediaSubtypes == PHAssetMediaSubtypePhotoLive) type = TZAssetModelMediaTypeLivePhoto;
            }
            // Gif
            if ([[phAsset valueForKey:@"filename"] hasSuffix:@"GIF"]) {
                type = TZAssetModelMediaTypePhotoGif;
            }
        }
    } else {
        if ([[asset valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypeVideo]) {
            type = TZAssetModelMediaTypeVideo;
        }
    }
    return type;
}

- (NSString *)getNewTimeFromDurationSecond:(NSInteger)duration {
    NSString *newTime;
    if (duration < 10) {
        newTime = [NSString stringWithFormat:@"0:0%zd",duration];
    } else if (duration < 60) {
        newTime = [NSString stringWithFormat:@"0:%zd",duration];
    } else {
        NSInteger min = duration / 60;
        NSInteger sec = duration - (min * 60);
        if (sec < 10) {
            newTime = [NSString stringWithFormat:@"%zd:0%zd",min,sec];
        } else {
            newTime = [NSString stringWithFormat:@"%zd:%zd",min,sec];
        }
    }
    return newTime;
}

/// Get photo bytes 获得一组照片的大小
- (void)getPhotosBytesWithArray:(NSArray *)photos completion:(void (^)(NSString *totalBytes))completion {
    if (!photos || !photos.count) {
        if (completion) completion(@"0B");
        return;
    }
    __block NSInteger dataLength = 0;
    __block NSInteger assetCount = 0;
    for (NSInteger i = 0; i < photos.count; i++) {
        TZAssetModel *model = photos[i];
        if ([model.asset isKindOfClass:[PHAsset class]]) {
            PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
            options.resizeMode = PHImageRequestOptionsResizeModeFast;
            [[PHImageManager defaultManager] requestImageDataForAsset:model.asset options:options resultHandler:^(NSData *imageData, NSString *dataUTI, UIImageOrientation orientation, NSDictionary *info) {
                if (model.type != TZAssetModelMediaTypeVideo) dataLength += imageData.length;
                assetCount ++;
                if (assetCount >= photos.count) {
                    NSString *bytes = [self getBytesFromDataLength:dataLength];
                    if (completion) completion(bytes);
                }
            }];
        } else if ([model.asset isKindOfClass:[ALAsset class]]) {
            ALAssetRepresentation *representation = [model.asset defaultRepresentation];
            if (model.type != TZAssetModelMediaTypeVideo) dataLength += (NSInteger)representation.size;
            if (i >= photos.count - 1) {
                NSString *bytes = [self getBytesFromDataLength:dataLength];
                if (completion) completion(bytes);
            }
        }
    }
}

- (NSString *)getBytesFromDataLength:(NSInteger)dataLength {
    NSString *bytes;
    if (dataLength >= 0.1 * (1024 * 1024)) {
        bytes = [NSString stringWithFormat:@"%0.1fM",dataLength/1024/1024.0];
    } else if (dataLength >= 1024) {
        bytes = [NSString stringWithFormat:@"%0.0fK",dataLength/1024.0];
    } else {
        bytes = [NSString stringWithFormat:@"%zdB",dataLength];
    }
    return bytes;
}

#pragma mark - Get Photo

/// Get postImage / 获取封面图
- (void)getPostImageWithAlbumModel:(TZAlbumModel *)model completion:(void (^)(UIImage *))completion {
    if (iOS8Later) {
        id asset = [model.result lastObject];
        if (!self.sortAscendingByModificationDate) {
            asset = [model.result firstObject];
        }
        [[TZImageManager manager] getPhotoWithAsset:asset photoWidth:80 completion:^(UIImage *photo, NSDictionary *info, BOOL isDegraded) {
            if (completion) completion(photo);
        }];
    } else {
        ALAssetsGroup *group = model.result;
        UIImage *postImage = [UIImage imageWithCGImage:group.posterImage];
        if (completion) completion(postImage);
    }
}

/// Get Original Photo / 获取原图
- (void)getOriginalPhotoWithAsset:(id)asset completion:(void (^)(UIImage *photo,NSDictionary *info))completion {
    [self getOriginalPhotoWithAsset:asset newCompletion:^(UIImage *photo, NSDictionary *info, BOOL isDegraded) {
        if (completion) {
            completion(photo,info);
        }
    }];
}

- (void)getOriginalPhotoWithAsset:(id)asset newCompletion:(void (^)(UIImage *photo,NSDictionary *info,BOOL isDegraded))completion {
    if ([asset isKindOfClass:[PHAsset class]]) {
        PHImageRequestOptions *option = [[PHImageRequestOptions alloc]init];
        option.networkAccessAllowed = YES;
        option.resizeMode = PHImageRequestOptionsResizeModeFast;
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeAspectFit options:option resultHandler:^(UIImage *result, NSDictionary *info) {
            BOOL downloadFinined = (![[info objectForKey:PHImageCancelledKey] boolValue] && ![info objectForKey:PHImageErrorKey]);
            if (downloadFinined && result) {
                result = [self fixOrientation:result];
                BOOL isDegraded = [[info objectForKey:PHImageResultIsDegradedKey] boolValue];
                if (completion) completion(result,info,isDegraded);
            }
        }];
    } else if ([asset isKindOfClass:[ALAsset class]]) {
        ALAsset *alAsset = (ALAsset *)asset;
        ALAssetRepresentation *assetRep = [alAsset defaultRepresentation];
        
        dispatch_async(dispatch_get_global_queue(0,0), ^{
            CGImageRef originalImageRef = [assetRep fullResolutionImage];
            UIImage *originalImage = [UIImage imageWithCGImage:originalImageRef scale:1.0 orientation:UIImageOrientationUp];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (completion) completion(originalImage,nil,NO);
            });
        });
    }
}

- (void)getOriginalPhotoDataWithAsset:(id)asset completion:(void (^)(NSData *data,NSDictionary *info,BOOL isDegraded))completion {
    if ([asset isKindOfClass:[PHAsset class]]) {
        PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
        option.networkAccessAllowed = YES;
        option.resizeMode = PHImageRequestOptionsResizeModeFast;
        [[PHImageManager defaultManager] requestImageDataForAsset:asset options:option resultHandler:^(NSData *imageData, NSString *dataUTI, UIImageOrientation orientation, NSDictionary *info) {
            BOOL downloadFinined = (![[info objectForKey:PHImageCancelledKey] boolValue] && ![info objectForKey:PHImageErrorKey]);
            if (downloadFinined && imageData) {
                if (completion) completion(imageData,info,NO);
            }
        }];
    } else if ([asset isKindOfClass:[ALAsset class]]) {
        ALAsset *alAsset = (ALAsset *)asset;
        ALAssetRepresentation *assetRep = [alAsset defaultRepresentation];
        Byte *imageBuffer = (Byte *)malloc(assetRep.size);
        NSUInteger bufferSize = [assetRep getBytes:imageBuffer fromOffset:0.0 length:assetRep.size error:nil];
        NSData *imageData = [NSData dataWithBytesNoCopy:imageBuffer length:bufferSize freeWhenDone:YES];
        if (completion) completion(imageData,nil,NO);
    }
}

#pragma mark - Save photo

- (void)savePhotoWithImage:(UIImage *)image completion:(void (^)(NSError *error))completion {
    [self savePhotoWithImage:image location:nil completion:completion];
}

- (void)savePhotoWithImage:(UIImage *)image location:(CLLocation *)location completion:(void (^)(NSError *error))completion {
    if (iOS8Later) {
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            if (iOS9Later) {
                NSData *data = UIImageJPEGRepresentation(image, 0.9);
                PHAssetResourceCreationOptions *options = [[PHAssetResourceCreationOptions alloc] init];
                options.shouldMoveFile = YES;
                PHAssetCreationRequest *request = [PHAssetCreationRequest creationRequestForAsset];
                [request addResourceWithType:PHAssetResourceTypePhoto data:data options:options];
                if (location) {
                    request.location = location;
                }
                request.creationDate = [NSDate date];
            } else {
                PHAssetChangeRequest *request = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
                if (location) {
                    request.location = location;
                }
                request.creationDate = [NSDate date];
            }
        } completionHandler:^(BOOL success, NSError *error) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                if (success && completion) {
                    completion(nil);
                } else if (error) {
                    NSLog(@"保存照片出错:%@",error.localizedDescription);
                    if (completion) {
                        completion(error);
                    }
                }
            });
        }];
    }
}

#pragma mark - Get Video

/// Get Video / 获取视频
- (void)getVideoWithAsset:(id)asset completion:(void (^)(AVPlayerItem *, NSDictionary *))completion {
    [self getVideoWithAsset:asset progressHandler:nil completion:completion];
}

- (void)getVideoWithAsset:(id)asset
          progressHandler:(void (^)(double progress, NSError *error, BOOL *stop, NSDictionary *info))progressHandler
               completion:(void (^)(AVPlayerItem *, NSDictionary *))completion
{
    if ([asset isKindOfClass:[PHAsset class]]) {
        PHVideoRequestOptions *option = [[PHVideoRequestOptions alloc] init];
        option.networkAccessAllowed = YES;
        option.progressHandler = ^(double progress, NSError *error, BOOL *stop, NSDictionary *info) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (progressHandler) {
                    progressHandler(progress, error, stop, info);
                }
            });
        };
        [[PHImageManager defaultManager] requestPlayerItemForVideo:asset options:option resultHandler:^(AVPlayerItem *playerItem, NSDictionary *info) {
            if (completion) completion(playerItem,info);
        }];
    } else if ([asset isKindOfClass:[ALAsset class]]) {
        ALAsset *alAsset = (ALAsset *)asset;
        ALAssetRepresentation *defaultRepresentation = [alAsset defaultRepresentation];
        NSString *uti = [defaultRepresentation UTI];
        NSURL *videoURL = [[asset valueForProperty:ALAssetPropertyURLs] valueForKey:uti];
        AVPlayerItem *playerItem = [[AVPlayerItem alloc] initWithURL:videoURL];
        if (completion && playerItem) completion(playerItem,nil);
    }
}

#pragma mark - Export video

/// Export Video / 导出视频
- (void)getVideoOutputPathWithAsset:(id)asset success:(void (^)(NSString *outputPath))success failure:(void (^)(NSString *errorMessage, NSError *error))failure {
    [self getVideoOutputPathWithAsset:asset presetName:AVAssetExportPreset640x480 success:success failure:failure];
}

- (void)getVideoOutputPathWithAsset:(id)asset presetName:(NSString *)presetName success:(void (^)(NSString *outputPath))success failure:(void (^)(NSString *errorMessage, NSError *error))failure {
    if ([asset isKindOfClass:[PHAsset class]]) {
        PHVideoRequestOptions* options = [[PHVideoRequestOptions alloc] init];
        options.version = PHVideoRequestOptionsVersionOriginal;
        options.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;
        options.networkAccessAllowed = YES;
        [[PHImageManager defaultManager] requestAVAssetForVideo:asset options:options resultHandler:^(AVAsset* avasset, AVAudioMix* audioMix, NSDictionary* info){
            // NSLog(@"Info:\n%@",info);
            AVURLAsset *videoAsset = (AVURLAsset*)avasset;
            // NSLog(@"AVAsset URL: %@",myAsset.URL);
            [self startExportVideoWithVideoAsset:videoAsset presetName:presetName success:success failure:failure];
        }];
    } else if ([asset isKindOfClass:[ALAsset class]]) {
        NSURL *videoURL =[asset valueForProperty:ALAssetPropertyAssetURL]; // ALAssetPropertyURLs
        AVURLAsset *videoAsset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
        [self startExportVideoWithVideoAsset:videoAsset presetName:presetName success:success failure:failure];
    }
}

/// Deprecated, Use -getVideoOutputPathWithAsset:failure:success:
- (void)getVideoOutputPathWithAsset:(id)asset completion:(void (^)(NSString *outputPath))completion {
    [self getVideoOutputPathWithAsset:asset success:completion failure:nil];
}

- (void)startExportVideoWithVideoAsset:(AVURLAsset *)videoAsset presetName:(NSString *)presetName success:(void (^)(NSString *outputPath))success failure:(void (^)(NSString *errorMessage, NSError *error))failure {
    // Find compatible presets by video asset.
    NSArray *presets = [AVAssetExportSession exportPresetsCompatibleWithAsset:videoAsset];
    
    // Begin to compress video
    // Now we just compress to low resolution if it supports
    // If you need to upload to the server, but server does't support to upload by streaming,
    // You can compress the resolution to lower. Or you can support more higher resolution.
    if ([presets containsObject:presetName]) {
        AVAssetExportSession *session = [[AVAssetExportSession alloc] initWithAsset:videoAsset presetName:presetName];
        
        NSDateFormatter *formater = [[NSDateFormatter alloc] init];
        [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss-SSS"];
        NSString *outputPath = [NSHomeDirectory() stringByAppendingFormat:@"/tmp/output-%@.mp4", [formater stringFromDate:[NSDate date]]];
        // NSLog(@"video outputPath = %@",outputPath);
        session.outputURL = [NSURL fileURLWithPath:outputPath];
        
        // Optimize for network use.
        session.shouldOptimizeForNetworkUse = true;
        
        NSArray *supportedTypeArray = session.supportedFileTypes;
        if ([supportedTypeArray containsObject:AVFileTypeMPEG4]) {
            session.outputFileType = AVFileTypeMPEG4;
        } else if (supportedTypeArray.count == 0) {
            if (failure) {
                failure(@"该视频类型暂不支持导出", nil);
            }
            NSLog(@"No supported file types 视频类型暂不支持导出");
            return;
        } else {
            session.outputFileType = [supportedTypeArray objectAtIndex:0];
        }
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:[NSHomeDirectory() stringByAppendingFormat:@"/tmp"]]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:[NSHomeDirectory() stringByAppendingFormat:@"/tmp"] withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        AVMutableVideoComposition *videoComposition = [self fixedCompositionWithAsset:videoAsset];
        if (videoComposition.renderSize.width) {
            // 修正视频转向
            session.videoComposition = videoComposition;
        }
        
        // Begin to export video to the output path asynchronously.
        [session exportAsynchronouslyWithCompletionHandler:^(void) {
            dispatch_async(dispatch_get_main_queue(), ^{
                switch (session.status) {
                    case AVAssetExportSessionStatusUnknown: {
                        NSLog(@"AVAssetExportSessionStatusUnknown");
                    }  break;
                    case AVAssetExportSessionStatusWaiting: {
                        NSLog(@"AVAssetExportSessionStatusWaiting");
                    }  break;
                    case AVAssetExportSessionStatusExporting: {
                        NSLog(@"AVAssetExportSessionStatusExporting");
                    }  break;
                    case AVAssetExportSessionStatusCompleted: {
                        NSLog(@"AVAssetExportSessionStatusCompleted");
                        if (success) {
                            success(outputPath);
                        }
                    }  break;
                    case AVAssetExportSessionStatusFailed: {
                        NSLog(@"AVAssetExportSessionStatusFailed");
                        if (failure) {
                            failure(@"视频导出失败", session.error);
                        }
                    }  break;
                    case AVAssetExportSessionStatusCancelled: {
                        NSLog(@"AVAssetExportSessionStatusCancelled");
                        if (failure) {
                            failure(@"导出任务已被取消", nil);
                        }
                    }  break;
                    default: break;
                }
            });
        }];
    } else {
        if (failure) {
            NSString *errorMessage = [NSString stringWithFormat:@"当前设备不支持该预设:%@", presetName];
            failure(errorMessage, nil);
        }
    }
}

/// Judge is a assets array contain the asset 判断一个assets数组是否包含这个asset
- (BOOL)isAssetsArray:(NSArray *)assets containAsset:(id)asset {
    if (iOS8Later) {
        return [assets containsObject:asset];
    } else {
        NSMutableArray *selectedAssetUrls = [NSMutableArray array];
        for (ALAsset *asset_item in assets) {
            [selectedAssetUrls addObject:[asset_item valueForProperty:ALAssetPropertyURLs]];
        }
        return [selectedAssetUrls containsObject:[asset valueForProperty:ALAssetPropertyURLs]];
    }
}

- (BOOL)isCameraRollAlbum:(id)metadata {
    if ([metadata isKindOfClass:[PHAssetCollection class]]) {
        NSString *versionStr = [[UIDevice currentDevice].systemVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
        if (versionStr.length <= 1) {
            versionStr = [versionStr stringByAppendingString:@"00"];
        } else if (versionStr.length <= 2) {
            versionStr = [versionStr stringByAppendingString:@"0"];
        }
        CGFloat version = versionStr.floatValue;
        // 目前已知8.0.0 ~ 8.0.2系统，拍照后的图片会保存在最近添加中
        if (version >= 800 && version <= 802) {
            return ((PHAssetCollection *)metadata).assetCollectionSubtype == PHAssetCollectionSubtypeSmartAlbumRecentlyAdded;
        } else {
            return ((PHAssetCollection *)metadata).assetCollectionSubtype == PHAssetCollectionSubtypeSmartAlbumUserLibrary;
        }
    }
    if ([metadata isKindOfClass:[ALAssetsGroup class]]) {
        ALAssetsGroup *group = metadata;
        return ([[group valueForProperty:ALAssetsGroupPropertyType] intValue] == ALAssetsGroupSavedPhotos);
    }
    
    return NO;
}

- (NSString *)getAssetIdentifier:(id)asset {
    if (iOS8Later) {
        PHAsset *phAsset = (PHAsset *)asset;
        return phAsset.localIdentifier;
    } else {
        ALAsset *alAsset = (ALAsset *)asset;
        NSURL *assetUrl = [alAsset valueForProperty:ALAssetPropertyAssetURL];
        return assetUrl.absoluteString;
    }
}

/// 检查照片大小是否满足最小要求
- (BOOL)isPhotoSelectableWithAsset:(id)asset {
    CGSize photoSize = [self photoSizeWithAsset:asset];
    if (self.minPhotoWidthSelectable > photoSize.width || self.minPhotoHeightSelectable > photoSize.height) {
        return NO;
    }
    return YES;
}

- (CGSize)photoSizeWithAsset:(id)asset {
    if (iOS8Later) {
        PHAsset *phAsset = (PHAsset *)asset;
        return CGSizeMake(phAsset.pixelWidth, phAsset.pixelHeight);
    } else {
        ALAsset *alAsset = (ALAsset *)asset;
        return alAsset.defaultRepresentation.dimensions;
    }
}

#pragma mark - Private Method

- (TZAlbumModel *)modelWithResult:(id)result name:(NSString *)name isCameraRoll:(BOOL)isCameraRoll {
    TZAlbumModel *model = [[TZAlbumModel alloc] init];
    model.result = result;
    model.name = name;
    model.isCameraRoll = isCameraRoll;
    if ([result isKindOfClass:[PHFetchResult class]]) {
        PHFetchResult *fetchResult = (PHFetchResult *)result;
        model.count = fetchResult.count;
    } else if ([result isKindOfClass:[ALAssetsGroup class]]) {
        ALAssetsGroup *group = (ALAssetsGroup *)result;
        model.count = [group numberOfAssets];
    }
    return model;
}

- (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)size {
    if (image.size.width > size.width) {
        UIGraphicsBeginImageContext(size);
        [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return newImage;
    } else {
        return image;
    }
}

- (ALAssetOrientation)orientationFromImage:(UIImage *)image {
    NSInteger orientation = image.imageOrientation;
    return orientation;
}

/// 获取优化后的视频转向信息
- (AVMutableVideoComposition *)fixedCompositionWithAsset:(AVAsset *)videoAsset {
    AVMutableVideoComposition *videoComposition = [AVMutableVideoComposition videoComposition];
    // 视频转向
    int degrees = [self degressFromVideoFileWithAsset:videoAsset];
    if (degrees != 0) {
        CGAffineTransform translateToCenter;
        CGAffineTransform mixedTransform;
        videoComposition.frameDuration = CMTimeMake(1, 30);
        
        NSArray *tracks = [videoAsset tracksWithMediaType:AVMediaTypeVideo];
        AVAssetTrack *videoTrack = [tracks objectAtIndex:0];
        
        AVMutableVideoCompositionInstruction *roateInstruction = [AVMutableVideoCompositionInstruction videoCompositionInstruction];
        roateInstruction.timeRange = CMTimeRangeMake(kCMTimeZero, [videoAsset duration]);
        AVMutableVideoCompositionLayerInstruction *roateLayerInstruction = [AVMutableVideoCompositionLayerInstruction videoCompositionLayerInstructionWithAssetTrack:videoTrack];
        
        if (degrees == 90) {
            // 顺时针旋转90°
            translateToCenter = CGAffineTransformMakeTranslation(videoTrack.naturalSize.height, 0.0);
            mixedTransform = CGAffineTransformRotate(translateToCenter,M_PI_2);
            videoComposition.renderSize = CGSizeMake(videoTrack.naturalSize.height,videoTrack.naturalSize.width);
            [roateLayerInstruction setTransform:mixedTransform atTime:kCMTimeZero];
        } else if(degrees == 180){
            // 顺时针旋转180°
            translateToCenter = CGAffineTransformMakeTranslation(videoTrack.naturalSize.width, videoTrack.naturalSize.height);
            mixedTransform = CGAffineTransformRotate(translateToCenter,M_PI);
            videoComposition.renderSize = CGSizeMake(videoTrack.naturalSize.width,videoTrack.naturalSize.height);
            [roateLayerInstruction setTransform:mixedTransform atTime:kCMTimeZero];
        } else if(degrees == 270){
            // 顺时针旋转270°
            translateToCenter = CGAffineTransformMakeTranslation(0.0, videoTrack.naturalSize.width);
            mixedTransform = CGAffineTransformRotate(translateToCenter,M_PI_2*3.0);
            videoComposition.renderSize = CGSizeMake(videoTrack.naturalSize.height,videoTrack.naturalSize.width);
            [roateLayerInstruction setTransform:mixedTransform atTime:kCMTimeZero];
        }
        
        roateInstruction.layerInstructions = @[roateLayerInstruction];
        // 加入视频方向信息
        videoComposition.instructions = @[roateInstruction];
    }
    return videoComposition;
}

/// 获取视频角度
- (int)degressFromVideoFileWithAsset:(AVAsset *)asset {
    int degress = 0;
    NSArray *tracks = [asset tracksWithMediaType:AVMediaTypeVideo];
    if([tracks count] > 0) {
        AVAssetTrack *videoTrack = [tracks objectAtIndex:0];
        CGAffineTransform t = videoTrack.preferredTransform;
        if(t.a == 0 && t.b == 1.0 && t.c == -1.0 && t.d == 0){
            // Portrait
            degress = 90;
        } else if(t.a == 0 && t.b == -1.0 && t.c == 1.0 && t.d == 0){
            // PortraitUpsideDown
            degress = 270;
        } else if(t.a == 1.0 && t.b == 0 && t.c == 0 && t.d == 1.0){
            // LandscapeRight
            degress = 0;
        } else if(t.a == -1.0 && t.b == 0 && t.c == 0 && t.d == -1.0){
            // LandscapeLeft
            degress = 180;
        }
    }
    return degress;
}

/// 修正图片转向
- (UIImage *)fixOrientation:(UIImage *)aImage {
    if (!self.shouldFixOrientation) return aImage;
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

#pragma clang diagnostic pop

@end
