//
//  XDMBHUD.m
//  KBHEHE
//
//  Created by XiaDian on 2016/12/13.
//  Copyright © 2016年 KeBun. All rights reserved.
//
#import "XDMBHUD.h"
#define XDWINDOW         [[UIApplication sharedApplication].windows lastObject]
@implementation XDMBHUD
- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}
+(void)addHud{
   [MBProgressHUD showHUDAddedTo:XDWINDOW animated:YES];
}
@end
