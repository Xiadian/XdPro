//
//  LoginViewController.m
//  XDPRO
//
//  Created by XiaDian on 2016/12/13.
//  Copyright © 2016年 vdchina. All rights reserved.
//
#import "LoginViewController.h"
#import "LoginVIewModel.h"
#import "MainTabViewController.h"
#import "ProductViewController.h"
#import "XDNVC.h"
#import "ZCAnimatedLabel.h"
@interface LoginViewController ()<CAAnimationDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UITextField *userTfd;
@property (weak, nonatomic) IBOutlet UITextField *pswTfd;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property(nonatomic,strong)LoginVIewModel *viewModel;
@property (nonatomic, strong) ZCAnimatedLabel *label;
@property(nonatomic,strong)NSThread *thread;
@end
@implementation LoginViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self config];
    //绑定信号
    [self bindSignal];
     // interval
    RACScheduler *dd=[RACScheduler mainThreadScheduler];
    RACSignal *ddd=[RACSignal interval:4 onScheduler:dd];
    [ddd subscribeNext:^(id x) {
    //
    }];
    [self test];
}
-(void)config{
    self.loginBtn.layer.cornerRadius=10;
    self.loginBtn.layer.masksToBounds=YES;
}
-(void)test{
   //需要用到第三方库SDWebImage
//    UIImageView *v1 = [[UIImageView alloc]init];
//    [self.view addSubview:v1];
//    [v1 sd_setImageWithURL: [NSURL URLWithString:@"http://img4q.duitang.com/uploads/item/201505/30/20150530111045_EaiKJ.jpeg"] placeholderImage: [UIImage imageNamed:@"back"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        v1.frame=CGRectMake(20, 90,image.size.width, image.size.height);
//    }];
//    NSMutableArray *pathArr=[NSMutableArray new];
//    for (int i=0; i<10; i++) {
//        CGPoint pastLocation =CGPointMake(arc4random()%(NSInteger)([UIScreen mainScreen].bounds.size.width), arc4random()%(NSInteger)([UIScreen mainScreen].bounds.size.height*3/4));
//        NSValue *pastpoint=[NSValue valueWithCGPoint:pastLocation];
//        [pathArr addObject:pastpoint];
//    }
//    UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
//    btn.backgroundColor=[UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
//    btn.frame=CGRectMake(arc4random()%(NSInteger)([UIScreen mainScreen].bounds.size.width), arc4random()%(NSInteger)([UIScreen mainScreen].bounds.size.height), 30, 30);
//    btn.layer.cornerRadius=15;
//    btn.clipsToBounds=YES;
//    [self.view addSubview:btn];
//    
//    CAKeyframeAnimation *an=[CAKeyframeAnimation animation];
//    an.keyPath=@"position";
//    CGMutablePathRef
//    path = CGPathCreateMutable();
//    //将路径的起点定位到
//    //（50  120）
//    CGPathMoveToPoint(path,NULL,0.0,0.0);
//    //下面5行添加5条直线的路径到path中
//    CGPathAddLineToPoint(path,
//                         NULL, 60, 130);
//   CGPathAddLineToPoint(path,
//                        NULL, XDSW/2.0 ,XDSH/2.0 );
//    CGPathAddLineToPoint(path,
//                         NULL, 80, 150);
//    CGPathAddLineToPoint(path,
//                         NULL, 90, 160);
//    CGPathAddLineToPoint(path,
//                         NULL, 100, 170);
    //下面四行添加四条曲线路径到path
//    CGPathAddCurveToPoint(path,NULL,50.0,275.0,150.0,275.0,70.0,120.0);
//    CGPathAddCurveToPoint(path,NULL,150.0,275.0,250.0,275.0,90.0,120.0);
//    CGPathAddCurveToPoint(path,NULL,250.0,275.0,350.0,275.0,110.0,120.0);
//    CGPathAddCurveToPoint(path,NULL,350.0,275.0,450.0,275.0,130.0,120.0);
//    an.path=path;
//    an.values=pathArr;
//    an.duration=10;
//    an.delegate=self;
//    an.removedOnCompletion=NO;
//    an.fillMode=kCAFillModeForwards;
//    [btn.layer addAnimation:an forKey:nil];
//    CFRelease(path);
//    CABasicAnimation *dd=[[CABasicAnimation alloc]init];
//    dd.keyPath=@"backgroundColor";
//    dd.fromValue=XDRandomColor;
//    dd.toValue=XDRandomColor;
//    dd.duration=1;
//    CAAnimationGroup *gp=[[CAAnimationGroup alloc]init];
//    [gp setAnimations:@[an,dd]];
//    [btn.layer addAnimation:gp forKey:@"fs"];
    
//    CAKeyframeAnimation *an=[CAKeyframeAnimation animation];
//    an.keyPath=@"backgroundColor";
//    an.values=@[XDRandomColor,XDRandomColor,XDRandomColor,XDRandomColor,XDRandomColor,XDRandomColor,XDRandomColor];
//    an.duration=10;
//    an.delegate=self;
//    an.removedOnCompletion=NO;
//    an.fillMode=kCAFillModeForwards;
//    [btn.layer addAnimation:an forKey:nil];

//    transform.scale = 比例转换
//    
//    transform.rotation = 旋转
//    
//    opacity = 透明度
//    
//    margin = 边距
//    
//    zPosition
//    
//    backgroundColor =   背景颜色
//    
//    cornerRadius   = 圆角
//    
//    borderWidth
//    
//    bounds
//    
//    contents
//    
//    contentsRect
//    
//    frame
//    
//    hidden
//    
//    mask
//    
//    masksToBounds
//    
//    position = 位置
//    
//    shadowColor
//    
//    shadowOffset
//    
//    shadowOpacity
//1.创建NSBlockOperation对象
//    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
//        for(int i=0;i<100;i++ ){
//            NSLog(@"1");
//        }
//    }];
//    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
//        for(int i=0;i<100;i++ ){
//            NSLog(@"2");
//        }
//    }];
//    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
//        for(int i=0;i<100;i++ ){
//            NSLog(@"3");
//        }
//    }];
//    NSOperationQueue *queaa=[[NSOperationQueue alloc]init];
//    queaa.maxConcurrentOperationCount=2;
//    [queaa addOperations:@[operation,operation1,operation2] waitUntilFinished:NO];
  
//   NSLog(@" 主线程  %@",[NSThread mainThread]);

}
/**
 绑定信号的方法
 */
