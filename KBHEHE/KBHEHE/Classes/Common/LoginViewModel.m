//
//  LoginViewModel.m
//  KBHEHE
//
//  Created by XiaDian on 2016/12/7.
//  Copyright © 2016年 KeBun. All rights reserved.
//

#import "LoginViewModel.h"
#import <ReactiveCocoa/RACReturnSignal.h>
@interface LoginViewModel ()
@property(nonatomic,strong)RACSignal *teleSignal;
@property(nonatomic,strong)RACSignal *pswSignal;


@end
@implementation LoginViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initBind];
    }
    return self;
}
-(void)initBind{
    self.successSignal=[[RACSubject alloc]init];
    self.pswSignal=RACObserve(self, psw);
    self.teleSignal=RACObserve(self, tele);
//  RACSignal *ff=[self.successSignal flattenMap:^RACStream *(id value) {
//        value = [NSString stringWithFormat:@"xmg%@",value];
//        // 返回值:信号,把处理完的值包装成信号返回出去
//      return  [RACReturnSignal return:value];
////        return [RACStream return:value];
//    }];   
}
-(void)login{
    [self.successSignal sendNext:@"登陆成功"];
}
-(id)pswSix{
    RACSignal *signal=[RACSignal combineLatest:@[self.pswSignal,self.teleSignal] reduce:^id(NSString *psw,NSString *tele){
        return  @(psw.length>3&&tele.length>3);
    }];
    return  signal;
}
@end
