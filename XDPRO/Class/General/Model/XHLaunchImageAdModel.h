//
//  XHLaunchImageAdModel.h
//  XDPRO
//
//  Created by XiaDian on 2017/1/5.
//  Copyright © 2017年 vdchina. All rights reserved.
//

#import "BaseModel.h"

@interface XHLaunchImageAdModel : BaseModel
@property(nonatomic,assign)CGFloat duration;
@property(nonatomic,assign)CGFloat width;
@property(nonatomic,assign)CGFloat height;
@property(nonatomic,copy)NSString *content;
@property(nonatomic,copy)NSString *openUrl;
@end
