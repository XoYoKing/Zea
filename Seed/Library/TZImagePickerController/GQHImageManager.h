//
//  GQHImageManager.h
//  GQHKit
//
//  Created by GuanQinghao on 31/01/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import <AVFoundation/AVFoundation.h>

@class GQHAssetModel,GQHAlbumModel;
@protocol GQHImagePickerControllerDelegate;
@interface GQHImageManager : NSObject

//
@property (nonatomic, weak) id<GQHImagePickerControllerDelegate> qh_delegate;

//
@property (nonatomic, strong) PHCachingImageManager *qh_cachingImageManager;

// 可选图片最小宽度 默认为0 小于此宽度不可选择
@property (nonatomic, assign) NSUInteger qh_minSelectableWidth;

// 可选图片最小高度 默认为0 小于此高度不可选择
@property (nonatomic, assign) NSUInteger qh_minSelectableHeight;

// 不可选择就隐藏 (不可选择 unselectable 可选择selectable 未选择unselected 选择selected)
@property (nonatomic, assign) BOOL qh_hidesIfUnselectable;

// 相片预览最大宽度 默认600px
@property (nonatomic, assign) CGFloat qh_photoPreviewMaxWidth;

// 导出图片的宽度 默认828px
@property (nonatomic, assign) CGFloat qh_photoWidth;

// 单例
+ (instancetype)qh_manager;

// 某资源是否包含在资源数组中
- (BOOL)qh_containsAsset:(PHAsset *)asset withinAssetArray:(NSArray *)assetArray;

// 根据PHFetchResult获取资源
- (void)qh_fetchAssetsFromResult:(PHFetchResult *)result completion:(void(^)(NSArray<GQHAssetModel *> *))completion;

// 检查照片大小是否满足最小可选要求
- (BOOL)qh_checkSelectableStatusWithAsset:(PHAsset *)asset;


// 获取相册的照片
- (int32_t)qh_fetchPhotoWithAsset:(PHAsset *)asset
                completionHandler:(void (^)(UIImage *photo, NSDictionary *info, BOOL isDegraded))completionHandler;

// 获取相册里的照片
- (int32_t)qh_fetchPhotoWithAsset:(PHAsset *)asset
                       photoWidth:(CGFloat)photoWidth
                completionHandler:(void (^)(UIImage *photo, NSDictionary *info, BOOL isDegraded))completionHandler;

// 获取相册里的照片
- (int32_t)qh_fetchPhotoWithAsset:(PHAsset *)asset
             networkAccessAllowed:(BOOL)networkAccessAllowed
                  progressHandler:(void (^)(double progress, NSError *error, BOOL *stop, NSDictionary *info))progressHandler
                completionHandler:(void (^)(UIImage *photo, NSDictionary *info, BOOL isDegraded))completionHandler;

// 获取相册里的照片
- (int32_t)qh_fetchPhotoWithAsset:(PHAsset *)asset
                       photoWidth:(CGFloat)photoWidth
             networkAccessAllowed:(BOOL)networkAccessAllowed
                  progressHandler:(void (^)(double progress, NSError *error, BOOL *stop, NSDictionary *info))progressHandler
                completionHandler:(void (^)(UIImage *photo, NSDictionary *info, BOOL isDegraded))completionHandler;

// 是否需要修复图片转向
@property (nonatomic, assign) BOOL qh_isFixedOrientation;

// 修正图片转向
- (UIImage *)qh_fixOrientation:(UIImage *)aImage;

// 图片缩放到指定尺寸
- (UIImage *)qh_scaleImage:(UIImage *)aImage toSize:(CGSize)size;


// 获取照片原图
- (void)qh_fetchOriginalPhotoWithAsset:(PHAsset *)asset completionHandler:(void (^)(UIImage *photo, NSDictionary *info, BOOL isDegraded))completionHandler;

// 获取照片原图
- (void)qh_fetchOriginalPhotoDataWithAsset:(PHAsset *)asset completionHandler:(void (^)(NSData *data, NSDictionary *info, BOOL isDegraded))completionHandler;


