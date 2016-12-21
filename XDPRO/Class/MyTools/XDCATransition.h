//
//  XDCATransition.h
//  XDPRO
//
//  Created by XiaDian on 2016/12/19.
//  Copyright © 2016年 vdchina. All rights reserved.
//
//跳转动画的封装
#import <Foundation/Foundation.h>
typedef enum{
    Fade = 0,                   //淡入淡出
    Push,                       //推挤
    Reveal,                     //揭开
    MoveIn,                     //覆盖
    Cube,                       //立方体
    SuckEffect,                 //吮吸
    OglFlip,                    //翻转
    RippleEffect,               //波纹
    PageCurl,                   //翻页
    PageUnCurl,                 //反翻页
    CameraIrisHollowOpen,       //开镜头
    CameraIrisHollowClose,      //关镜头
    CurlDown,                   //下翻页
    CurlUp,                     //上翻页
    FlipFromLeft,               //左翻转
    FlipFromRight,              //右翻转
} TransitionType;
typedef enum{
    Defoult,
    FromTop,
    FromBottom,
    FromLeft,
    FromRight,
} TransitionSubType;
@interface XDCATransition : NSObject
+(instancetype)getManager;
/**
 普通的过渡动画
 @param view     添加的视图
 @param type     样式
 @param subType  子样式
 @param duration 动画时间
 @param key      动画的key
 */
-(void)XDCATransitionAddTo:(UIView *)view Type:(TransitionType)  type Subtype:(TransitionSubType) subType duration:(CFTimeInterval) duration andKey:(NSString *)key;

@end
