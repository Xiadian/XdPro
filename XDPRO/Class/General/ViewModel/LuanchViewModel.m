


//
//  LuanchViewModel.m
//  XDPRO
//
//  Created by XiaDian on 2016/12/1.
//  Copyright © 2016年 vdchina. All rights reserved.
//

#import "LuanchViewModel.h"
#import "AFNetworking.h"
@implementation LuanchViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self bind];
    }
    return self;
}
-(void)bind{
    
    RACSubject *subject = [RACSubject subject];
    // 2.订阅信号
//   self.singModel=[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber){
       dispatch_time_t time=dispatch_time(DISPATCH_TIME_NOW,(int64_t)(5* NSEC_PER_SEC));
       dispatch_after(time, dispatch_get_main_queue(), ^{
           [subject sendNext:@"dd"];
       });
//       return nil;
//    }];
    
//    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//    parameters[@"q"] = @"基础";
//          [[AFHTTPSessionManager manager] GET:@"https://api.douban.com/v2/book/search" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
//          } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//              NSLog(@"%@",responseObject);
//          } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//              
//          }];
}
@end
