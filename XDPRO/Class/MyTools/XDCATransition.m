//
//  XDCATransition.m
//  XDPRO
//
//  Created by XiaDian on 2016/12/19.
//  Copyright © 2016年 vdchina. All rights reserved.
//
#import "XDCATransition.h"
@interface  XDCATransition()
//普通样式数组
@property(nonatomic,strong)NSArray *typeArr;
//子样式数组
@property(nonatomic,strong)NSArray *subTypeArr;
@end
@implementation XDCATransition
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.typeArr=@[@"fade",@"push",@"reveal",@"moveIn",@"cube",@"suckEffect",@"oglFlip",@"rippleEffect",@"pageCurl",@"pageUnCurl",@"cameraIrisHollowOpen",@"cameraIrisHollowClose",@"curlDown",@"curlUp",@"flipFromLeft",@"flipFromRight"];
            self.subTypeArr=@[@"fromTop",@"fromBottom",@"fromLeft",@"fromRight"];
    }
    return self;
}
+(instancetype)getManager{
  return  [[self alloc]init];
}
-(void)XDCATransitionAddTo:(UIView *)view Type:(TransitionType)type Subtype:(TransitionSubType)subType duration:(CFTimeInterval)duration andKey:(NSString *)key{
    CATransition *ca=[[CATransition alloc]init];
    ca.type=self.typeArr[type];
    ca.duration=duration;
    if (self.subTypeArr!=Defoult) {
        ca.subtype=self.subTypeArr[subType];
    }
    [view.layer addAnimation:ca forKey:key];
}
@end
