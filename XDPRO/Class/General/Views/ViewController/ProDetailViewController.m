//
//  ProDetailViewController.m
//  XDPRO
//
//  Created by XiaDian on 2016/12/27.
//  Copyright © 2016年 vdchina. All rights reserved.
//
#import "ProDetailViewController.h"
#import "WMDragView.h"
#import <WebKit/WebKit.h>
@interface ProDetailViewController ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>
@property(nonatomic,strong)WKWebView *webView;
@property (strong, nonatomic) UIProgressView *progressView;
@property (strong, nonatomic) MBProgressHUD *hud;
@property(nonatomic,assign)double *progress;
@property (strong, nonatomic) WMDragView *backView;
@end
@implementation ProDetailViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
    [self.view addSubview:self.progressView];
    [self getBackView];
    //进度条展示
    [self getProgress];
  }
-(void)getBackView{
    //给他个位置
    self.backView = [[WMDragView alloc] initWithFrame:CGRectMake(self.view.frame.size.width-50, self.view.frame.size.height-150, 50, 50)];
    //圆角
   self.backView.layer.cornerRadius = 25;
   self.backView.backgroundColor= [UIColor colorWithRed:(223.0)/255.0 green:(107.0)/255.0 blue:(93.0)/255.0 alpha:0.8f];
    //是不是保持在边界，默认为NO,没有黏贴边界效果
   self.backView.isKeepBounds = YES;
    //设置本地图片,可以设置网络图片
    self.backView.imageView.image=[UIImage imageNamed:@"back"];
    ///点击事件
    @weakify(self);
    self.backView.ClickDragViewBlock = ^(WMDragView *dragView){
        @strongify(self);
        [self.webView goBack];
    };
    //限定logoView的活动范围
    self.backView.freeRect = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64);
    [self.view addSubview:self.backView];
}
/**
 进度条展示
 */
-(void)getProgress{
    RACSignal *sign=RACObserve(self.webView, estimatedProgress);
    @weakify(self);
    [sign subscribeNext:^(id x) {
        @strongify(self);
        if ([x floatValue]==1) {
            self.progressView.hidden=YES;
        }
        self.progressView.progress=[x floatValue];
    }];
}
#pragma mark 网页视图代理
-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
      [self.hud hideAnimated:YES];
}
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
     self.progressView.hidden=NO;
    self.hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[_webView configuration].userContentController addScriptMessageHandler: self name:@"pop"];
}
-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    [self.hud hideAnimated:YES];
}
-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    [self.hud hideAnimated:YES];
}
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    self.navigationItem.title=self.webView.title;
    [self.hud hideAnimated:YES];
    [self.webView evaluateJavaScript:@"" completionHandler:^(id _Nullable response, NSError * _Nullable error) {
    }];
}
//OC在JS调用方法做的处理
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    if ([self respondsToSelector:NSSelectorFromString([NSString stringWithFormat:@"%@:", message.name])]) {
        [self performSelector: NSSelectorFromString([NSString stringWithFormat:@"%@:", message.name]) withObject:message.body afterDelay:0.0f];
    }
}
-(void)pop:(id) body{
    NSLog(@"%@",body);
    self.navigationController.navigationBar.barTintColor=XDRandomColor;
   // [self.webView goBack];
}
//是否加载本页面
-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    if (navigationAction.targetFrame==nil) {
        [self.webView loadRequest:navigationAction.request];
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}
#pragma mark 懒加载
-(UIProgressView *)progressView{
    if (_progressView==nil) {
        _progressView= [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressView.frame=CGRectMake(0, 20, self.view.bounds.size.width, 2);
    }
    return _progressView;
}
-(WKWebView *)webView{
    if (_webView==nil) {
        self.view.backgroundColor=[UIColor whiteColor];
        WKWebViewConfiguration *config=[[WKWebViewConfiguration alloc]init];
        self.webView=[[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) configuration:config];
        self.webView.navigationDelegate=self;
        self.webView.UIDelegate=self;
        self.webView.allowsLinkPreview=YES;
        //本地\h5
        NSString *path = [[NSBundle mainBundle] pathForResource:@"shop" ofType:@"html"];
        NSString *htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        NSString *basePath = [[NSBundle mainBundle] bundlePath];
        NSURL *baseURL = [NSURL fileURLWithPath:basePath];
        [self.webView loadHTMLString:htmlString baseURL:baseURL];
        [self.webView sizeToFit];
        //远程h5
//    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.jianshu.com"]]];
    }
    return _webView;
}
-(void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    NSLog(@"%s%@",__func__ ,message);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"alert"message:@"JS调用alert"preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"quding" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    [self presentViewController:alert animated:YES completion:NULL];
    NSLog(@"%@", message);
}
-(void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    NSLog(@"%s%@",__func__ ,prompt);
}
-(void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    NSLog(@"%s%@",__func__ ,message);
}
@end
