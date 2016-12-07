//
//  ViewController.m
//  XDPRO
//
//  Created by XiaDian on 2016/11/28.
//  Copyright © 2016年 vdchina. All rights reserved.
//

#import "ViewController.h"
#import "VCViewModel.h"
#import "CocoaMVVMViewController.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property(nonatomic,strong)VCViewModel *viewModel;
@end
@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self bindModel];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)onlick:(id)sender {
    NSLog(@"sdfsd");
    //按钮点击事件
    [[self.loginButton rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         [_viewModel login];
     }];
}
//关联ViewModel
- (void)bindModel {
    _viewModel = [[VCViewModel alloc] init];
    RAC(self.viewModel, userName) = self.userNameTextField.rac_textSignal;
    RAC(self.viewModel, password) = self.passwordTextField.rac_textSignal;
    RAC(self.loginButton, enabled) = [_viewModel buttonIsValid];
    @weakify(self);
    //登录成功要处理的方法
    [self.viewModel.successObject subscribeNext:^(NSArray * x) {
        @strongify(self);
        CocoaMVVMViewController   *vc = [[CocoaMVVMViewController alloc]init];
        [self presentViewController:vc animated:YES completion:^{
            
        }];
    }];
    
    //fail
    [self.viewModel.failureObject subscribeNext:^(id x) {
        
    }];
    
    //error
    [self.viewModel.errorObject subscribeNext:^(id x) {
        
    }];
    
}
@end
