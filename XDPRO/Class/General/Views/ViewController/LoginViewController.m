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
@interface LoginViewController ()
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
    [self test];
}
-(void)config{
    self.loginBtn.layer.cornerRadius=10;
    self.loginBtn.layer.masksToBounds=YES;
}
-(void)test{
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
  // dispatch_queue_t queue1 = dispatch_queue_create("sdfsd", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_queue_t queue1 = dispatch_queue_create("sdfsd", NULL);
    //系统全局并行线程
    dispatch_queue_t queue1 =  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

        dispatch_async(queue1, ^{
          self.thread =[NSThread currentThread];
          [[NSThread currentThread] setName:@"sdfsdfs"];
           NSLog(@"%zd",[[NSThread currentThread] isFinished]);
          NSLog(@" 当前线程  %@",self.thread);
    });
//    RACSignal *ss=RACObserve(self.thread, isFinished);
//    [ss subscribeNext:^(id x) {
//        NSLog(@"%zd",[self.thread isFinished]);
//    }];
    dispatch_async(queue1, ^{
          NSLog(@" 当前线程  %@",[NSThread currentThread]);
        for(int i=0;i<100;i++ ){
        }
    });
    dispatch_async(queue1, ^{
          NSLog(@" 当前线程  %@",[NSThread currentThread]);
        for(int i=0;i<100;i++ ){
        }
    });
//    dispatch_queue_t queue5 = dispatch_queue_create("studyBlocks", NULL);
//    dispatch_async(queue5, ^{
//        for(int i=0;i<100;i++ ){
//            NSLog(@"hi电费%zd",i);
//        }
//    });
//    dispatch_queue_t queue6 = dispatch_queue_create("studyBlocks", NULL);
//    dispatch_async(queue6, ^{
//        for(int i=0;i<100;i++ ){
//            NSLog(@"是%zd",i);
//        }
//    });

//   dispatch_group_t  group = dispatch_group_create();
//    dispatch_queue_t  queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_group_async(group, queue, ^{
//        NSLog(@"1");
//    });
//    dispatch_group_async(group, queue, ^{
//        NSLog(@"2");
//    });
//    dispatch_group_async(group, queue, ^{
//        NSLog(@"3");
//    });
//    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
//        NSLog(@"4");
//    });
//  
//    
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
