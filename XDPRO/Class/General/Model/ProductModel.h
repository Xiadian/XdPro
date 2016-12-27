//
//  ProductModel.h
//  XDPRO
//
//  Created by XiaDian on 2016/12/14.
//  Copyright © 2016年 vdchina. All rights reserved.
//

#import "BaseModel.h"

@interface ProductModel : BaseModel
@property(nonatomic,copy)NSString *content_url;
@property(nonatomic,copy)NSString *cover_image_url;
@property(nonatomic,copy)NSString *created_at;
@property(nonatomic,copy)NSString *editor_id;
@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *labels;
@property(nonatomic,copy)NSString *liked;
@property(nonatomic,copy)NSString *likes_count;
@property(nonatomic,copy)NSString *published_at;
@property(nonatomic,copy)NSString *share_msg;
@property(nonatomic,copy)NSString *short_title;
@property(nonatomic,copy)NSString *status;
@property(nonatomic,copy)NSString *template;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString *updated_at;
@property(nonatomic,copy)NSString *url;
@end
