//
//  GQHGuideView.h
//  Seed
//
//  Created by GuanQinghao on 2018/10/22.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GQHGuideViewManager :NSObject

/// 是否仅首次启动展示
@property (nonatomic, assign) BOOL qh_debut;
/// 滚动到最后一页是否自动进入
@property (nonatomic, assign) BOOL qh_autoIn;
/// 是否显示分页控件
@property (nonatomic, assign) BOOL qh_hideIndicator;

/// 单例
+ (instancetype)qh_sharedManager;
- (void)qh_showGuideViewWithImageArray:(NSArray *)imageArray;

@end

