//
//  MIneViewModel.m
//  KBHEHE
//
//  Created by XiaDian on 2016/12/8.
//  Copyright © 2016年 KeBun. All rights reserved.
//

#import "MIneViewModel.h"
@implementation MIneViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self bindSginl];
    }
    return self;
}
-(void)getModelSuccessBlock:(getModelSuccess)successBlock withFailureBlock:(getModelFailure)failureBlock{
    self.daraArr=@[[NSString stringWithFormat:@"%zd",arc4random()%100],[NSString stringWithFormat:@"%zd",arc4random()%100],[NSString stringWithFormat:@"%zd",arc4random()%100],[NSString stringWithFormat:@"%zd",arc4random()%100]];
    if (successBlock!=nil) {
        successBlock();
    }
    if (failureBlock!=nil) {
        failureBlock();
    }
}
-(void)bindSginl{
     self.daraArr=@[@"我的用户",@"出诊记录",@"待签约",@"我的钱包"];
    self.daraArrSignal=RACObserve(self, daraArr);
}
@end
