//
//  MIneViewModel.h
//  KBHEHE
//
//  Created by XiaDian on 2016/12/8.
//  Copyright © 2016年 KeBun. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^getModelSuccess)(void) ;
typedef void(^getModelFailure)(void) ;
@interface MIneViewModel : NSObject
@property(nonatomic,strong)RACSignal *daraArrSignal;
@property(nonatomic,strong)RACSignal *niu;
@property(nonatomic,strong)NSArray *daraArr;
-(void)getModelSuccessBlock:(getModelSuccess) successBlock withFailureBlock:(getModelFailure)failureBlock;
@end
