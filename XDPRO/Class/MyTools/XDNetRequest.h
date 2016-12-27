//
//  XDNetRequest.h
//  KBHEHE
//
//  Created by XiaDian on 2016/12/8.
//  Copyright © 2016年 KeBun. All rights reserved.
//
#import <Foundation/Foundation.h>
//请求类型枚举
typedef   enum {
  POST,
  GET
}requestType;
//网络请求成功
typedef void (^netSuccessBlock)(id response);
//网络请求失败
typedef void (^netFailureBlock)(NSError * error);
@interface XDNetRequest : NSObject
/*
 普通网络请求
 */
+(void)XDRequsetType:(requestType) type withRequestUrl:(NSString *)url withPragram:(NSDictionary *)pragramDic withSuccessBlock:(netSuccessBlock) successBlock failure:(netFailureBlock)failureBlock;
/*
 普通练习带hud网络请求
 */
+(void)XDHUDRequsetType:(requestType) type withRequestUrl:(NSString *)url withPragram:(NSDictionary *)pragramDic withSuccessBlock:(netSuccessBlock) successBlock failure:(netFailureBlock)failureBlock withHUDTitle:(NSString *)hudTitle;
@end