// 获取视频
- (void)qh_fetchVideoWithAsset:(PHAsset *)asset completionHandler:(void (^)(AVPlayerItem *, NSDictionary *))completionHandler;

// 获取视频
- (void)qh_fetchVideoWithAsset:(PHAsset *)asset progressHandler:(void (^)(double progress, NSError *error, BOOL *stop, NSDictionary *info))progressHandler completionHandler:(void (^)(AVPlayerItem *, NSDictionary *))completionHandler;

// 导出视频
- (void)qh_exportVideoWithAsset:(PHAsset *)anAsset success:(void(^)(NSString *outputPath))success failure:(void(^)(NSString *errorMessage,NSError *error))failure;

// 导出视频
- (void)qh_exportVideoWithAsset:(PHAsset *)anAsset presetName:(NSString *)presetName success:(void(^)(NSString *outputPath))success failure:(void(^)(NSString *errorMessage,NSError *error))failure;


// 对照片排序，按修改时间升序，默认是YES。如果设置为NO,最新的照片会显示在最前面，内部的拍照按钮会排在第一个
@property (nonatomic, assign) BOOL qh_sortAscendingByModificationDate;

// 获取封面图
- (void)qh_fetchPosterImageWithAlbumModel:(GQHAlbumModel *)albumModel completionHandler:(void(^)(UIImage *))completionHandler;


@end





@interface TZImageManager : NSObject

/// Default is 600px / 默认600像素宽
@property (nonatomic, assign) CGFloat photoPreviewMaxWidth;
/// The pixel width of output image, Default is 828px / 导出图片的宽度，默认828像素宽
@property (nonatomic, assign) CGFloat photoWidth;


/// Default is 4, Use in photos collectionView in TZPhotoPickerController
/// 默认4列, TZPhotoPickerController中的照片collectionView
@property (nonatomic, assign) NSInteger columnNumber;

/// Sort photos ascending by modificationDate，Default is YES
/// 对照片排序，按修改时间升序，默认是YES。如果设置为NO,最新的照片会显示在最前面，内部的拍照按钮会排在第一个
@property (nonatomic, assign) BOOL qh_sortAscendingByModificationDate;

/// Minimum selectable photo width, Default is 0
/// 最小可选中的图片宽度，默认是0，小于这个宽度的图片不可选中
@property (nonatomic, assign) NSInteger minPhotoWidthSelectable;
@property (nonatomic, assign) NSInteger minPhotoHeightSelectable;
@property (nonatomic, assign) BOOL hideWhenCanNotSelect;


/// Return YES if Authorized 返回YES如果得到了授权
- (BOOL)authorizationStatusAuthorized;
+ (NSInteger)authorizationStatus;
- (void)requestAuthorizationWithCompletion:(void (^)(void))completion;

/// Get Album 获得相册/相册数组
- (void)getCameraRollAlbum:(BOOL)allowPickingVideo allowPickingImage:(BOOL)allowPickingImage completion:(void (^)(TZAlbumModel *model))completion;
- (void)getAllAlbums:(BOOL)allowPickingVideo allowPickingImage:(BOOL)allowPickingImage completion:(void (^)(NSArray<TZAlbumModel *> *models))completion;

/// Get Assets 获得Asset数组
- (void)getAssetsFromFetchResult:(id)result completion:(void (^)(NSArray<TZAssetModel *> *models))completion;
- (void)getAssetsFromFetchResult:(id)result allowPickingVideo:(BOOL)allowPickingVideo allowPickingImage:(BOOL)allowPickingImage completion:(void (^)(NSArray<TZAssetModel *> *models))completion;
- (void)getAssetFromFetchResult:(id)result atIndex:(NSInteger)index allowPickingVideo:(BOOL)allowPickingVideo allowPickingImage:(BOOL)allowPickingImage completion:(void (^)(TZAssetModel *model))completion;

/// Get photo 获得照片
- (void)getPostImageWithAlbumModel:(TZAlbumModel *)model completion:(void (^)(UIImage *postImage))completion;

