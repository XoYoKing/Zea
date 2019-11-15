//
//  GQHGameController.m
//
//  Created by GuanQinghao on 2019-08-11.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#pragma mark Other
#import "GQHHeader.h"
#import "GQHPuzzleStatus.h"

#pragma mark Model

#pragma mark View
#import "GQHGameView.h"

#pragma mark Controller
#import "GQHGameController.h"


#pragma mark -

@interface GQHGameController () <GQHGameViewDelegate>

/**
 自定义根视图
 */
@property (nonatomic, strong) GQHGameView *rootView;

/**
 数据源
 */
@property (nonatomic, strong) NSMutableArray *dataSourceArray;



/**
 游戏图片 (本地读取)
 */
@property (nonatomic, strong) UIImage *gameImage;

/**
 游戏等级
 */
@property (nonatomic, assign) NSInteger level;






/**
 当前的游戏状态
 */
@property (nonatomic, strong) GQHPuzzleStatus *currentStatus;

/**
 完成时游戏状态
 */
@property (nonatomic, strong) GQHPuzzleStatus *endStatus;

/**
 保存的游戏状态
 */
@property (nonatomic, strong) GQHPuzzleStatus *savedStatus;

/**
 正在自动拼图
 */
@property (nonatomic, assign, getter=isAutoGaming) BOOL autoGaming;

@end

@implementation GQHGameController

#pragma mark - Lifecycle
/**
 1.加载系统根视图或自定义根视图
 */
- (void)loadView {
    [super loadView];
    NSLog(@"");
    
    self.view = self.rootView;
}

/**
 2.视图加载完成
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"");
    
    [self.qh_titleButton setTitle:NSLocalizedString(@"puzzle", @"拼图") forState:UIControlStateNormal];
    [self.qh_rightMostButton setImage:[UIImage imageNamed:GQHNavigationBarResetBlackOnClear] forState:UIControlStateNormal];
    
    self.level = 11;
}

/**
 3.视图即将显示
 
 @param animated 是否显示动画效果
 */
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"");
    
    // 是否有未报保存的游戏
    
    
    // 加载图片并打乱顺序 相当于重置游戏
    [self resetGame:nil];
    
}

/**
 4.视图即将布局其子视图
 */
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    NSLog(@"");
    
}

/**
 5.视图已经布局其子视图
 */
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    NSLog(@"");
    
}

/**
 6.视图已经显示
 
 @param animated 是否显示动画效果
 */
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"");
    
}

/**
 7.视图即将消失
 
 @param animated 是否显示动画效果
 */
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"");
    
}

/**
 8.视图已经消失
 
 @param animated 是否显示动画效果
 */
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"");
    
}

/**
 9.视图被销毁
 */
- (void)dealloc {
    NSLog(@"");
    
}

#pragma mark - GQHGameViewDelegate

#pragma mark - TargetMethod
/// 触摸拼图块
/// @param sender 拼图块
- (IBAction)touchPuzzlePiece:(GQHPuzzlePiece *)sender {
    NSLog(@"");
    
    if (self.isAutoGaming) {
        
        return;
    }
    
    GQHPuzzleStatus *status = self.currentStatus;
    NSInteger index = [status.qh_puzzlePieceArray indexOfObject:sender];
    
    if (![status qh_canMoveTo:index]) {
        
        // 触摸其他拼图块
        NSLog(@"无法移动");
        return;
    }
    
    [status qh_moveTo:index];
    
    //MARK: 重新加载拼图板
    [self reloadGameBoardWithStatus:self.currentStatus order:self.level];
    
    // 完成
    if ([status qh_isEqualTo:self.endStatus]) {
        
        NSLog(@"完成");
        //TODO:完成
        GQHPuzzlePiece *piece = [self.endStatus.qh_puzzlePieceArray lastObject];
        piece.alpha = 1.0f;
        status.qh_mark = -1;
    }
}

#pragma mark - PrivateMethod

