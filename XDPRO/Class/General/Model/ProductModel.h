//
//  ProductModel.h
//  XDPRO
//
//  Created by XiaDian on 2016/12/14.
//  Copyright © 2016年 vdchina. All rights reserved.
//

#import "BaseModel.h"

@interface ProductModel : BaseModel
@property(nonatomic,strong)NSString *content_url;
@property(nonatomic,strong)NSString *cover_image_url;
@property(nonatomic,strong)NSString *created_at;
@property(nonatomic,strong)NSString *editor_id;
@property(nonatomic,strong)NSString *id;
@property(nonatomic,strong)NSString *labels;
@property(nonatomic,strong)NSString *liked;
@property(nonatomic,strong)NSString *likes_count;
@property(nonatomic,strong)NSString *published_at;
@property(nonatomic,strong)NSString *share_msg;
@property(nonatomic,strong)NSString *short_title;
@property(nonatomic,strong)NSString *status;
@property(nonatomic,strong)NSString *template;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *type;
@property(nonatomic,strong)NSString *updated_at;
@property(nonatomic,strong)NSString *url;
@end
