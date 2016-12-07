//
//  MineViewController.m
//  KBHEHE
//
//  Created by XiaDian on 2016/12/6.
//  Copyright © 2016年 KeBun. All rights reserved.
//
#import "MineViewController.h"
#import "MineTableViewCell.h"
@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>
//上部View
@property(nonatomic,strong)UIView *topView;
//上部Icon图片
@property(nonatomic,strong)UIImageView *topIconImg;
//星星View
@property(nonatomic,strong)UIView *starView;
//姓名lab
@property(nonatomic,strong)UILabel *nameLab;
//在线咨询lab
@property(nonatomic,strong)UILabel *midOnlineLab;
//金币lab
@property(nonatomic,strong)UILabel *coinLab;
//中部表格View
@property(nonatomic,strong)UIView *midView;
//中部tableVIew
@property(nonatomic,strong)UITableView *midTableView;
//底部Btn
@property(nonatomic,strong)UIButton *bottomBtn;
//模拟数据数组1
@property(nonatomic,strong)NSArray *dataArr1;
//模拟数据数组2
@property(nonatomic,strong)NSArray *dataArr2;
@end
@implementation MineViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    //配置
    [self Config];
    //UI
    [self CreatUI];
    //适配
    [self LayOutUI];
}
-(void)Config{
    [SZRFunction SZRSetLayerImage:self.view imageStr:@"dl-bj"];
    self.navigationItem.title=@"心理咨询师";
  //  self.navigationItem.hidesBackButton=YES;
    self.dataArr1=@[@"我的用户",@"出诊记录",@"待签约",@"我的钱包"];
    self.dataArr2=@[@"rx",@"logo2",@"dqy",@"qb"];
    //右上角按钮
    UIImage *aimage = [UIImage imageNamed:@"ltx"];
    UIImage *image = [aimage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *btn=[[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(userClick:)];
    btn.imageInsets=UIEdgeInsetsMake(7, 7, 7, 7);
    self.navigationItem.rightBarButtonItem=btn;
}
#pragma mark创建UI
-(void)CreatUI{
#pragma mark 顶部UI
    //顶部view
    self.topView=[[UIView alloc]init];
    [self.view addSubview:self.topView];
    //顶部头像icon
    self.topIconImg=[[UIImageView alloc]init];
    self.topIconImg.image=[UIImage imageNamed:@"dtx"];
    [self.topView addSubview:self.topIconImg];
    //名称lab
    self.nameLab=[[UILabel alloc]init];
    self.nameLab.text=@"张小兰";
    self.nameLab.textColor=[UIColor whiteColor];
    self.nameLab.adjustsFontSizeToFitWidth=YES;
    [self.topView addSubview:self.nameLab];
    //星星view
    self.starView=[[UIView alloc]init];
    for (int i=0;i<5 ; i++) {
        UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(30*i,5, 20, 20)];
        img.image=[UIImage imageNamed:@"icon_star"];
        [self.starView addSubview:img];
    }
    [self.topView addSubview:self.starView];
    //咨询lab
    self.midOnlineLab=[[UILabel alloc]init];
    self.midOnlineLab.text=@"在线：60小时  咨询：16 外出：8";
    self.midOnlineLab.textColor=RGBCOLOR(245, 249, 188);
    self.midOnlineLab.font=[UIFont systemFontOfSize:16];
    self.midOnlineLab.adjustsFontSizeToFitWidth=YES;
    [self.topView addSubview:self.midOnlineLab];
    //金币lab
    self.coinLab=[[UILabel alloc]init];
    self.coinLab.text=@"金币：1350  锦旗：35";
    self.coinLab.textColor=RGBCOLOR(245, 249, 188);
    self.coinLab.font=[UIFont systemFontOfSize:16];
    self.coinLab.adjustsFontSizeToFitWidth=YES;
    [self.topView addSubview:self.coinLab];
    //tableVIew
    self.midTableView=[[UITableView alloc]init];
    self.midTableView.delegate=self;
    self.midTableView.dataSource=self;
    self.midTableView.backgroundColor=[UIColor clearColor];
    self.midTableView.separatorColor=[UIColor clearColor];
    self.midTableView.bounces=NO;
    [self.view addSubview:self.midTableView];
    [self.midTableView registerNib:[UINib nibWithNibName:@"MineTableViewCell" bundle:nil] forCellReuseIdentifier:@"mine"];
    //底部View
    self.bottomBtn=[[UIButton alloc]init];
    self.bottomBtn.backgroundColor=RGBCOLOR(250, 78, 83);
    [self.bottomBtn setTitle:@"有一位用户正在和你咨询" forState:UIControlStateNormal];
    [self.bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.bottomBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    [self.view addSubview:self.bottomBtn];
}
#pragma mark 适配UI
-(void)LayOutUI{
    //顶部视图
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@(120));
    }];
    //顶部头像图片
    [self.topIconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView.mas_left).offset(20);
        make.centerY.equalTo(self.topView.mas_centerY);
        make.width.equalTo(@(SZRScreenWidth/4.0));
        make.height.equalTo(self.topIconImg.mas_width);
    }];
    //姓名lab
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topIconImg.mas_right).offset(20);
        make.top.equalTo(self.topView.mas_top).offset(10);
        make.width.equalTo(@(50));
        make.height.equalTo(@(30));
    }];
    //星星View
    [self.starView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLab.mas_right).offset(10);
        make.top.equalTo(self.topView.mas_top).offset(10);
        make.right.equalTo(self.topView.mas_right).offset(-20);
        make.height.equalTo(@(30));
    }];
    //中间在线咨询lab
    [self.midOnlineLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topIconImg.mas_right).offset(20);
        make.top.equalTo(self.starView.mas_bottom).offset(2);
        make.right.equalTo(self.topView.mas_right).offset(-20);
        make.height.equalTo(@(30));
    }];
    //金币lab
    [self.coinLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topIconImg.mas_right).offset(20);
        make.top.equalTo(self.midOnlineLab.mas_bottom).offset(2);
        make.right.equalTo(self.topView.mas_right).offset(-20);
        make.height.equalTo(@(30));
    }];
    //中部tableVIew视图
    [self.midTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@(SZRScreenHeight-150-64-50));
    }];
    //底部视图
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@(50));
    }];
}
#pragma mark tableView代理
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"mine"];
    cell.titleLabel.text=self.dataArr1[indexPath.row];
    cell.titleImg.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",self.dataArr2[indexPath.row]]];
    if (indexPath.row==0) {
        cell.messegeLabel.hidden=NO;
    }
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
//右上角按钮
-(void)userClick:(id)sender{
}
@end
