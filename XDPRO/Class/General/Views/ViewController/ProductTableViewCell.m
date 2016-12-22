//
//  ProductTableViewCell.m
//  XDPRO
//
//  Created by XiaDian on 2016/12/14.
//  Copyright © 2016年 vdchina. All rights reserved.
//

#import "ProductTableViewCell.h"
@implementation ProductTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.titleLab.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0.8];
    self.titleLab.animationDuration =0.4;
    self.titleLab.animationDelay =0.05;
       
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
