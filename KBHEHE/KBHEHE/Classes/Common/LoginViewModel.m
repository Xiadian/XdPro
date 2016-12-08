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
    self.failSignal=[[RACSubject alloc]init];
    self.successSignal=[[RACSubject alloc]init];
    self.pswSignal=RACObserve(self, psw);
    self.teleSignal=RACObserve(self, tele);

}
-(void)login{
        [XDNetRequest XDRequsetType:GET withRequestUrl:@"http://api.chuandazhiapp.com/v1/banners" withPragram:@{@"channel":@"iOS"} withSuccessBlock:^(id response) {
           RACTuple *tuple = RACTuplePack(@"登陆成功",response);
           [self.successSignal sendNext:tuple];
       } failure:^(NSError *error) {
           NSLog(@"%@",error);
       }];
}
-(id)pswSix{
    RACSignal *signal=[RACSignal combineLatest:@[self.pswSignal,self.teleSignal] reduce:^id(NSString *psw,NSString *tele){
        NSLog(@"dfsdf");
        return  @(psw.length>3&&tele.length>3);
    }];
    
//RACSignal *signal=[self.pswSignal concat:self.teleSignal];
    return  self.pswSignal;
}
@end
