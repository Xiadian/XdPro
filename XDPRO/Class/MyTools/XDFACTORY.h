//
//  XDFACTORY.h
//  XDiOSPRO
//
//  Created by XiaDian on 2016/11/25.
//  Copyright © 2016年 vdchina. All rights reserved.
//
#import <Foundation/Foundation.h>
@interface XDFACTORY : NSObject
//创建一个普通button带点击事件
+(UIButton *)creatBtnWithFrame:(CGRect)frame andBackImg:(UIImage *)img andWithBackColor:(UIColor *)color andBtnTitle:(NSString *)title andAddView:(UIView *)view andTouchBlock:(void(^)(id sender))touchBlock;
@end
