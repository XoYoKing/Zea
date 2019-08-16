//
//  GQHRecordsView.h
//
//  Created by GuanQinghao on 2019-08-11.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import "GQHBaseView.h"


/**
 自定义视图的代理
 */
@protocol GQHRecordsViewDelegate <NSObject>

@required

@optional

@end


#pragma mark -

NS_ASSUME_NONNULL_BEGIN

/**
 自定义根视图
 */
@interface GQHRecordsView : GQHBaseView

/**
 视图代理
 */
@property (nonatomic, weak) id<GQHRecordsViewDelegate> qh_delegate;

/**
 视图数据
 */
@property (nonatomic, strong) id qh_data;

/**
 列表视图
 */
@property (nonatomic, strong) UITableView *qh_tableView;

@end

NS_ASSUME_NONNULL_END


#pragma mark -

NS_ASSUME_NONNULL_BEGIN

/**
 列表视图的自定义行视图
 */
@interface GQHRecordsTableViewCell : UITableViewCell

/**
 视图代理
 */
@property (nonatomic, weak) id<GQHRecordsViewDelegate> qh_delegate;

/**
 视图数据
 */
@property (nonatomic, strong) id qh_data;

/**
 根据视图数据创建列表视图的行视图
 
 @param tableView 列表视图
 @param data 列表行视图数据
 @return 自定义行视图
 */
+ (instancetype)qh_tableView:(UITableView *)tableView cellWithData:(nullable id)data;

@end

NS_ASSUME_NONNULL_END


#pragma mark -

NS_ASSUME_NONNULL_BEGIN

/**
 列表视图的自定义头视图
 */
@interface GQHRecordsTableViewHeaderView : UITableViewHeaderFooterView

/**
 视图代理
 */
@property (nonatomic, weak) id<GQHRecordsViewDelegate> qh_delegate;

/**
 视图数据
 */
@property (nonatomic, strong) id qh_data;

/**
 根据视图数据创建列表视图的头视图
 
 @param tableView 列表视图
 @param data 列表头视图数据
 @return 自定义头视图
 */
+ (instancetype)qh_tableView:(UITableView *)tableView headerViewWithData:(nullable id)data;

@end

NS_ASSUME_NONNULL_END


#pragma mark -

NS_ASSUME_NONNULL_BEGIN

/**
 列表视图的自定义尾视图
 */
@interface GQHRecordsTableViewFooterView : UITableViewHeaderFooterView

/**
 视图代理
 */
@property (nonatomic, weak) id<GQHRecordsViewDelegate> qh_delegate;

/**
 视图数据
 */
@property (nonatomic, strong) id qh_data;

/**
 根据视图数据创建列表视图的尾视图
 
 @param tableView 列表视图
 @param data 列表尾视图数据
 @return 自定义尾视图
 */
+ (instancetype)qh_tableView:(UITableView *)tableView footerViewWithData:(nullable id)data;

@end

NS_ASSUME_NONNULL_END
