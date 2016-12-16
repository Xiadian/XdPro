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
    self.dataArr=[[NSMutableArray alloc]init];
}
//获取数据
-(void)getData{
    NSDictionary *dic=@{@"gender":@"2",@"generation":@"2",@"limit":@"20",@"offset":[NSString stringWithFormat:@"%zd",self.page]};
    [XDNetRequest XDHUDRequsetType:GET withRequestUrl:API_tableView withPragram:dic withSuccessBlock:^(id response) {
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
    } withHUDTitle:nil];
}
@end
