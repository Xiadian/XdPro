//
//  CocoaMVVMViewController.m
//  XDiOSPRO
//
//  Created by XiaDian on 2016/11/25.
//  Copyright © 2016年 vdchina. All rights reserved.
//

#import "CocoaMVVMViewController.h"

@interface CocoaMVVMViewController ()
@property(nonatomic,strong)UIButton *lefBtn;
@property(nonatomic,strong)UIButton *rightBtn;

@property(nonatomic,strong)UILabel *label;

@end

@implementation CocoaMVVMViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
  self.lefBtn =[XDFACTORY creatBtnWithFrame:CGRectMake(0, 0, 200, 40) andBackImg:nil andWithBackColor:[UIColor redColor] andBtnTitle:@"左按钮" andAddView:self.view andTouchBlock:^(id sender) {
    }];
    self.rightBtn =[XDFACTORY creatBtnWithFrame:CGRectMake(0, 0, 200, 40) andBackImg:nil andWithBackColor:[UIColor redColor] andBtnTitle:@"右按钮" andAddView:self.view andTouchBlock:^(id sender) {
    }];
    [self  layout];
}
-(void)layout{
[self.lefBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//    make.right.equalTo(self.view.mas_right);
//    make.left.equalTo(self.view.mas_left);
//   make.top.equalTo(self.view).offset(300);
//    make.height.equalTo(@(30));
//    make.centerX.equalTo(self.view.mas_centerX).offset(0);
//    make.centerY.equalTo(self.view.mas_centerY).offset(0);
//    make.size.sizeOffset(CGSizeMake(20, 30));
 //   make.size.sizeOffset(CGSizeMake(20, 30));
    make.left.equalTo(self.view.mas_left);
    make.centerY.equalTo(self.view.mas_centerY);
    make.right.equalTo(self.rightBtn.mas_left).offset(-10);
    make.height.equalTo(@(50));
    make.width.equalTo(self.rightBtn);
}];
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right);
        make.centerY.equalTo(self.view.mas_centerY);
        make.height.equalTo(@(50));
        make.left.equalTo(self.lefBtn.mas_right).offset(10);
        make.width.equalTo(self.lefBtn);
    }];
}
@end
