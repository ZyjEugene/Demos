//
//  JS_OCViewController.m
//  UIAutoLayout
//
//  Created by tongqu on 2017/7/19.
//  Copyright © 2017年 Eugene Space. All rights reserved.
//
#define kWidth                      [UIScreen mainScreen].bounds.size.width
#define kHeight                     [UIScreen mainScreen].bounds.size.height
#import "JS_OCViewController.h"
#import <WebKit/WebKit.h>

@interface JS_OCViewController ()<WKNavigationDelegate>
/** 展示活动网页内容 */
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic)JSContext *jsContext;

@end

@implementation JS_OCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    


    
    [self.view addSubview:self.webView];
    
    //加载本地html文件
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"JS_OC" ofType:@"html"];
    NSString *htmlCont = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    [self.webView loadHTMLString:htmlCont baseURL:baseURL];
    
    UIButton *button = [[UIButton alloc] init];
    button.frame = CGRectMake(20, 70, 60, 60);
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(showAlert) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
     // Do any additional setup after loading the view.
}

- (void)showAlert {
    //要将script的alert()方法转化为string类型
    NSString *alertJs=@"alert('Hello Word')";
    [_jsContext evaluateScript:alertJs];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    //设置JS
    NSString *inputValueJS = @"document.getElementsByName('input')[0].attributes['value'].value";
    //执行JS
    [webView evaluateJavaScript:inputValueJS completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        NSLog(@"value: %@ error: %@", response, error);
    }];
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSURL *URL = navigationAction.request.URL;
    NSString *scheme = [URL scheme];
    decisionHandler(WKNavigationActionPolicyAllow);
}

#pragma mark - getter
/** webview getter */
- (WKWebView *)webView {
    
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 64, kWidth, kHeight)];
        _webView.scrollView.backgroundColor = [UIColor whiteColor];
        _webView.navigationDelegate = self;
    }
    return _webView;
}
@end
