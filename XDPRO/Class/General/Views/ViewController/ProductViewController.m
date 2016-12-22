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
#import "ZYBannerView.h"
@interface ProductViewController ()<UITableViewDelegate,UITableViewDataSource,ZYBannerViewDataSource, ZYBannerViewDelegate>
//tableview
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//数据源数组
@property(nonatomic,strong)NSMutableArray *dataArr;
//top数组
@property(nonatomic,strong)NSMutableArray *topDataArr;
//viewModel
@property(nonatomic,strong)ProductViewModel *viewModel;
//刷新的page页码
@property(nonatomic,assign)NSInteger page;
@property (nonatomic, strong) ZYBannerView *banner;
@end
@implementation ProductViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self bindSignal];
    [self getScrollTopData];
    [self getInit];
}
#pragma mark 绑定信号
-(void)bindSignal{
    self.viewModel=[[ProductViewModel alloc]init];
    self.dataArr=[[NSMutableArray alloc]init];
    self.topDataArr=[[NSMutableArray alloc]init];
    //绑定数据源
    RAC(self,dataArr)=self.viewModel.dataArrSignal;
    //页码绑定
    RAC(self.viewModel,page)=RACObserve(self, page);
    RAC(self,topDataArr)=self.viewModel.topDataArrSignal;
    //绑定事件刷新事件
    [self getDataEvent];
    //头视图请求成功
    [self.viewModel.successScorllDataSignal subscribeNext:^(id x) {
        [self topScrollView];
    }];
    MBProgressHUD *  hud=[MBProgressHUD showHUDAddedTo:XDWindow animated:YES];
    hud.label.text=@"请求中";
    //全部网络请求结束
    [self.viewModel.NetAllDoneDataSignal subscribeNext:^(id x) {
        [hud hideAnimated:YES];
        [self.banner reloadData];
        [self.tableView reloadData];
    }];
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
- (void)getScrollTopData{
    [self.viewModel getScrollTopData];
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
/**
 头部滚动视图
 */
-(void)topScrollView{
    self.banner=[[ZYBannerView alloc] initWithFrame:CGRectMake(0, 64, XDSW, 150)];
    self.banner.dataSource = self;
    self.banner.delegate = self;
    self.tableView.tableHeaderView=self.banner;
    //循环
    self.banner.shouldLoop=YES;
    //自动滚动
    self.banner.autoScroll=NO;
    self.banner.scrollInterval=3;
    //显示又滑那个与循环不共存
    self.banner.showFooter=YES;
    //page
    self.banner.pageControlFrame=CGRectMake(XDSW-120, 130, 100,20);
    self.banner.pageControl.pageIndicatorTintColor=[UIColor blackColor];
    //当前颜色
    self.banner.pageControl.currentPageIndicatorTintColor=[UIColor whiteColor];
    self.banner.pageControl.numberOfPages=self.topDataArr.count;

}
//代理滚动数量
-(NSInteger)numberOfItemsInBanner:(ZYBannerView *)banner{
       return self.topDataArr.count;
}
-(UIView *)banner:(ZYBannerView *)banner viewForItemAtIndex:(NSInteger)index{
    UIImageView *imageView =[[UIImageView alloc]init];
    [imageView sd_setImageWithURL: [NSURL URLWithString:self.topDataArr[index]]];
    return imageView;
}
//点击
- (void)banner:(ZYBannerView *)banner didSelectItemAtIndex:(NSInteger)index{
}
- (NSString *)banner:(ZYBannerView *)banner titleForFooterWithState:(ZYBannerFooterState)footerState{
    if (footerState == ZYBannerFooterStateIdle) {
        return @"拖动进入下一页";
    } else if (footerState == ZYBannerFooterStateTrigger) {
        return @"释放进入下一页";
    }
    return nil;
}
//到详情
- (void)bannerFooterDidTrigger:(ZYBannerView *)banner{
    UIViewController *vv=[[UIViewController alloc]init];
    vv.view.backgroundColor=XDRandomColor;
    [self.navigationController pushViewController:vv animated:YES];
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *vv=[[UIViewController alloc]init];
    vv.view.backgroundColor=XDRandomColor;
    [self.navigationController pushViewController:vv animated:YES];
}
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    CGPoint target=*targetContentOffset;
    [self.viewModel topPushWithTarget:target Velocity:velocity andController:self];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.navigationController.navigationBar.hidden=NO;
}
@end
