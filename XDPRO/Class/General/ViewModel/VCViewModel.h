//
//  VCViewModel.h
//  XDPRO
//
//  Created by XiaDian on 2016/12/5.
//  Copyright © 2016年 vdchina. All rights reserved.
//

#import "BaseModel.h"

@interface VCViewModel : BaseModel
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) RACSubject *successObject;
@property (nonatomic, strong) RACSubject *failureObject;
@property (nonatomic, strong) RACSubject *errorObject;
- (id) buttonIsValid;
- (void)login;
@end
