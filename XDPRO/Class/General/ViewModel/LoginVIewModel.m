
//
//  LoginVIewModel.m
//  XDPRO
//
//  Created by XiaDian on 2016/12/13.
//  Copyright © 2016年 vdchina. All rights reserved.
//

#import "LoginVIewModel.h"
@interface LoginVIewModel()
//用户信号
@property(nonatomic,strong)RACSignal *userTxtSignal;
//密码信号
@property(nonatomic,strong)RACSignal *pswTxtSignal;

@end
@implementation LoginVIewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        //绑定信号
        [self bindSignal];
    }
    return self;
}
-(void)bindSignal{
    self.userTxtSignal=RACObserve(self,userTxt);
    self.pswTxtSignal=RACObserve(self,pswTxt);
    self.imgChangeSignal=[[RACSubject alloc]init];
    self.successLoginSignal=[[RACSubject alloc]init];
    self.failureLoginSignal=[[RACSubject alloc]init];
}
-(RACSignal *)btnEnble{
RACSignal *rac=[RACSignal combineLatest:@[_userTxtSignal,_pswTxtSignal] reduce:^id(NSString * x,NSString* y){
    if ([x hasPrefix:@"xue"]&&y.length>2) {
        [_imgChangeSignal sendNext:@"http://img4q.duitang.com/uploads/item/201505/30/20150530111045_EaiKJ.jpeg"];
    }
    return @([x hasPrefix:@"xue"]&&y.length>2);
}];
    return rac;
}
-(void)Login{
    [XDNetRequest XDHUDRequsetType:GET withRequestUrl:@"http://api.chuandazhiapp.com/v1/banners" withPragram:@{@"channel":@"iOS"} withSuccessBlock:^(id response) {
        RACTuple *tuple = RACTuplePack(@"登陆成功",response);
        [self.successLoginSignal sendNext:tuple];
    } failure:^(NSError *error) {
          [self.failureLoginSignal sendNext:@"fail"];
    } withHUDTitle:@"正在登陆"];
}
@end
