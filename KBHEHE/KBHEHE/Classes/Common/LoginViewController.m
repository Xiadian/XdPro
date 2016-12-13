//
//  LoginViewController.m
//  KBHEHE
//
//  Created by XiaDian on 2016/12/6.
//  Copyright © 2016年 KeBun. All rights reserved.
//
#import "LoginViewController.h"
#import "MineViewController.h"
#import "LocalView.h"
#import "LoginViewModel.h"
@interface LoginViewController ()
//上部View
@property(nonatomic,strong)UIView *topView;
//上部View图片
@property(nonatomic,strong)UIImageView *topViewImg;
//底部View
@property(nonatomic,strong)UIView *bottomView;
//电话textfield
@property(nonatomic,strong)UITextField *teleTfd;
//密码textfield
@property(nonatomic,strong)UITextField *pswTfd;
//电话label
@property(nonatomic,strong)UILabel *teleLab;
//密码label
@property(nonatomic,strong)UILabel *pswLab;
//登陆按钮
@property(nonatomic,strong)UIButton *loginBtn;
//忘记密码按钮
@property(nonatomic,strong)UIButton *forgetPswBtn;
//注册按钮
@property(nonatomic,strong)UIButton *registBtn;
//viewModel
@property(nonatomic,strong)LoginViewModel *viewModel;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
      //配置
    [self Config];
    //UI
    [self CreatUI];
    [self bindViewModel];
    //适配
    [self LayOutUI];

}
-(void)bindViewModel{
    self.viewModel=[[LoginViewModel alloc]init];
    RAC(self.viewModel,tele)=self.teleTfd.rac_textSignal;
    RAC(self.viewModel,psw)=self.pswTfd.rac_textSignal;
    RAC(self.loginBtn,enabled)=[self.viewModel pswSix];
    [self loginEvents];
}
-(void)Config{
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage imageNamed:@"nagvation_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(25, 100, 10, 0) resizingMode:UIImageResizingModeStretch] forBarMetrics:UIBarMetricsDefault];
     [SZRFunction SZRSetLayerImage:self.view imageStr:@"dl-bj"];
    self.navigationItem.title=@"合合健康管理";
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
}
#pragma mark创建UI
-(void)CreatUI{
#pragma mark 顶部UI

    //顶部view
    self.topView=[[UIView alloc]init];
    self.topView.backgroundColor=[UIColor lightGrayColor];
    [self.view addSubview:self.topView];

    self.topViewImg=[[UIImageView alloc]init];
    self.topViewImg.image=[UIImage imageNamed:@"topViewImg"];
    [self.topView addSubview:self.topViewImg];
    //电话label
    self.teleLab=[[UILabel alloc]init];
    self.teleLab.text=@"手机号";
    self.teleLab.backgroundColor=[UIColor whiteColor];
    self.teleLab.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:self.teleLab];
    //密码label
    self.pswLab=[[UILabel alloc]init];
    self.pswLab.text=@"密    码";
    self.pswLab.backgroundColor=[UIColor whiteColor];
    self.pswLab.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:self.pswLab];
    self.teleTfd=[[UITextField alloc]init];
    //电话textfield
    self.teleTfd.placeholder=@"请输入手机号";
    self.teleTfd.backgroundColor=[UIColor whiteColor];
    [self.topView addSubview:self.teleTfd];
    //密码textfield
    self.pswTfd=[[UITextField alloc]init];
    self.pswTfd.placeholder=@"请输入密码";
    self.pswTfd.backgroundColor=[UIColor whiteColor];
    [self.topView addSubview:self.pswTfd];
