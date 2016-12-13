//
//  MineTableViewCell.m
//  KBHEHE
//
//  Created by XiaDian on 2016/12/6.
//  Copyright © 2016年 KeBun. All rights reserved.
//

#import "MineTableViewCell.h"
@implementation MineTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.bgView.layer.borderColor=RGBCOLOR(200, 200, 200).CGColor;
    self.bgView.layer.borderWidth=0.4;
    self.messegeLabel.layer.cornerRadius=8;
    self.messegeLabel.clipsToBounds=YES;
    self.messegeLabel.hidden=YES;
    self.backgroundColor=[UIColor clearColor];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
