```objc
// 首次启动应用
if (![[NSUserDefaults standardUserDefaults] boolForKey:@"firstBoot"]) {
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstBoot"];
    <#code#>
} else {
    <#code#>
}
```

```objc
// 创建文件及文件夹
NSFileManager *fileManager = [NSFileManager defaultManager];
NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/events.plist"];
NSString *imagesPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/images"];
if (![fileManager fileExistsAtPath:filePath]) {
    [fileManager createFileAtPath:filePath contents:nil attributes:nil];
    [fileManager createDirectoryAtPath:imagesPath withIntermediateDirectories:YES attributes:nil error:nil];
} else {
    <#code#>
}
```

```objc
// 禁止手机睡眠
[UIApplication sharedApplication].idleTimerDisabled = YES;
```

```objc
// 角度转弧度
#define DEGREE_TO_RADIAN(degree)  ((M_PI * degree) / 180) 
```

```objc
// 状态栏网络加载指示器
[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
```

```objc
// 代码创建应用程序主屏 3D Touch 快捷选项 -- Home Screen Quick Actions
- (void)creatAppShortcutItems {
    // 创建系统风格的icon
    UIApplicationShortcutIcon *systemAddIcon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeAdd];
    // 创建应用程序主屏3D Touch快捷选项
    UIApplicationShortcutItem *addShortcut = [[UIApplicationShortcutItem alloc]initWithType:@"identifier.add" localizedTitle:@"Add" localizedSubtitle:@"" icon:systemAddIcon userInfo:nil];
    
    // 创建系统风格的icon
    UIApplicationShortcutIcon *composeIcon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeCompose];
    // 创建应用程序主屏3D Touch快捷选项
    UIApplicationShortcutItem *composeShortcut = [[UIApplicationShortcutItem alloc]initWithType:@"identifier.compose" localizedTitle:@"Compose" localizedSubtitle:@"" icon:composeIcon userInfo:nil];
    
    // 创建系统风格的icon
    UIApplicationShortcutIcon *systemSearchIcon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeSearch];
    // 创建应用程序主屏3D Touch快捷选项
    UIApplicationShortcutItem *searchShortcut = [[UIApplicationShortcutItem alloc]initWithType:@"identifier.search" localizedTitle:@"Search" localizedSubtitle:@"" icon:systemSearchIcon userInfo:nil];
    
    // 创建自定义风格的icon 图片大小35×35
    UIApplicationShortcutIcon *customPraiseIcon = [UIApplicationShortcutIcon iconWithTemplateImageName:@"icon.png"];
    // 创建应用程序主屏3D Touch快捷选项
    UIApplicationShortcutItem *praiseShortcut = [[UIApplicationShortcutItem alloc]initWithType:@"identifier.praise" localizedTitle:@"Praise" localizedSubtitle:@"" icon:customPraiseIcon userInfo:nil];
    
    // 添加到快捷选项数组  启用3D Touch功能后应用上架自动添加一个分享快捷选项
    [UIApplication sharedApplication].shortcutItems = @[addShortcut,composeShortcut,searchShortcut,praiseShortcut];
}
```

```objc
// 快速添加视图背景图
self.layer.contents = (id)[UIImage imageNamed:@"Login.jpg"].CGImage;
```

```objc
// 导航添加搜索框
CGRect searchBarFrame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
UISearchBar * searchBar = [[UISearchBar alloc]initWithFrame:searchBarFrame];
searchBar.delegate = self;
searchBar.tintColor = [UIColor redColor];
searchBar.placeholder = @"点击搜索...";

UIBarButtonItem *searchBarItem = [[UIBarButtonItem alloc]initWithCustomView:searchBar];
//    self.tabBarController.navigationItem.rightBarButtonItem = searchBarItem;// 带导航和tabBar
self.navigationController.navigationItem.rightBarButtonItem = searchBarItem;// 带导航不带tabBar
```

```objc
// 用字典设置tabBarItem的字体颜色
NSDictionary * dict = @{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:kRedColor};

// 设置正常状态的字体及颜色
[self.tabBarItem setTitleTextAttributes:dict forState:UIControlStateNormal];
```

```objc
// 隐藏返回按钮上的文字
[[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
```

```objc
// 获取主窗口(推荐)
UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window]
// 获取主窗口，需要在 [ self.window makeKeyAndVisible ] 后
UIWindow *mainWindow = [[UIApplication sharedApplication] keyWindow]

```

```objc
// UITableViewCell 分割线长度
[tableView setSeparatorInset:UIEdgeInsetsMake(0, 12, 0, 12)]; 

// UITableViewCell 选择样式
[tableViewCell setSelectionStyle:UITableViewCellSelectionStyleNone];

// UITableViewCell 右边箭头样式
[tableViewCell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];

```

```objc
// 全局统一收起键盘
[[[UIApplication sharedApplication] keyWindow] endEditing:YES];

```
