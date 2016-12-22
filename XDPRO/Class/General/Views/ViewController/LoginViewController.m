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
@end
@implementation LoginViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self config];
    //绑定信号
    [self bindSignal];
}
-(void)config{
    self.loginBtn.layer.cornerRadius=10;
    self.loginBtn.layer.masksToBounds=YES;
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
