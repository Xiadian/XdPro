//
//  XDNetRequest.h
//  KBHEHE
//
//  Created by XiaDian on 2016/12/8.
//  Copyright © 2016年 KeBun. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef   enum {
  POST,
  GET
}requestType;
typedef void (^successBlock)(id response);
typedef void (^failureBlock)(NSError * error);
@interface XDNetRequest : NSObject
+(void)XDRequsetType:(requestType) type withRequestUrl:(NSString *)url withPragram:(NSDictionary *)pragramDic withSuccessBlock:(successBlock) successBlock failure:(failureBlock)failBlock;
@end
