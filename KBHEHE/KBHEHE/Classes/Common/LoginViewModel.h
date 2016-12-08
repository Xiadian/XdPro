//
//  LoginViewModel.h
//  KBHEHE
//
//  Created by XiaDian on 2016/12/7.
//  Copyright © 2016年 KeBun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginViewModel : NSObject
@property(nonatomic,strong)RACSubject *successSignal;
@property(nonatomic,strong)RACSubject *failSignal;
@property(nonatomic,strong)NSString *psw;
@property(nonatomic,strong)NSString *tele;

-(id)pswSix;
-(void)login;
@end
