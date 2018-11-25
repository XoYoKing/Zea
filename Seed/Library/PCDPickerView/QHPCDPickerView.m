//
//  QHPCDPickerView.m
//
//
//  Created by GuanQinghao on 29/10/2017.
//  Copyright © 2017 GuanQinghao. All rights reserved.
//

#import "QHPCDPickerView.h"

static CGFloat const toolBarHeight = 45;
static CGFloat const pickerViewHeight = 216;

@interface QHPCDPickerView () <UIPickerViewDataSource, UIPickerViewDelegate> {
    
    UIPickerView *pickerView;
    
    UIView *toolBar;
    UIButton *cancelButton;
    UIButton *confirmButton;
    UILabel *previewLabel;
}

@property (nonatomic, strong) NSArray *rootArray;

@property (nonatomic, strong, nullable) NSMutableArray *provinceArray;
@property (nonatomic, strong, nullable) NSMutableArray *cityArray;
@property (nonatomic, strong, nullable) NSMutableArray *districtArray;

@property (nonatomic, strong, nullable)NSString *code;
@property (nonatomic, strong, nullable)NSString *province;
@property (nonatomic, strong, nullable)NSString *city;
@property (nonatomic, strong, nullable)NSString *district;

@end

@implementation QHPCDPickerView

- (IBAction)pickerViewShown:(id _Nullable)sender {
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self setCenter:[UIApplication sharedApplication].keyWindow.center];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [self.layer setOpacity:1];
        [toolBar setFrame:CGRectMake(0, self.frame.size.height - toolBarHeight - pickerViewHeight, self.frame.size.width, toolBarHeight)];
        [pickerView setFrame:CGRectMake(0, self.frame.size.height - pickerViewHeight, self.frame.size.width, pickerViewHeight)];
    } completion:nil];
}
- (IBAction)pickerViewDismiss:(id _Nullable)sender {
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [self.layer setOpacity:0];
        [toolBar setFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, toolBarHeight)];
        [pickerView setFrame:CGRectMake(0, self.frame.size.height + toolBarHeight, self.frame.size.width, pickerViewHeight)];
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
}

- (instancetype)init {
    self = [super init];
    
    if (self) {
        
        [self setBounds:[UIScreen mainScreen].bounds];
        [self setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.3]];
        [self.layer setOpaque:NO];
        
        UITapGestureRecognizer *click = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pickerViewDismiss:)];
        [self addGestureRecognizer:click];
        
        pickerView = [[UIPickerView alloc]init];
        [pickerView setFrame:CGRectMake(0, self.frame.size.height - pickerViewHeight, self.frame.size.width, pickerViewHeight)];
        [pickerView setBackgroundColor:[UIColor whiteColor]];
        [pickerView setDataSource:self];
        [pickerView setDelegate:self];
        [self addSubview:pickerView];
        
        toolBar = [[UIView alloc]init];
        [toolBar setFrame:CGRectMake(0, self.frame.size.height - pickerViewHeight - toolBarHeight, self.frame.size.width, toolBarHeight)];
        [toolBar setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:toolBar];
        
        cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelButton setFrame:CGRectMake(0, 0, toolBarHeight, toolBarHeight)];
        [cancelButton.titleLabel setFont:[UIFont systemFontOfSize:17.0]];
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(pickerViewDismiss:) forControlEvents:UIControlEventTouchUpInside];
        [toolBar addSubview:cancelButton];
        
        confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [confirmButton setFrame:CGRectMake(self.frame.size.width - toolBarHeight, 0, toolBarHeight, toolBarHeight)];
        [confirmButton.titleLabel setFont:[UIFont systemFontOfSize:17.0]];
        [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        [confirmButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [confirmButton addTarget:self action:@selector(confirmSelectedPCD:) forControlEvents:UIControlEventTouchUpInside];
        [toolBar addSubview:confirmButton];
        
        previewLabel = [[UILabel alloc]init];
        [previewLabel setFrame:CGRectMake(toolBarHeight, 0, self.frame.size.width - 2 * toolBarHeight, toolBarHeight)];
        [previewLabel setFont:[UIFont systemFontOfSize:17.0]];
        [previewLabel setTextColor:[UIColor blackColor]];
        [previewLabel setTextAlignment:NSTextAlignmentCenter];
        [toolBar addSubview:previewLabel];
        
        [self loadPCDData];
    }
    return self;
}
- (IBAction)confirmSelectedPCD:(id _Nullable)sender {
    
    if (_selectedPCDBlock) {
        
        _selectedPCDBlock(_code,_province, _city, _district);
    }
    [self pickerViewDismiss:nil];
}
- (void)loadPCDData {
    
    [self.rootArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [self.provinceArray addObject:obj];
    }];
    
    NSMutableArray *cities = [NSMutableArray arrayWithArray:[[self.provinceArray firstObject] objectForKey:@"cities"]];
    [cities enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [self.cityArray addObject:obj];
    }];
    
    NSMutableArray *districts = [NSMutableArray arrayWithArray:[[self.cityArray firstObject] objectForKey:@"districts"]];
    [districts enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [self.districtArray addObject:obj];
    }];
    
    [self reloadSelectAddress];
}

