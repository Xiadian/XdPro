//
//  LoginVIewModel.h
//  XDPRO
//
//  Created by XiaDian on 2016/12/13.
//  Copyright © 2016年 vdchina. All rights reserved.
//

#import "BaseViewModel.h"

@interface LoginVIewModel : BaseViewModel
//用户名属性
@property(nonatomic,strong)NSString *userTxt;
//密码属性
@property(nonatomic,strong)NSString *pswTxt;
//图片变化信号
@property(nonatomic,strong)RACSubject *imgChangeSignal;
//登陆成功信号
@property(nonatomic,strong)RACSubject *successLoginSignal;
//登陆失败信号
@property(nonatomic,strong)RACSubject *failureLoginSignal;
//
@property(nonatomic,strong)RACCommand  *ddd;

//登陆事件
-(void)Login;
//按钮点击
-(RACSignal *)btnEnble;

@end
