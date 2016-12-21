//
//  MainTabViewController.m
//  XDPRO
//
//  Created by XiaDian on 2016/12/16.
//  Copyright © 2016年 vdchina. All rights reserved.
//
#import "MainTabViewController.h"
#import "XDNVC.h"
#import "BaseViewController.h"
#import "ProductViewController.h"
#import "SearchViewController.h"
@interface MainTabViewController ()

@end

@implementation MainTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addSubVc];
}
-(void)addSubVc{
    ProductViewController *bvc=[[ProductViewController alloc]init];
    XDNVC *nv=[[XDNVC alloc]initWithRootViewController:bvc];
    bvc.navigationItem.title=@"商品";
    SearchViewController *searchViewController=[[SearchViewController alloc]init];
    XDNVC *nv2=[[XDNVC alloc]initWithRootViewController:searchViewController];
    searchViewController.navigationItem.title=@"搜索";
    BaseViewController *bvc2=[[BaseViewController alloc]init];
    XDNVC *nv3=[[XDNVC alloc]initWithRootViewController:bvc2];
    BaseViewController *bvc3=[[BaseViewController alloc]init];
    XDNVC *nv4=[[XDNVC alloc]initWithRootViewController:bvc3];
    [self setViewControllers:@[nv,nv2,nv4,nv3]];
    nv.tabBarItem.title=@"商品";
    nv2.tabBarItem.title=@"搜索";
    nv3.tabBarItem.title=@"多地方发点";
    nv4.tabBarItem.title=@"都是";
    
}
@end