- (int32_t)getPhotoWithAsset:(id)asset completion:(void (^)(UIImage *photo,NSDictionary *info,BOOL isDegraded))completion;
- (int32_t)getPhotoWithAsset:(id)asset photoWidth:(CGFloat)photoWidth completion:(void (^)(UIImage *photo,NSDictionary *info,BOOL isDegraded))completion;
- (int32_t)getPhotoWithAsset:(id)asset completion:(void (^)(UIImage *photo,NSDictionary *info,BOOL isDegraded))completion progressHandler:(void (^)(double progress, NSError *error, BOOL *stop, NSDictionary *info))progressHandler networkAccessAllowed:(BOOL)networkAccessAllowed;
- (int32_t)getPhotoWithAsset:(id)asset photoWidth:(CGFloat)photoWidth completion:(void (^)(UIImage *photo,NSDictionary *info,BOOL isDegraded))completion progressHandler:(void (^)(double progress, NSError *error, BOOL *stop, NSDictionary *info))progressHandler networkAccessAllowed:(BOOL)networkAccessAllowed;

/// Get full Image 获取原图
/// 如下两个方法completion一般会调多次，一般会先返回缩略图，再返回原图(详见方法内部使用的系统API的说明)，如果info[PHImageResultIsDegradedKey] 为 YES，则表明当前返回的是缩略图，否则是原图。
- (void)getOriginalPhotoWithAsset:(id)asset completion:(void (^)(UIImage *photo,NSDictionary *info))completion;
- (void)getOriginalPhotoWithAsset:(id)asset newCompletion:(void (^)(UIImage *photo,NSDictionary *info,BOOL isDegraded))completion;
// 该方法中，completion只会走一次
- (void)getOriginalPhotoDataWithAsset:(id)asset completion:(void (^)(NSData *data,NSDictionary *info,BOOL isDegraded))completion;

/// Save photo 保存照片
- (void)savePhotoWithImage:(UIImage *)image completion:(void (^)(NSError *error))completion;
- (void)savePhotoWithImage:(UIImage *)image location:(CLLocation *)location completion:(void (^)(NSError *error))completion;

/// Get video 获得视频
- (void)getVideoWithAsset:(id)asset completion:(void (^)(AVPlayerItem * playerItem, NSDictionary * info))completion;
- (void)getVideoWithAsset:(id)asset progressHandler:(void (^)(double progress, NSError *error, BOOL *stop, NSDictionary *info))progressHandler completion:(void (^)(AVPlayerItem *, NSDictionary *))completion;

/// Export video 导出视频 presetName: 预设名字，默认值是AVAssetExportPreset640x480
- (void)getVideoOutputPathWithAsset:(id)asset success:(void (^)(NSString *outputPath))success failure:(void (^)(NSString *errorMessage, NSError *error))failure;
- (void)getVideoOutputPathWithAsset:(id)asset presetName:(NSString *)presetName success:(void (^)(NSString *outputPath))success failure:(void (^)(NSString *errorMessage, NSError *error))failure;
/// Deprecated, Use -getVideoOutputPathWithAsset:failure:success:
- (void)getVideoOutputPathWithAsset:(id)asset completion:(void (^)(NSString *outputPath))completion __attribute__((deprecated("Use -getVideoOutputPathWithAsset:failure:success:")));

/// Get photo bytes 获得一组照片的大小
- (void)getPhotosBytesWithArray:(NSArray *)photos completion:(void (^)(NSString *totalBytes))completion;

/// Judge is a assets array contain the asset 判断一个assets数组是否包含这个asset
- (BOOL)isAssetsArray:(NSArray *)assets containAsset:(id)asset;

- (NSString *)getAssetIdentifier:(id)asset;
- (BOOL)isCameraRollAlbum:(id)metadata;

/// 检查照片大小是否满足最小要求
- (BOOL)isPhotoSelectableWithAsset:(id)asset;
- (CGSize)photoSizeWithAsset:(id)asset;

@property (nonatomic, assign) BOOL shouldFixOrientation;
/// 修正图片转向
- (UIImage *)fixOrientation:(UIImage *)aImage;

/// 获取asset的资源类型
- (TZAssetModelMediaType)getAssetType:(id)asset;

@end
