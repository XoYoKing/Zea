//
//  QHPCDPickerView.h
//  PickerViewDemo
//
//  Created by GuanQinghao on 29/10/2017.
//  Copyright © 2017 GuanQinghao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectedPCDBlock)(NSString * _Nullable code, NSString * _Nullable province, NSString * _Nullable city, NSString * _Nullable district);

@interface QHPCDPickerView : UIView

@property (nonatomic, copy) SelectedPCDBlock _Nullable selectedPCDBlock;

- (IBAction)pickerViewShown:(id _Nullable )sender;
- (IBAction)pickerViewDismiss:(id _Nullable )sender;

@end
