//
//  ProductViewController.m
//  XDPRO
//
//  Created by XiaDian on 2016/12/13.
//  Copyright © 2016年 vdchina. All rights reserved.
//

#import "ProductViewController.h"
#import "ProductViewModel.h"
#import "ProductTableViewCell.h"
@interface ProductViewController ()<UITableViewDelegate,UITableViewDataSource>
//tableview
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//数据源数组
@property(nonatomic,strong)NSMutableArray *dataArr;
//viewModel
@property(nonatomic,strong)ProductViewModel *viewModel;
//刷新的page页码
@property(nonatomic,assign)NSInteger page;
@end
@implementation ProductViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self bindSignal];
    [self getInit];
}
#pragma mark 绑定信号
-(void)bindSignal{
    self.viewModel=[[ProductViewModel alloc]init];
    self.dataArr=[[NSMutableArray alloc]init];
    //绑定数据源
    RAC(self,dataArr)=self.viewModel.dataArrSignal;
    //页码绑定
    RAC(self.viewModel,page)=RACObserve(self, page);
    //绑定事件
    [self getDataEvent];
}
#pragma mark 获取数据的事件处理
-(void)getDataEvent{
    //获取数据成功
    @weakify(self);
    [self.viewModel.successGetDataSignal subscribeNext:^(id x) {
        @strongify(self);
        RACTupleUnpack(NSNumber  *z)=x;
        switch ([z intValue]) {
            //无更多数据
            case RefreshNoMoreData:
            {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
                break;
            //普通状态
            case RefreshNormal:
            {
                [self.tableView.mj_footer endRefreshing];
            }
                break;
            default:
                break;
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    }];
     //获取数据失败
    [self.viewModel.failureGetDataSignal subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}
#pragma mark 获得初始数据
-(void)getInit{
     self.page=275;
    [self.tableView registerNib:[UINib nibWithNibName:@"ProductTableViewCell" bundle:nil] forCellReuseIdentifier:@"xd"];
    //获取初始数据
    [self.viewModel getData];
    //初始化刷新控件
    self.tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.page++;
        [self.viewModel getData];
    }];
    self.tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page=0;
        [self.viewModel getData];
    }];
}
#pragma mark tableview代理
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ProductTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"xd"];
    self.viewModel.model=self.dataArr[indexPath.row];
    cell.titleLab.text=self.viewModel.model.short_title;
    [cell.titleImg sd_setImageWithURL:[NSURL URLWithString:self.viewModel.model.cover_image_url]];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.dataArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}
@end