-(void)bindSignal{
    self.viewModel=[[LoginVIewModel alloc]init];
    RAC(self.viewModel,userTxt)=self.userTfd.rac_textSignal;
    RAC(self.viewModel,pswTxt)=self.pswTfd.rac_textSignal;
    RAC(self.loginBtn,enabled)=[self.viewModel btnEnble];
    RAC(self.img,hidden)=[RACObserve(self.loginBtn, enabled) map:^id(id value) {
        NSInteger num=[value integerValue];
        return @(!num);
    } ];
    //改变图片
    [self changeImg];
    //登陆事件绑定
    [self loginEvent];
}
/**
 改变图片的
 */
-(void)changeImg{
    [self.viewModel.imgChangeSignal subscribeNext:^(NSString * x) {
        [[XDCATransition getManager]XDCATransitionAddTo:self.img Type:Cube Subtype:FromTop duration:1 andKey:nil];
          [self.img layoutIfNeeded];
        [self.img sd_setImageWithURL:[NSURL URLWithString:x] placeholderImage:nil];
    }];
}
#pragma mark 登陆部分
/**
 登录点击按钮
 @param sender 按钮
 */
- (IBAction)loginClick:(UIButton *)sender {
     [self.viewModel  Login];
}
/**
 登陆时间处理 包括登陆成功 登陆失败
 */
-(void)loginEvent{
    //登陆成功事件
    @weakify(self);
    [self.viewModel.successLoginSignal subscribeNext:^(id x) {
        @strongify(self);
        MainTabViewController *vc=[[MainTabViewController alloc]init];
        vc.view.backgroundColor=[UIColor redColor];
        [self presentViewController:vc animated:YES
                    completion:nil];
    }];
    //登陆失败事件
    [self.viewModel.failureLoginSignal subscribeNext:^(id x) {
        
    }];
}
@end
