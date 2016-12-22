//
//  ViewController.m
//  bb
//
//  Created by XiaDian on 16/5/20.
//  Copyright © 2016年 vdchina. All rights reserved.
//

#import "ViewController.h"
#import "AnimationShow.h"
@interface ViewController ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView *webView;
@end
@implementation ViewController
-(BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"进行请求");
    NSString
    *urlstr = request.URL.absoluteString;
    NSRange
    range = [urlstr
             rangeOfString:@"ios://"];
    if
        (range.length!=0)
    {
        NSString
        *method = [urlstr
                   substringFromIndex:(range.location+range.length)];
        SEL
        selctor = NSSelectorFromString(method);
        if (selctor!=nil) {
            [self  performSelector:selctor  withObject:nil];

        }
        
           }
    return
    
    YES;
    
}
-(void)openMyAlbum
{
    UIImagePickerController
    
    *vc = [[UIImagePickerController
            
            alloc]init];
    vc.sourceType
    
    = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self
     presentViewController:vc
     animated:YES
     completion:nil];
}
-(void)xiazai{

    [_webView stringByEvaluatingJavaScriptFromString:@"test();"];

    NSLog(@"dddddddddd");


}
-(void)openMyCamera
{
    [_webView stringByEvaluatingJavaScriptFromString:@"test();"];
    return;
    UIImagePickerController *vc = [[UIImagePickerController alloc]init];
    vc.sourceType= UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:vc
     animated:YES
     completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_webView];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"license.html" ofType:nil];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:url];
    _webView.delegate= self;
    _webView.dataDetectorTypes  = UIDataDetectorTypeAll;
    [_webView loadRequest:req];
}
- (void)showWindow{
    
    NSLog(@"heheda");
    [[AnimationShow shareInstance]showWithMessage:@"薛志朋" image:nil windowColor:[UIColor yellowColor]];

    UIView *view=[[UIView alloc]initWithFrame: CGRectMake(200,100, 100, 100)];
    view.backgroundColor=[UIColor redColor];
    [self.view addSubview:view];
//    [[AnimationShow shareInstance]showWithMessage:@"heheh" image:nil windowColor:[UIColor yellowColor]];
    
}
@end
