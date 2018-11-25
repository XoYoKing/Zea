//
//  GQHVideoPreviewCell.m
//  GQHKit
//
//  Created by GuanQinghao on 06/02/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import "GQHVideoPreviewCell.h"
#import "GQHImageManager.h"
#import "GQHAssetModel.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

@implementation GQHVideoPreviewCell

- (void)qh_configureSubviews {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(qh_pausePlayer) name:UIApplicationWillResignActiveNotification object:nil];
}

- (void)configurePlayButton {
    
    if (_qh_playButton) {
        
        [_qh_playButton removeFromSuperview];
    }
    
    _qh_playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_qh_playButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [_qh_playButton setImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    [_qh_playButton addTarget:self action:@selector(clickPlayButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_qh_playButton];
    
}

- (IBAction)clickPlayButton:(id)sender {
    
    CMTime currentTime = _qh_player.currentItem.currentTime;
    CMTime duration = _qh_player.currentItem.duration;
    
    if (_qh_player.rate == 0.0f) {
        
        if (currentTime.value == duration.value) {
            
            [_qh_player.currentItem seekToTime:CMTimeMake(0, 1)];
        }
        
        [_qh_player play];
        [_qh_playButton setImage:nil forState:UIControlStateNormal];
        
        [UIApplication sharedApplication].statusBarHidden = YES;
        if (self.singleTapGestureBlock) {
            
            self.singleTapGestureBlock();
        }
    } else {
        
        [self qh_pausePlayer];
    }
}

- (void)qh_pausePlayer {
    
    if (0 != _qh_player.rate ) {
        
        [_qh_player pause];
        [_qh_playButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        
        if (self.singleTapGestureBlock) {
            
            self.singleTapGestureBlock();
        }
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _qh_playerLayer.frame = self.bounds;
    _qh_playButton.frame = CGRectMake(0, 64, self.frame.size.width, self.frame.size.height - 64 - 44);
}

- (void)qh_previewCollectionViewDidScroll {
    
    [self qh_pausePlayer];
}

#pragma mark --Setter
// 父类属性
- (void)setQh_assetModel:(GQHAssetModel *)qh_assetModel {
    [super setQh_assetModel:qh_assetModel];
    
    [self configureVideoPlayer];
}

- (void)configureVideoPlayer {
    
    if (_qh_player) {
        
        [_qh_playerLayer removeFromSuperlayer];
        _qh_playerLayer = nil;
        [_qh_player pause];
        _qh_player = nil;
    }
    
    [[GQHImageManager qh_manager] qh_fetchPhotoWithAsset:self.qh_assetModel.qh_asset completionHandler:^(UIImage *photo, NSDictionary *info, BOOL isDegraded) {
        _qh_coverImage = photo;
    }];
    
    [[GQHImageManager qh_manager] qh_fetchVideoWithAsset:self.qh_assetModel.qh_asset completionHandler:^(AVPlayerItem *playItem, NSDictionary *info) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            _qh_player = [AVPlayer playerWithPlayerItem:playItem];
            _qh_playerLayer = [AVPlayerLayer playerLayerWithPlayer:_qh_player];
            _qh_playerLayer.backgroundColor = [UIColor blackColor].CGColor;
            _qh_playerLayer.frame = self.bounds;
            
            [self.layer addSublayer:_qh_playerLayer];
            [self configurePlayButton];
            
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(qh_pausePlayer) name:AVPlayerItemDidPlayToEndTimeNotification object:_qh_player.currentItem];
        });
    }];
}

@end
