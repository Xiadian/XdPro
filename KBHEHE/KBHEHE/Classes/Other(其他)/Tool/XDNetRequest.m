//
//  XDNetRequest.m
//  KBHEHE
//
//  Created by XiaDian on 2016/12/8.
//  Copyright © 2016年 KeBun. All rights reserved.
//
#import "XDNetRequest.h"
#import <AFNetworking/AFNetworking.h>
#import <MBProgressHUD/MBProgressHUD.h>
#define XDWINDOW         [[UIApplication sharedApplication].windows lastObject]
@interface XDNetRequest ()
@end
@implementation XDNetRequest
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+(void)XDRequsetType:(requestType)type withRequestUrl:(NSString *)url withPragram:(NSDictionary *)pragramDic withSuccessBlock:(netSuccessBlock)successBlock failure:(netFailureBlock) failureBlock{
    switch (type) {
        case GET:
        {
        [[AFHTTPSessionManager manager] GET:url parameters:pragramDic progress:^(NSProgress * _Nonnull downloadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            successBlock(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failureBlock(error);
        }];
        }
            break;
        case POST:{
            [[AFHTTPSessionManager manager]POST:url parameters:pragramDic progress:^(NSProgress * _Nonnull uploadProgress) {
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                successBlock(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failureBlock(error);
            }];
        }
            break;
        default:
            break;
    }
}
+(void)XDHUDRequsetType:(requestType)type withRequestUrl:(NSString *)url withPragram:(NSDictionary *)pragramDic withSuccessBlock:(netSuccessBlock)successBlock failure:(netFailureBlock)failureBlock withHUDTitle:(NSString *)hudTitle{
    MBProgressHUD *  hud=[MBProgressHUD showHUDAddedTo:XDWINDOW animated:YES];
    hud.label.text=hudTitle;
    [XDNetRequest XDRequsetType:type withRequestUrl:url withPragram:pragramDic withSuccessBlock:^(id response) {
        [hud hideAnimated:YES];
        successBlock(response);
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}
@end
