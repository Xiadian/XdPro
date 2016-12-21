//
//  ProductViewModel.h
//  XDPRO
//
//  Created by XiaDian on 2016/12/13.
//  Copyright © 2016年 vdchina. All rights reserved.
//

#import "BaseViewModel.h"
#import "ProductModel.h"
typedef  enum {
  RefreshNoMoreData,
  RefreshNormal
} freshState;
@interface ProductViewModel : BaseViewModel
@property(nonatomic,strong)RACSignal *dataArrSignal;
//登陆成功信号
@property(nonatomic,strong)RACSubject *successGetDataSignal;
//登陆失败信号
@property(nonatomic,strong)RACSubject *failureGetDataSignal;
//model
@property(nonatomic,strong)ProductModel *model;
//数据page页
@property(nonatomic,assign)NSInteger page;

//获取数据的方法
-(void)getData;
-(void)topPushWithTarget:(CGPoint )target Velocity:(CGPoint)velocity andController:(UIViewController *)vc;
@end