/// 重置游戏
/// @param sender 重置按钮
- (IBAction)resetGame:(id)sender {
    
    if (self.isAutoGaming) {
        
        return;
    }
    
    if (!self.gameImage) {
        
        return;
    }
    
    if (self.currentStatus) {
        
        // 移除当前状态
        [self.currentStatus qh_removeAllPieces];
    }
    
    //MARK:准备拼图块
    self.currentStatus = [GQHPuzzleStatus qh_puzzleStatusWithOrder:self.level image:self.gameImage];
    
    [self.currentStatus.qh_puzzlePieceArray enumerateObjectsUsingBlock:^(GQHPuzzlePiece * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        // 添加触摸事件
        [obj addTarget:self action:@selector(touchPuzzlePiece:) forControlEvents:UIControlEventTouchUpInside];
    }];
    
    self.endStatus = nil;
    
    //MARK:显示游戏板
    [self loadGameBoardView:self.rootView.qh_gameboardView order:self.level];
    
    //MARK:打乱顺序
    [self shuffleGameBoardViewWithOrder:self.level];
}

/// 加载游戏板
/// @param boardView 游戏板
/// @param order 阶数
- (void)loadGameBoardView:(UIView *)boardView order:(NSInteger)order {
    
    // 拼图板宽度
    CGFloat boardWith = self.rootView.qh_contentAreaWidth - 2 * GQHSpacing;
    
    // 拼图块宽度和高度
    CGFloat width = boardWith/order;
    CGFloat height = width;
    
    
    NSInteger index = 0;
    for (NSInteger row = 0; row < order; row++) {
        for (NSInteger column = 0; column < order; column++) {
            
            //TODO:优化复杂度
            GQHPuzzlePiece *piece = self.currentStatus.qh_puzzlePieceArray[index++];
            piece.frame = CGRectMake(column * width, row * height, width, height);
            [boardView addSubview:piece];
        }
    }
    
    
    // 设置空格
    if (self.currentStatus.qh_mark < 0) {
        
        // 空格只是变成透明
        GQHPuzzlePiece *last = [self.currentStatus.qh_puzzlePieceArray lastObject];
        last.alpha = 0;
        self.currentStatus.qh_mark = self.currentStatus.qh_puzzlePieceArray.count - 1;
        
        // 设置目标状态
        self.endStatus = [self.currentStatus qh_copy];
    }
}

/// 重新加载游戏板
/// @param status 拼图块状态
- (void)reloadGameBoardWithStatus:(GQHPuzzleStatus *)status order:(NSInteger)order {
    NSLog(@"%s",__func__);
    
    [UIView animateWithDuration:0.15f animations:^{
        
        // 拼图块宽度和高度
        CGFloat width = CGRectGetWidth(status.qh_puzzlePieceArray.firstObject.frame);
        CGFloat height = CGRectGetHeight(status.qh_puzzlePieceArray.firstObject.frame);
        
        
        NSInteger index = 0;
        for (NSInteger row = 0; row < order; row++) {
            for (NSInteger column = 0; column < order; column++) {
                
                //TODO:优化复杂度
                GQHPuzzlePiece *piece = status.qh_puzzlePieceArray[index++];
                piece.frame = CGRectMake(column * width, row * height, width, height);
            }
        }
    }];
}

/// 打乱拼图块顺序(洗牌)
- (void)shuffleGameBoardViewWithOrder:(NSInteger)order {
    
    if (self.isAutoGaming) {
        
        return;
    }
    
    if (self.currentStatus.qh_mark < 0) {
        
        return;
    }
    
    NSLog(@"洗牌:%@阶矩阵, 随机移动%@步",@(order),@(order * order * 100));
    
    [self.currentStatus qh_shuffle:(order * order * 100)];
    [self reloadGameBoardWithStatus:self.currentStatus order:order];
}



#pragma mark - Setter

#pragma mark - Getter
- (GQHGameView *)rootView {
    
    if (!_rootView) {
        
        _rootView = [[GQHGameView alloc] initWithFrame:UIScreen.mainScreen.bounds];
        _rootView.backgroundColor = [UIColor qh_colorWithHexString:@"#f8f8f8"];
        _rootView.qh_delegate = self;
    }
    
    return _rootView;
}

- (NSMutableArray *)dataSourceArray {
    
    if (!_dataSourceArray) {
        
        _dataSourceArray = [NSMutableArray array];
    }
    
    return _dataSourceArray;
}

- (UIImage *)gameImage {
    
    if (!_gameImage) {
        
        _gameImage = [UIImage imageNamed:@"puzzle_4"];
    }
    
    return _gameImage;
}

@end
