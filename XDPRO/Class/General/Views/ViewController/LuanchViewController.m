//
//  LuanchViewController.m
//  XDPRO
//
//  Created by XiaDian on 2016/11/29.
//  Copyright © 2016年 vdchina. All rights reserved.
//

#import "LuanchViewController.h"
#import "CocoaMVVMViewController.h"
#import "SignViewController.h"
@interface LuanchViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArr;
@end

@implementation LuanchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self CreatUI];
    [self getData];
    // Do any additional setup after loading the view.
}
-(void)CreatUI{
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, XDSW, XDSH) style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"luach"];
    [self.view addSubview:self.tableView];
    
}
-(void)viewDidLayoutSubviews{
  [self LayOutUI];
}
-(void)LayOutUI{
[self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.view.mas_top);
    make.bottom.equalTo(self.view.mas_bottom);
    make.left.equalTo(self.view.mas_left);
    make.right.equalTo(self.view.mas_right);
}];
    
}

-(void)getData{
   
//    MBProgressHUD *hudDeng = [MBProgressHUD showHUDAddedTo:XDWindow animated:YES];
//    // Set the annular determinate mode to show task progress.
//    hudDeng.mode =MBProgressHUDModeIndeterminate;
//    hudDeng.userInteractionEnabled=NO;
     dispatch_time_t time=dispatch_time(DISPATCH_TIME_NOW,(int64_t)(1 * NSEC_PER_SEC));
    dispatch_after(time, dispatch_get_main_queue(), ^{
         self.dataArr=[[NSMutableArray alloc]initWithArray:@[@"SignViewController"]];
        [self.tableView reloadData];
   //     [hudDeng hideAnimated:YES];
    });
}
#pragma mark
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"luach"];
    cell.textLabel.text=self.dataArr[indexPath.row];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    id vc= [[[NSClassFromString(self.dataArr[indexPath.row]) class] alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
