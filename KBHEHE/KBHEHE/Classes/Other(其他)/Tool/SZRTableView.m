//
//  SZRTableView.m
//  MicroNews
//
//  Created by MS on 15-12-15.
//  Copyright (c) 2015年 SZR. All rights reserved.
//

#import "SZRTableView.h"

@implementation SZRTableView
//创建tableView
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style controller:(id<UITableViewDataSource,UITableViewDelegate>)controller{
    if (self = [super initWithFrame:frame style:style]) {
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        //指定代理类为传进来的VC类
        self.dataSource = controller;
        self.delegate = controller;
        //添加到ViewController上
        UIViewController * VC = (UIViewController *)controller;
        [VC.view addSubview:self];
    }
    return self;
}






@end
