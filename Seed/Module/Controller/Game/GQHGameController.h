//
//  GQHGameController.h
//  Seed
//
//  Created by GuanQinghao on 08/03/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import "GQHBaseController.h"


@interface GQHGameController : GQHBaseController

/// 游戏运行状态
@property (nonatomic, assign) BOOL qh_running;
/// 定时器
@property (nonatomic, strong) NSTimer *qh_timer;

@end
