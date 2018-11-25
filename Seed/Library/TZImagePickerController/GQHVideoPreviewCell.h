//
//  GQHVideoPreviewCell.h
//  GQHKit
//
//  Created by GuanQinghao on 06/02/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import "GQHAssetPreviewCell.h"

@class AVPlayer,AVPlayerLayer;
@interface GQHVideoPreviewCell : GQHAssetPreviewCell

@property (nonatomic, strong) AVPlayer *qh_player;
@property (nonatomic, strong) AVPlayerLayer *qh_playerLayer;

@property (nonatomic, strong) UIButton *qh_playButton;
@property (nonatomic, strong) UIImage *qh_coverImage;

- (void)qh_pausePlayer;

@end
