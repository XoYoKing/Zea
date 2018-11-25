//
//  GQHGameController.m
//  Seed
//
//  Created by GuanQinghao on 08/03/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#pragma mark Macro
#import "GQHHeader.h"

#pragma mark Model

#pragma mark Object
#import "GQHImageCuttingHelper.h"

#pragma mark View
#import "GQHGameView.h"
#import "GQHSliderImageView.h"

#pragma mark Controller
#import "GQHGameController.h"

#pragma mark CocoaPods

#pragma mark ----------Header End----------


@interface GQHGameController () <GQHSliderImageViewDelegate> {
    
#pragma mark Data
    BOOL start;
    NSUInteger matching; // 滑块归位匹配度
    NSUInteger timestamp; // 游戏时间
    NSUInteger steps; // 移动步数
    
#pragma mark View
    
    UIImageView *vectorView;
    GQHSliderImageView *sliderView;
}

/// 自定义视图
@property (nonatomic, strong) GQHGameView *rootView;

/// 游戏等级对应行列数 (3, 4, 6, 8)
@property (nonatomic, assign) NSUInteger levelRanks;
/// 游戏等级对应滑块大小
@property (nonatomic, assign) CGFloat levelSize;

@end


@implementation GQHGameController

#pragma mark --Lifecycle
- (void)loadView {
    // 添加自定义视图
    DLog();
    
    self.view = self.rootView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    DLog();
    
    /// 游戏图片切割
    NSString *userImageName = [NSUserDefaults.standardUserDefaults valueForKey: GQHUserImageKey];
    UIImage *userImage = [UIImage imageNamed:userImageName];
    [GQHImageCuttingHelper qh_cutImage:userImage byRow:self.levelRanks column:self.levelRanks quality:1.0];
    
    /// 游戏滑块
    [self layoutSliders];
    
    _qh_timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(runTimer:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_qh_timer forMode:NSRunLoopCommonModes];
    [_qh_timer setFireDate:[NSDate distantFuture]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    DLog();
    
    [self.qh_titleButton setTitle:NSLocalizedString(@"puzzle", @"拼图") forState:UIControlStateNormal];
    
    [self.qh_rightMostButton setBackgroundImage:[UIImage imageNamed:@"game_reset"] forState:UIControlStateNormal];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    DLog();
    
}

#pragma mark --Data

#pragma mark --Delegate
- (void)qh_slide:(UIImageView *)imageView {
    
    CGFloat originX = imageView.frame.origin.x;
    CGFloat originY = imageView.frame.origin.y;
    CGFloat tempX = vectorView.frame.origin.x;
    CGFloat tempY = vectorView.frame.origin.y;
    
    if(tempX == originX + self.levelSize && tempY == originY) {
        
        [self moveRight:imageView];
    }
    
    if(tempX == originX - self.levelSize && tempY == originY) {
        
        [self moveLeft:imageView];
    }
    
    if(tempX == originX && tempY == originY + self.levelSize) {
        
        [self moveDown:imageView];
    }
    
    if(tempX == originX && tempY == originY - self.levelSize) {
        
        [self moveUp:imageView];
    }
    
    steps++;
    [self.rootView.qh_countTextLabel setText:[NSString stringWithFormat:@"%lu",steps]];
    
    if (start) {
        [self completedSuccessfully];
    }
}

#pragma mark --TargetMethod
- (void)qh_clickedRightMostButton:(UIButton *)sender {
    
    start = NO;
    
    for (int i = 0; i < 1000; i++) {
        
        NSUInteger randomTag = 1000 + 10 * (arc4random() % self.levelRanks) + (arc4random() % self.levelRanks);
        if (randomTag == (1000 + 10 * self.levelRanks + self.levelRanks - 11)) {
            
            continue;
        }
        
        UIImageView *imageView = (UIImageView *)[self.view viewWithTag:randomTag];
        [self qh_slide:imageView];
    }
    
    NSArray *subViewArray = [self.rootView.qh_gameView subviews];
    for (GQHSliderImageView *subView in subViewArray) {
        
        [subView setUserInteractionEnabled:YES];
    }
    
    GQHSliderImageView *lastSliderView = (GQHSliderImageView *)[self.view viewWithTag:(1000 + 10 * self.levelRanks + self.levelRanks - 11)];
    [lastSliderView setHidden:YES];
    
    matching = 0;
    _qh_running = NO;
    timestamp = 0;
    steps = 0;
    
    self.rootView.qh_timeTextLabel.text = @"00:00";
    self.rootView.qh_timeTextLabel.textColor = [UIColor qh_darkBlackColor];
    self.rootView.qh_countTextLabel.text = @"0";
    self.rootView.qh_countTextLabel.textColor = [UIColor qh_darkBlackColor];
    
    [_qh_timer setFireDate:[NSDate distantFuture]];
    start = YES;
}

- (IBAction)runTimer:(id)sender {
    
    timestamp++;
    NSString *timeString = [NSString stringWithFormat:@"%02d:%02d", (int)(timestamp/60), (int)(timestamp%60)];
    if (timestamp < 3600) {
        
        [self.rootView.qh_timeTextLabel setText:timeString];
    } else {
        
        timestamp = 0;
        self.rootView.qh_timeTextLabel.text = @"超时!";
        self.rootView.qh_timeTextLabel.textColor = [UIColor redColor];
    }
}

#pragma mark 游戏是否结束
- (void)completedSuccessfully {
    
    if (!_qh_running) {
        
        [_qh_timer setFireDate:[NSDate distantPast]];
        _qh_running = YES;
    }
    
    for (int i = 1000; i < 1099; i++) {
        
        UIImageView *sliderView = (UIImageView *)[self.view viewWithTag:i];
        if (sliderView == nil) {
            continue;
        }
        
        float currentX = sliderView.frame.origin.x;
        float currentY = sliderView.frame.origin.y;
        float correctX = self.levelSize * (i%10);
        float correctY = self.levelSize * (i/10%10);
        
        if (currentX == correctX && currentY == correctY) {
            
            matching++;
        }
        
        if (matching == (self.levelRanks * self.levelRanks)) {
            
            NSArray *sliderViewArray = [self.rootView.qh_gameView subviews];
            
            for (GQHSliderImageView *subView in sliderViewArray) {
                
                [subView setUserInteractionEnabled:NO];
            }
            
            [_qh_timer setFireDate:[NSDate distantFuture]];
            
            [self alertingWithTitle:@"BINGO!" Message:@"AWESOME! DO IT AGAIN!"];
            
            break;
        }
    }
    matching = 0;
}

- (void)alertingWithTitle:(NSString *)title Message:(NSString *)message {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message: message preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"NO" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self qh_clickedRightMostButton:nil];
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark --PrivateMethod

#pragma mark ---上下左右移动
- (void)moveUp:(UIImageView *)imageView {
    
    [UIView animateWithDuration:0.2 animations:^{
        
        [imageView setFrame:CGRectMake(imageView.frame.origin.x, imageView.frame.origin.y - self.levelSize, self.levelSize, self.levelSize)];
        [vectorView setFrame:CGRectMake(imageView.frame.origin.x, imageView.frame.origin.y + self.levelSize, self.levelSize, self.levelSize)];
    }];
}

- (void)moveLeft:(UIImageView *)imageView {
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2f];
    [UIView setAnimationDelegate:self];
    
    CGRect imageFrame = CGRectMake(imageView.frame.origin.x - self.levelSize, imageView.frame.origin.y, self.levelSize, self.levelSize);
    imageView.frame = imageFrame;
    
    CGRect tempFrame = CGRectMake(imageView.frame.origin.x + self.levelSize,imageView.frame.origin.y, self.levelSize, self.levelSize);
    vectorView.frame = tempFrame;
    
    [UIView commitAnimations];
}

