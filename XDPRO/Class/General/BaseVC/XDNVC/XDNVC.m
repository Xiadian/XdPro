//
//  XDNVC.m
//  XDiOSdemo
//
//  Created by XiaDian on 2016/11/25.
//  Copyright © 2016年 vdchina. All rights reserved.
//
#import "XDNVC.h"
@interface XDNVC ()

@end

@implementation XDNVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self config];
}
-(void)config{
    // 设置导航栏title颜色w
    NSDictionary * textA = @{
                             NSFontAttributeName : [UIFont systemFontOfSize:20],
                             NSForegroundColorAttributeName : [UIColor whiteColor],
                             };
    [[UINavigationBar appearance] setTitleTextAttributes:textA];
    // 设置所有导航背景颜色
    [[UINavigationBar appearance] setBarTintColor:XDRandomColor];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}
@end
