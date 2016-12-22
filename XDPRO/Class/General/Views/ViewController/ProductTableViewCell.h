//
//  ProductTableViewCell.h
//  XDPRO
//
//  Created by XiaDian on 2016/12/14.
//  Copyright © 2016年 vdchina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCAnimatedLabel.h"
@interface ProductTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet ZCAnimatedLabel *titleLab;
@property (weak, nonatomic) IBOutlet UIImageView *titleImg;
@end
