//
//  GQHAlbumCell.h
//  GQHKit
//
//  Created by GuanQinghao on 08/02/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GQHAlbumModel;
@interface GQHAlbumCell : UITableViewCell

@property (nonatomic, strong) GQHAlbumModel *qh_albumModel;

@property (nonatomic, strong) UIButton *qh_selectedCountButton;

@end
