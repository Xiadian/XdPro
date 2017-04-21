//
//  ProductViewModel.m
//  XDPRO
//
//  Created by XiaDian on 2016/12/13.
//  Copyright © 2016年 vdchina. All rights reserved.
//
#import "ProductViewModel.h"
@interface ProductViewModel ()
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)NSMutableArray *TopArr;
@end
@implementation ProductViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        //绑定信号
        [self bindSignal];
    }
    return self;
}
-(void)bindSignal{
    self.dataArrSignal=RACObserve(self, dataArr);
    self.successGetDataSignal=[[RACSubject alloc]init];
    self.failureGetDataSignal=[[RACSubject alloc]init];
    self.successScorllDataSignal=[[RACSubject alloc]init];
    self.NetAllDoneDataSignal=[[RACSubject alloc]init];
    self.topDataArrSignal=RACObserve(self, TopArr);
    [self rac_liftSelector:@selector(updateUI:data2:) withSignalsFromArray:@[self.successGetDataSignal,self.successScorllDataSignal]];
    
    [self rac_liftSelector:@selector(updateUI:data2:) withSignals:self.successGetDataSignal,self.successScorllDataSignal, nil];
    self.dataArr=[[NSMutableArray alloc]init];
    self.TopArr=[[NSMutableArray alloc]init];
 }
- (void)updateUI:(NSString *)data1 data2:(NSString *)data2
{  
    [self.NetAllDoneDataSignal sendNext:@"全部结束啦"] ;
}
//获取数据
-(void)getData{
    NSDictionary *dic=@{@"gender":@"2",@"generation":@"2",@"limit":@"20",@"offset":[NSString stringWithFormat:@"%zd",self.page]};
    [XDNetRequest XDRequsetType:GET withRequestUrl:API_tableView withPragram:dic withSuccessBlock:^(id response) {
        if (self.page==0) {
            [self.dataArr removeAllObjects];
        }
        NSArray *arr=response[@"data"][@"items"];
        for (NSDictionary *dic in arr) {
            ProductModel *pm=[[ProductModel alloc]init];
            [pm setValuesForKeysWithDictionary:dic];
            [self.dataArr addObject:pm];
        }
        RACTuple *tupleSuc = RACTuplePack(@(RefreshNormal));
        RACTuple *tupleSucNormoreData = RACTuplePack(@(RefreshNoMoreData));
        //处理没数据的下拉刷新
        arr.count==0? [self.successGetDataSignal sendNext:tupleSucNormoreData]: [self.successGetDataSignal sendNext:tupleSuc];
    } failure:^(NSError *error) {
        [self.failureGetDataSignal sendNext:@"fail"];
    }];
}
-(void)getScrollTopData{
     NSDictionary *dic=@{@"channel":@"iOS"};
    [XDNetRequest XDRequsetType:GET withRequestUrl:API_SCROLLTOP withPragram:dic withSuccessBlock:^(id response) {
        NSArray *arr=response[@"data"][@"banners"];
        for (NSDictionary *dic in arr) {
            [self.TopArr addObject:dic[@"image_url"]];
        }
          [self.successScorllDataSignal sendNext:@"success"];
    } failure:^(NSError *error) {
        [self.failureGetDataSignal sendNext:@"fail"];
    }];

}
/**
 导航栏
 */
-(void)topPushWithTarget:(CGPoint)target Velocity:(CGPoint)velocity andController:(UIViewController *)vc{
    if (velocity.y-0.000001>0||target.y>0){
        vc.navigationController.navigationBar.hidden=YES;
        return;
    }
    if (target.y<64) {
        vc.navigationController.navigationBar.hidden=NO;
        return;
    }
}


@end
