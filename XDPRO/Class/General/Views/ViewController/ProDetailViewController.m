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
@interface ProDetailViewController ()<WKNavigationDelegate>
@property(nonatomic,strong)WKWebView *webView;
@property (strong, nonatomic) UIProgressView *progressView;
@property (strong, nonatomic) MBProgressHUD *hud;
@property(nonatomic,assign)double *progress;
@property (strong, nonatomic) WMDragView *backView;
@end
@implementation ProDetailViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    WKWebViewConfiguration *config=[[WKWebViewConfiguration alloc]init];
    self.webView=[[WKWebView alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, self.view.bounds.size.height) configuration:config];
    self.webView.navigationDelegate=self;
    self.webView.allowsLinkPreview=YES;
     [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.jianshu.com"]]];
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
}
-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    [self.hud hideAnimated:YES];
}
-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    [self.hud hideAnimated:YES];
}
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [self.hud hideAnimated:YES];
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
@end