- (void)moveRight:(UIImageView *)imageView {
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2f];
    [UIView setAnimationDelegate:self];
    
    CGRect imageFrame = CGRectMake(imageView.frame.origin.x + self.levelSize, imageView.frame.origin.y, self.levelSize, self.levelSize);
    imageView.frame = imageFrame;
    
    CGRect tempFrame = CGRectMake(imageView.frame.origin.x - self.levelSize,imageView.frame.origin.y, self.levelSize, self.levelSize);
    vectorView.frame = tempFrame;
    
    [UIView commitAnimations];
}

- (void)moveDown:(UIImageView *)imageView {
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2f];
    [UIView setAnimationDelegate:self];
    
    CGRect imageFrame = CGRectMake(imageView.frame.origin.x, imageView.frame.origin.y + self.levelSize, self.levelSize, self.levelSize);
    imageView.frame = imageFrame;
    
    CGRect tempFrame = CGRectMake(imageView.frame.origin.x,imageView.frame.origin.y - self.levelSize, self.levelSize, self.levelSize);
    vectorView.frame = tempFrame;
    
    [UIView commitAnimations];
}

- (void)layoutSliders {
    
    // 移除子视图
    [self.rootView.qh_gameView qh_removeAllSubviews];
    
    for(int i = 0; i < self.levelRanks; i++) {
        for (int j = 0; j < self.levelRanks; j++) {
            
            NSString *imagesDirectoryPath = [GQHConstantHelper qh_imagesDirectoryPath];
            NSString *imagesPath = [imagesDirectoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"/pic_%02d_%02d.png",i,j]];
            UIImage *image = [UIImage imageWithContentsOfFile:imagesPath];
            
            //-----------------------------------------------------
            NSString *tagString = [NSString stringWithFormat:@"%d",(1000 + 10 * i + j)];
            NSMutableAttributedString *aString = [[NSMutableAttributedString alloc] initWithString:tagString];
            
            [aString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:40] range:NSMakeRange(0, 4)];
            [aString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 4)];
            [aString addAttribute:NSBackgroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, 4)];
            
            image = [image qh_watermarkImageWithRect:CGRectMake(0, 0, image.size.width, image.size.height) string: aString];
            //----------------------------------------------------
            
            sliderView = [[GQHSliderImageView alloc] initWithImage:image];
            sliderView.frame = CGRectMake(self.levelSize * j, self.levelSize * i, self.levelSize, self.levelSize);
            sliderView.qh_delegate = self;
            sliderView.tag = (1000 + 10 * i + j);
            [self.rootView.qh_gameView addSubview:sliderView];
        }
    }
    
    NSInteger lastTag = 1000 + 10 * (self.levelRanks - 1) + (self.levelRanks - 1);
    GQHSliderImageView *lastSliderView = (GQHSliderImageView *)[self.rootView viewWithTag:lastTag];
    [lastSliderView setHidden:YES];
    
    vectorView = [[UIImageView alloc]init];
    vectorView.frame = CGRectMake(self.levelSize * (self.levelRanks - 1), self.levelSize * (self.levelRanks - 1), self.levelSize, self.levelSize);
    vectorView.tag = 100;
    vectorView.contentMode = UIViewContentModeScaleToFill;
    vectorView.backgroundColor = [UIColor clearColor];
    [self.rootView.qh_gameView addSubview:vectorView];
    [self.rootView.qh_gameView sendSubviewToBack:vectorView];
    
    [self qh_clickedRightMostButton:nil];
}

#pragma mark --Setter

#pragma mark --Getter
/// 自定义根视图
- (GQHGameView *)rootView {
    
    if (!_rootView) {
        
        _rootView = [[GQHGameView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    }
    
    return _rootView;
}
/// 游戏等级对应的行列数
- (NSUInteger)levelRanks {
    
    NSNumber *levelRanksValue = [NSUserDefaults.standardUserDefaults objectForKey:GQHUserLevelKey];
    return levelRanksValue.unsignedIntegerValue;
}
/// 游戏等级对应的滑块大小
- (CGFloat)levelSize {
    
    return (CGRectGetWidth(UIScreen.mainScreen.bounds) - 20.0f) / self.levelRanks;
}

@end
