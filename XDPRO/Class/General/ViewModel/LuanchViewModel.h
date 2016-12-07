//
//  LuanchViewModel.h
//  XDPRO
//
//  Created by XiaDian on 2016/12/1.
//  Copyright © 2016年 vdchina. All rights reserved.
//

#import "BaseViewModel.h"

@interface LuanchViewModel : BaseViewModel
@property(nonatomic,strong)NSString *ddd;
@property(nonatomic,strong)RACSignal *singModel;
@end
