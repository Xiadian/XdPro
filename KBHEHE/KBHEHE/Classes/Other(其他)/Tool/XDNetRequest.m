//
//  XDNetRequest.m
//  KBHEHE
//
//  Created by XiaDian on 2016/12/8.
//  Copyright © 2016年 KeBun. All rights reserved.
//
#import "XDNetRequest.h"
#import <AFNetworking/AFNetworking.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
@implementation XDNetRequest
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
+(void)XDRequsetType:(requestType)type withRequestUrl:(NSString *)url withPragram:(NSDictionary *)pragramDic withSuccessBlock:(successBlock)successBlock failure:(failureBlock) failBlock{
    switch (type) {
        case GET:
        {
        [[AFHTTPSessionManager manager] GET:url parameters:pragramDic progress:^(NSProgress * _Nonnull downloadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            successBlock(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failBlock(error);
        }];
        }
            break;
        case POST:{
            [[AFHTTPSessionManager manager]POST:url parameters:pragramDic progress:^(NSProgress * _Nonnull uploadProgress) {
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                successBlock(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failBlock(error);
            }];
        }
            break;
        default:
            break;
    }
}
@end