#pragma mark 底部UI
    self.bottomView=[[UIView alloc]init];
    self.bottomView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:self.bottomView];
    //登陆按钮
    self.loginBtn=[UIButton new];
    [self.loginBtn setTitle:@"登 录" forState:UIControlStateNormal];
    self.loginBtn.backgroundColor=RGBCOLOR(26,200,154);
    self.loginBtn.layer.cornerRadius=10;
    self.loginBtn.clipsToBounds=YES;
    [self.loginBtn addTarget:self action:@selector(loginClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.loginBtn setTitleColor:RGBCOLOR(26,200,154) forState:UIControlStateDisabled];
    [self.bottomView addSubview:self.loginBtn];
    //注册按钮
    self.registBtn=[UIButton new];
    [self.registBtn setTitle:@"注册成为健康管理医师" forState:UIControlStateNormal];
    self.registBtn.titleLabel.adjustsFontSizeToFitWidth=YES;
    [self.bottomView addSubview:self.registBtn];
    [self.registBtn addTarget:self action:@selector(registClick:) forControlEvents:UIControlEventTouchUpInside];
    //忘记密码按钮
    self.forgetPswBtn=[UIButton new];
    self.forgetPswBtn.titleLabel.textAlignment=NSTextAlignmentRight;
    self.forgetPswBtn.titleLabel.adjustsFontSizeToFitWidth=YES;
    [self.forgetPswBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [self.bottomView addSubview:self.forgetPswBtn];
}
#pragma mark 适配UI
-(void)LayOutUI{
     //顶部视图
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@(330));
    }];
     //顶部图片
    [self.topViewImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_top);
        make.left.equalTo(self.topView.mas_left);
        make.right.equalTo(self.topView.mas_right);
        make.height.equalTo(@(200));
    }];
     //电话lab
    [self.teleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topViewImg.mas_bottom).offset(2);
        make.left.equalTo(self.topView.mas_left);
        make.width.equalTo(@(100));
        make.height.equalTo(@(63));
    }];
     //密码lab
    [self.pswLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.teleLab.mas_bottom).offset(2);
        make.left.equalTo(self.topView.mas_left);
        make.width.equalTo(@(100));
        make.height.equalTo(@(63));
    }];
     //电话文本框
    [self.teleTfd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topViewImg.mas_bottom).offset(2);
        make.left.equalTo(self.teleLab.mas_right);
        make.width.equalTo(@(SZRScreenWidth-100));
        make.height.equalTo(@(63));
    }];
     //密码文本框
    [self.pswTfd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.teleTfd.mas_bottom).offset(2);
        make.left.equalTo(self.pswLab.mas_right);
        make.width.equalTo(@(SZRScreenWidth-100));
        make.height.equalTo(@(63));
    }];
     //底部视图
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@(SZRScreenHeight-330-64));
    }];
     //登陆按钮
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomView.mas_top).offset(60);
        make.left.equalTo(self.bottomView.mas_left).offset(20);
        make.right.equalTo(self.bottomView.mas_right).offset(-20);
        make.height.equalTo(@(50));
    }];
    //注册按钮
    [self.registBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bottomView.mas_bottom).offset(-20);
        make.left.equalTo(self.bottomView.mas_left).offset(100);
        make.right.equalTo(self.bottomView.mas_right).offset(-100);
        make.height.equalTo(@(30));
    }];
    //忘记密码按钮
    [self.forgetPswBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomView.mas_top).offset(8);
        make.width.equalTo(@(80));
        make.right.equalTo(self.bottomView.mas_right).offset(-5);
        make.height.equalTo(@(30));
    }];
}
#pragma mark 登陆按钮点击事件
//登陆按钮点击事件
-(void)loginClick:(id)sender{
    [self.viewModel login];
}
-(void)loginEvents{
    //登陆成功情况
    @weakify(self);
    [self.viewModel.successSignal subscribeNext:^(id x) {
        @strongify(self);
        RACTupleUnpack(NSString *str,NSNumber *num) = x;
        NSLog(@"%@",num);
        if ([str isEqualToString:@"登陆成功"]) {
            MineViewController *mVC=[[MineViewController alloc]init];
            [self.navigationController pushViewController:mVC animated:YES];
        }
    }];
    //登陆失败情况
    [self.viewModel.failSignal subscribeNext:^(id x) {
        
    }];
}
//注册点击事件
-(void)registClick:(id)sender{
    NSArray *arr=[[NSBundle mainBundle]loadNibNamed:@"LocalView" owner:self options:nil];
    LocalView *lv=arr[0];
    lv.frame=CGRectMake((SZRScreenWidth-300)/2.0, SZRScreenHeight/3.0-100, 300, 220);
    [self.view addSubview:lv];
}
@end
