//
//  GQHAssetPreviewCell.m
//  GQHKit
//
//  Created by GuanQinghao on 06/02/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import "GQHAssetPreviewCell.h"

@implementation GQHAssetPreviewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor blackColor];
        [self qh_configureSubviews];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(qh_previewCollectionViewDidScroll) name:@"viewDidScroll" object:nil];
    }
    return self;
}

- (void)qh_configureSubviews {
    
}

- (void)qh_previewCollectionViewDidScroll {
    
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
