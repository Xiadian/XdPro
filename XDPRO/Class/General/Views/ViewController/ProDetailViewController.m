//
//  ProDetailViewController.m
//  XDPRO
//
//  Created by XiaDian on 2016/12/27.
//  Copyright © 2016年 vdchina. All rights reserved.
//

#import "ProDetailViewController.h"
#import <WebKit/WebKit.h>
@interface ProDetailViewController ()<WKUIDelegate>
@property(nonatomic,strong)WKWebView *webView;
@end
@implementation ProDetailViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    WKWebViewConfiguration *dd=[[WKWebViewConfiguration alloc]init];
    dd.suppressesIncrementalRendering=YES;
    self.webView=[[WKWebView alloc] initWithFrame:CGRectMake(0, 0, XDSW, XDSH) configuration:dd];
    self.webView.UIDelegate=self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://chuandazhi.liwushuo.com/posts/4037/content"]]];
    [self.view addSubview:self.webView];
     _webView.allowsBackForwardNavigationGestures = YES;
     [_webView sizeToFit];
}
@end
