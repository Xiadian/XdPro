//
//  DEFINE.h
//  XDiOSdemo
//
//  Created by XiaDian on 2016/11/25.
//  Copyright © 2016年 vdchina. All rights reserved.
//

#ifndef DEFINE_h
#define DEFINE_h
//屏幕的宽
#define XDSW  [UIScreen mainScreen].bounds.size.width
//屏幕的高
#define XDSH   [UIScreen mainScreen].bounds.size.height
//最后的window
#define XDWindow   [[[UIApplication sharedApplication] windows] lastObject]
//随机颜色
#define XDRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]
//RGB颜色
#define XDRGBColor(r,g,b)  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0f]
//RGBA颜色
#define XDRGBAColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:a]
//获取temp
#define XDPathTemp NSTemporaryDirectory()
//获取沙盒 Document
#define XDPathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
//获取沙盒 Cache
#define XDPathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
/**Dubug相关*/
#ifdef DEBUG
#define MyLog(format,...)  NSLog((@"[函数名:%s]\n" "[行号:%d]\n" format),__FUNCTION__,__LINE__,##__VA_ARGS__)
#else
#define MyLog(...)
#endif


#endif /* DEFINE_h */
