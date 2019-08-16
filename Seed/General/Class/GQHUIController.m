//
//  GQHUIController.m
//
//  Created by GuanQinghao on 2019-05-30.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#pragma mark Other
#import "GQHHeader.h"

#pragma mark Model

#pragma mark View

#pragma mark Controller
#import "GQHUIController.h"


#pragma mark -

@interface GQHUIController () <UITableViewDelegate, UITableViewDataSource>

/**
 列表视图
 */
@property (nonatomic, strong) UITableView *tableView;

/**
 UI数据源
 */
@property (nonatomic, strong) NSMutableArray *dataSourceUIArray;

/**
 模型数据源
 */
@property (nonatomic, strong) NSMutableArray *dataSourceModelArray;

@end

@implementation GQHUIController

#pragma mark - Lifecycle
/**
 1.加载系统根视图或自定义根视图
 */
- (void)loadView {
    [super loadView];
    NSLog(@"");
    
}

/**
 2.视图加载完成
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"");
    
    // 打印类名
    [self printClassNames];
    
    // 添加列表视图
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.view).with.inset(self.view.qh_statusBarHeight + self.view.qh_navigationBarHeight);
        make.left.and.right.and.bottom.mas_equalTo(self.view);
    }];
}

/**
 3.视图即将显示
 
 @param animated 是否显示动画效果
 */
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"");
    
    self.qh_backButton.hidden = YES;
    self.qh_leftButton.hidden = YES;
    NSString *title = [NSString stringWithFormat:@"UI一览表(%@)",@([self totalCount:self.dataSourceUIArray])];
    [self.qh_titleButton setTitle:title forState:UIControlStateNormal];
    self.qh_rightButton.hidden = YES;
    self.qh_rightMostButton.hidden = YES;
}

/**
 4.视图即将布局其子视图
 */
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    NSLog(@"");
    
    // 横竖屏切换更新列表视图
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.view).with.inset(self.view.qh_statusBarHeight + self.view.qh_navigationBarHeight);
        make.left.and.right.and.bottom.mas_equalTo(self.view);
    }];
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

#pragma mark - UITableViewDataSource
/**
 列表视图的总组数
 
 @param tableView 列表视图
 @return 列表视图的总组数
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSLog(@"");
    
    return self.dataSourceUIArray.count;
}

/**
 列表视图的各组行数
 
 @param tableView 列表视图
 @param section 列表视图的某组索引值
 @return 列表视图的某组的行数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"");
    
    BOOL expand = [[self.dataSourceUIArray[section] objectForKey:@"expand"] boolValue];
    if (expand) {
        
        NSArray *array = [self.dataSourceUIArray[section] objectForKey:@"controllers"];
        return array.count;
    } else {
        
        return 0;
    }
}

/**
 列表视图的行视图
 
 @param tableView 列表视图
 @param indexPath 列表视图某行的索引值
 @return 列表视图某行视图
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"");
    
    // 视图数据
    NSArray *array = [self.dataSourceUIArray[indexPath.section] objectForKey:@"controllers"];
    NSDictionary *dict = array[indexPath.row];
    NSString *title = [NSString stringWithFormat:@"%@ - %@",@(indexPath.row), dict[@"title"]];
    NSString *subtitle = dict[@"description"];
    
    // 视图cell
    static NSString *identifier = @"GQHUITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = title;
    cell.textLabel.numberOfLines = 0;
    cell.detailTextLabel.text = subtitle;
    cell.detailTextLabel.numberOfLines = 0;
    
    return cell;
}

#pragma mark - UITableViewDelegate
/**
 选中列表视图的某行视图
 
 @param tableView 列表视图
 @param indexPath 选中列表视图的某行视图的索引值
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"");
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSArray *array = [self.dataSourceUIArray[indexPath.section] objectForKey:@"controllers"];
    NSDictionary *dict = array[indexPath.row];
    
    NSString *classString = [NSString stringWithFormat:@"GQH%@Controller",dict[@"title"]];
    GQHBaseViewController *controller = [[NSClassFromString(classString) alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

/**
 列表视图组头视图
 
 @param tableView 列表视图
 @param section 组索引
 @return 组头视图
 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc] init];
    headerView.frame = CGRectMake(0.0f, 0.0f, 0.0f, tableView.sectionHeaderHeight);
    headerView.backgroundColor = UIColor.clearColor;
    headerView.tag = section;
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickHeaderView:)];
    [headerView addGestureRecognizer:tapGestureRecognizer];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(15.0f, 10.0f, tableView.frame.size.width - 30.0f, tableView.sectionHeaderHeight - 10.0f);
    titleLabel.font = [UIFont systemFontOfSize:15.0f];
    titleLabel.textColor = UIColor.darkTextColor;
    titleLabel.backgroundColor = UIColor.clearColor;
    [headerView addSubview:titleLabel];
    
    NSString *title = [self.dataSourceUIArray[section] objectForKey:@"module"];
    NSInteger count = [[self.dataSourceUIArray[section] objectForKey:@"controllers"] count];
    titleLabel.text = [NSString stringWithFormat:@"%@(%@)",title,@(count)];
    
    return headerView;
}

#pragma mark - TargetMethod

/**
 点击列表头视图
 
 @param sender 点击手势
 */
- (IBAction)didClickHeaderView:(UITapGestureRecognizer *)sender {
    
    NSInteger index = sender.view.tag;
    BOOL expand = [[self.dataSourceUIArray[index] objectForKey:@"expand"] boolValue];
    NSMutableDictionary *module = self.dataSourceUIArray[index];
    [module setObject:@(!expand) forKey:@"expand"];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - PrivateMethod
/**
 打印类名
 */
- (void)printClassNames {
    
    __block NSString *nameUI = @"";
    
    [self.dataSourceUIArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSArray *controllers = [obj objectForKey:@"controllers"];
        [controllers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            nameUI = [nameUI stringByAppendingFormat:@"%@\n",[obj objectForKey:@"title"]];
        }];
    }];
    NSLog(@"\n%@",nameUI);
    
    
    __block NSString *nameModel = @"";
    
    [self.dataSourceModelArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        nameModel = [nameModel stringByAppendingFormat:@"%@\n",[obj objectForKey:@"title"]];
    }];
    NSLog(@"\n%@",nameModel);
}

/**
 列表总行数
 */
- (NSInteger)totalCount:(NSMutableArray *)dataSource {
    
    __block NSInteger totalCount = 0;
    
    [dataSource enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        totalCount += [[obj objectForKey:@"controllers"] count];
    }];
    
    return totalCount;
}

#pragma mark - Setter

#pragma mark - Getter
- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.sectionHeaderHeight = 40.0f;
        _tableView.sectionFooterHeight = CGFLOAT_MIN;
        
        _tableView.estimatedRowHeight = 50.0f;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        
        _tableView.separatorInset = UIEdgeInsetsMake(0.0f, 15.0f, 0.0f, 15.0f);
        
        if (@available(iOS 11.0, *)) {
            
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    
    return _tableView;
}

- (NSMutableArray *)dataSourceUIArray {
    
    if (!_dataSourceUIArray) {
        
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"data_dictionary_ui" ofType:@"plist"];
        _dataSourceUIArray = [NSMutableArray arrayWithContentsOfFile:filePath];
    }
    
    return _dataSourceUIArray;
}

- (NSMutableArray *)dataSourceModelArray {
    
    if (!_dataSourceModelArray) {
        
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"data_dictionary_model" ofType:@"plist"];
        _dataSourceModelArray = [NSMutableArray arrayWithContentsOfFile:filePath];
    }
    
    return _dataSourceModelArray;
}

@end
