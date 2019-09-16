//
//  GQHWebController.m
//
//  Created by GuanQinghao on 2019-05-09.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#pragma mark Other
#import "GQHHeader.h"
#import <WebKit/WebKit.h>

#pragma mark Model

#pragma mark View

#pragma mark Controller
#import "GQHWebController.h"


#pragma mark -

@interface GQHWebController () <WKNavigationDelegate, WKUIDelegate>

/**
 自定义根视图
 */
@property (nonatomic, strong) WKWebView *webView;

/**
 进度条
 */
@property (nonatomic, strong) UIView *progressBar;

/**
 进度条显示层
 */
@property (nonatomic, strong) CALayer *progressLayer;

@end

/// 加载进度属性监听键值
static NSString * const kWebKeyPath = @"estimatedProgress";

@implementation GQHWebController

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
    
    // 网页视图
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.view).with.inset(self.view.qh_statusBarHeight + self.view.qh_navigationBarHeight);
        make.left.and.right.and.bottom.mas_equalTo(self.view);
    }];
    
    // 进度条
    [self.view addSubview:self.progressBar];
    [self.progressBar mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.view).with.inset(self.view.qh_statusBarHeight + self.view.qh_navigationBarHeight);
        make.left.and.right.mas_equalTo(self.view);
        make.height.mas_equalTo(2.0f);
    }];
}

/**
 3.视图即将显示
 
 @param animated 是否显示动画效果
 */
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"");
    
}

/**
 4.视图即将布局其子视图
 */
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    NSLog(@"");
    
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
    
    [self.webView removeObserver:self forKeyPath:kWebKeyPath];
}

#pragma mark - GQHWebViewDelegate

#pragma mark - TargetMethod

#pragma mark - PrivateMethod

/**
 监听加载进度

 @param keyPath 监听路径
 @param object 监听对象
 @param change 监听到的变化
 @param context 监听到的内容
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:kWebKeyPath]) {
        
        CGFloat progressValue = [change[NSKeyValueChangeNewKey] floatValue];
        
        self.progressLayer.opacity = 1.0f;
        self.progressLayer.frame = CGRectMake(0.0f, 0.0f, self.view.qh_width * progressValue, 2.0f);
        
        if (1.0f == progressValue) {
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                self.progressLayer.opacity = 0.0f;
            });
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                self.progressLayer.frame = CGRectMake(0.0f, 0.0f, 0.0f, 2.0f);
            });
        }
    } else {
        
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - Setter
- (void)setQh_contentString:(NSString *)qh_contentString {
    
    _qh_contentString = qh_contentString;
    
    if ([qh_contentString hasPrefix:@"http"]) {
        
        self.qh_URLString = qh_contentString;
    } else {
        
        self.qh_HTMLString = qh_contentString;
    }
}

- (void)setQh_URLString:(NSString *)qh_URLString {
    
    _qh_URLString = qh_URLString;
    
    if ([NSObject qh_isNotNullString:qh_URLString]) {
        
        NSURL *URL = [NSURL URLWithString:qh_URLString];
        NSURLRequest *request = [NSURLRequest requestWithURL:URL cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:0.0f];
        [self.webView loadRequest:request];
    }
}

- (void)setQh_HTMLString:(NSString *)qh_HTMLString {
    
    _qh_HTMLString = qh_HTMLString;
    
    if ([NSObject qh_isNotNullString:_qh_HTMLString]) {
        
        [self.webView loadHTMLString:qh_HTMLString baseURL:[NSURL URLWithString:GQHAPIServerBaseURL]];
    }
}

#pragma mark - Getter
- (WKWebView *)webView {
    
    if (!_webView) {
        
        // 图片宽度为屏宽
        NSString *JScriptString = @"var meta=document.createElement('meta');meta.setAttribute('name','viewport');meta.setAttribute('content','width=device-width');document.getElementsByTagName('head')[0].appendChild(meta);var imgs=document.getElementsByTagName('img');for(var i in imgs){imgs[i].style.maxWidth='100%';imgs[i].style.height='auto'}";
        
        WKUserScript *script = [[WKUserScript alloc] initWithSource:JScriptString injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        WKUserContentController *contentController = [[WKUserContentController alloc] init];
        [contentController addUserScript:script];
        
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        configuration.userContentController = contentController;
        
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
        _webView.navigationDelegate = self;
        _webView.UIDelegate = self;
        _webView.scrollView.showsHorizontalScrollIndicator = NO;
        _webView.scrollView.showsVerticalScrollIndicator = NO;
        
        [_webView addObserver:self forKeyPath:kWebKeyPath options:NSKeyValueObservingOptionNew context:nil];
    }
    
    return _webView;
}

- (UIView *)progressBar {
    
    if (!_progressBar) {
        
        _progressBar = [[UIView alloc] init];
        _progressBar.backgroundColor = UIColor.clearColor;
        [_progressBar.layer addSublayer:self.progressLayer];
    }
    
    return _progressBar;
}

- (CALayer *)progressLayer {
    
    if (!_progressLayer) {
        
        _progressLayer = [CALayer layer];
        _progressLayer.frame = CGRectMake(0.0f, 0.0f, 0.0f, 2.0f);
        _progressLayer.backgroundColor = UIColor.blueColor.CGColor;
    }
    
    return _progressLayer;
}

@end
