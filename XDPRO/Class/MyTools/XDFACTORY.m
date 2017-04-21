//
//  XDFACTORY.m
//  XDiOSPRO
//
//  Created by XiaDian on 2016/11/25.
//  Copyright © 2016年 vdchina. All rights reserved.
//
#import "XDFACTORY.h"
#import <ReactiveObjC/ReactiveObjC.h>
@implementation XDFACTORY
//创建btn
+(UIButton *)creatBtnWithFrame:(CGRect)frame andBackImg:(UIImage *)img andWithBackColor:(UIColor *)color andBtnTitle:(NSString *)title andAddView:(UIView *)view andTouchBlock:(void (^)(id))touchBlock{
    UIButton *btn=[[UIButton alloc]init];
    btn.frame=frame;
    [btn setTitle:title forState:UIControlStateNormal];
    if (img!=nil) {
        [btn setBackgroundImage:img forState:UIControlStateNormal];
    }
    btn.backgroundColor=color;
    [view addSubview:btn];
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        touchBlock(btn);
    }];
    return btn;
}
@end
