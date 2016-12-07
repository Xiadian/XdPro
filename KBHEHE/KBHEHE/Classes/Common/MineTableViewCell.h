//
//  MineTableViewCell.h
//  KBHEHE
//
//  Created by XiaDian on 2016/12/6.
//  Copyright © 2016年 KeBun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineTableViewCell : UITableViewCell
//背景view
@property (weak, nonatomic) IBOutlet UIView *bgView;
//标题label
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
//消息气泡
@property (weak, nonatomic) IBOutlet UILabel *messegeLabel;
//标题图片
@property (weak, nonatomic) IBOutlet UIImageView *titleImg;

@end
