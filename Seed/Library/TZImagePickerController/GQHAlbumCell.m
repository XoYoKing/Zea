//
//  GQHAlbumCell.m
//  GQHKit
//
//  Created by GuanQinghao on 08/02/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import "GQHAlbumCell.h"
#import "GQHAlbumModel.h"
#import "GQHImageManager.h"

@interface GQHAlbumCell ()

@property (nonatomic, strong) UIImageView *posterImageView;

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation GQHAlbumCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return self;
}

#pragma mark --Setter
- (void)setQh_albumModel:(GQHAlbumModel *)qh_albumModel {
    
    _qh_albumModel = qh_albumModel;
    NSMutableAttributedString *nameString = [[NSMutableAttributedString alloc] initWithString:qh_albumModel.qh_albumName attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    NSAttributedString *countString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"  (%zd)",qh_albumModel.qh_assetCount] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    
    [nameString appendAttributedString:countString];
    self.titleLabel.attributedText = nameString;
    
    [[GQHImageManager qh_manager] qh_fetchPosterImageWithAlbumModel:qh_albumModel completionHandler:^(UIImage *posterImage) {
        
        self.posterImageView.image = posterImage;
    }];
    
    if (qh_albumModel.qh_selectedAssetModelCount) {
        
        self.qh_selectedCountButton.hidden = NO;
        [self.qh_selectedCountButton setTitle:[NSString stringWithFormat:@"%zd",qh_albumModel.qh_selectedAssetModelCount] forState:UIControlStateNormal];
    } else {
        
        self.qh_selectedCountButton.hidden = YES;
    }
}

#pragma mark --Getter
- (UIButton *)qh_selectedCountButton {
    
    if (!_qh_selectedCountButton) {
        
        _qh_selectedCountButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _qh_selectedCountButton.layer.cornerRadius = 12.0;
        _qh_selectedCountButton.clipsToBounds = YES;
        _qh_selectedCountButton.backgroundColor = [UIColor redColor];
        [_qh_selectedCountButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _qh_selectedCountButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_qh_selectedCountButton];
    }
    
    return _qh_selectedCountButton;
}

- (UIImageView *)posterImageView {
    
    if (!_posterImageView) {
        
        _posterImageView = [[UIImageView alloc] init];
        _posterImageView.contentMode = UIViewContentModeScaleAspectFill;
        _posterImageView.clipsToBounds = YES;
        [self.contentView addSubview:_posterImageView];
    }
    
    return _posterImageView;
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:17];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_titleLabel];
    }
    
    return _titleLabel;
}

@end
