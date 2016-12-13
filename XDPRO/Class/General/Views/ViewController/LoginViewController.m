//
//  LoginViewController.m
//  XDPRO
//
//  Created by XiaDian on 2016/12/13.
//  Copyright © 2016年 vdchina. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginVIewModel.h"
@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UITextField *userTfd;
@property (weak, nonatomic) IBOutlet UITextField *pswTfd;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property(nonatomic,strong)LoginVIewModel *viewModel;
@property(nonatomic,strong)NSString *ss;

@end
@implementation LoginViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self bindSignal];
    
}
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
    //登陆事件
    [self loginEvent];
}
-(void)changeImg{
    [self.viewModel.imgChangeSignal subscribeNext:^(NSString * x) {
        [self.img sd_setImageWithURL:[NSURL URLWithString:x] placeholderImage:nil];
    }];
}
//登陆按钮
- (IBAction)loginClick:(UIButton *)sender {
    [self.viewModel  Login];
}
-(void)loginEvent{
    //登陆成功事件
    @weakify(self);
    [self.viewModel.successLoginSignal subscribeNext:^(id x) {
        @strongify(self);
        UIViewController *dd=[[UIViewController alloc]init];
        dd.view.backgroundColor=[UIColor redColor];
        [self.navigationController pushViewController:dd animated:YES];
    }];
    //登陆失败事件
    [self.viewModel.failureLoginSignal subscribeNext:^(id x) {
        
    }];
}
@end