#pragma mark --UIPickerViewDelegate
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    
    return 45;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    switch (component) {
        case 0: {
            
            if (row < self.provinceArray.count) {
                
                [self updateCitiesComponent:self.provinceArray[row] Row:row];
            }
        }
            break;
        case 1: {
            if (row < self.cityArray.count) {
                
                [self updateDistrictsComponent:self.cityArray[row] Row:row];
            }
        }
            break;
        case 2: {
            
        }
            break;
        default:
            break;
    }
    [self reloadSelectAddress];
}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    UILabel *rowLabel = [[UILabel alloc]init];
    [rowLabel setFrame:CGRectMake(0, 0, pickerView.frame.size.width/3, 30)];
    [rowLabel setFont:[UIFont systemFontOfSize:14]];
    [rowLabel setTextColor:[UIColor blackColor]];
    [rowLabel setTextAlignment:NSTextAlignmentCenter];
    
    NSString *text = @"";
    switch (component) {
        case 0: {
            if (row < self.provinceArray.count) {
                
                text = [self.provinceArray[row] objectForKey:@"name"];
            }
        }
            break;
        case 1: {
            if (row < self.cityArray.count) {
                
                text = [self.cityArray[row] objectForKey:@"name"];
            }
        }
            break;
        case 2: {
            if (row < self.districtArray.count) {
                
                text = [self.districtArray[row] objectForKey:@"name"];
            }
        }
            break;
            
        default:
            break;
    }
    if ([text length] > 0) {
        
        [rowLabel setText:text];
    }
    return rowLabel;
}
#pragma mark --UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 3;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    switch (component) {
        case 0:
            return self.provinceArray.count;
            break;
        case 1:
            return self.cityArray.count;
            break;
        case 2:
            return self.districtArray.count;
            break;
            
        default:
            return 0;
            break;
    }
}

- (void)updateCitiesComponent:(NSDictionary *)dict Row:(NSInteger)row {
    
    NSMutableArray *cities = [NSMutableArray arrayWithArray:[dict objectForKey:@"cities"]];
    [self.cityArray removeAllObjects];
    [cities enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.cityArray addObject:obj];
    }];
    [pickerView reloadComponent:1];
    [pickerView selectRow:0 inComponent:1 animated:YES];
    
    if (self.cityArray.count > 0) {
        
        [self updateDistrictsComponent:self.cityArray[0] Row:0];
    } else {
        
        [self updateDistrictsComponent:@{@"":@""} Row:0];
        self.city = @"";
    }
}
- (void)updateDistrictsComponent:(NSDictionary *)dict Row:(NSInteger)row {
    
    [self.districtArray removeAllObjects];
    NSMutableArray *districts = [NSMutableArray arrayWithArray:[dict objectForKey:@"districts"]];
    [districts enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.districtArray addObject:obj];
    }];
    [pickerView reloadComponent:2];
    [pickerView selectRow:0 inComponent:2 animated:YES];
}
- (void)reloadSelectAddress {
    
    NSInteger rowComponet0 = [pickerView selectedRowInComponent:0];
    NSInteger rowComponet1 = [pickerView selectedRowInComponent:1];
    NSInteger rowComponet2 = [pickerView selectedRowInComponent:2];
    
    _province = @"";
    _city = @"";
    _district = @"";
    
    if (self.provinceArray.count > 0) {
        
        _province = [self.provinceArray[rowComponet0] objectForKey:@"name"];
    }
    if (self.cityArray.count > 0) {
        
        _city = [self.cityArray[rowComponet1] objectForKey:@"name"];
    }
    if (self.districtArray.count > 0) {
        
        _district = [self.districtArray[rowComponet2] objectForKey:@"name"];
        _code = [self.districtArray[rowComponet2] objectForKey:@"id"];
    }
    NSString *address = [NSString stringWithFormat:@"%@%@%@", _province, _city, _district];
    [previewLabel setText:address];
}
#pragma mark --Getter
-(NSArray *)rootArray {
    
    if (!_rootArray) {
        
        _rootArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"pcd" ofType:@"plist"]];
    }
    return _rootArray;
}
- (NSMutableArray *)provinceArray {
    
    if (!_provinceArray) {
        
        _provinceArray = [NSMutableArray array];
    }
    return _provinceArray;
}
- (NSMutableArray *)cityArray {
    if (!_cityArray) {
        
        _cityArray = [NSMutableArray array];
    }
    return _cityArray;
}
- (NSMutableArray *)districtArray {
    if (!_districtArray) {
        
        _districtArray = [NSMutableArray array];
    }
    return _districtArray;
}
@end
