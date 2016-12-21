//
//  SearchViewController.m
//  XDPRO
//
//  Created by XiaDian on 2016/12/20.
//  Copyright © 2016年 vdchina. All rights reserved.
//

#import "SearchViewController.h"
#import "PYSearchViewController.h"
@interface SearchViewController ()<UISearchBarDelegate,PYSearchViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property(nonatomic,strong)PYSearchViewController *py;
@end
@implementation SearchViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.    
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{    
    // 1.创建热门搜索
    NSArray *hotSeaches = @[@"勇士队", @"库里", @"金州", @"nba"];
    // 2. 创建控制器
  self.py= [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:@"搜索你要的内容" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText){
        // 开始搜索执行以下代码
        // 如：跳转到指定控制器
        UIViewController *vv=[[UIViewController alloc]init];
        vv.view.backgroundColor=[UIColor redColor];
        [searchViewController.navigationController pushViewController:vv animated:YES];
    }];
    _py.hotSearchStyle =PYHotSearchStyleRectangleTag;
    _py.searchHistoryStyle =PYSearchHistoryStyleColorfulTag;
      // 4. 设置代理
    _py.delegate = self;
    _py.navigationItem.hidesBackButton=YES;
    // 5. 跳转到搜索控制器
    [self.navigationController pushViewController:_py animated:YES];
    return YES;
}
-(void)didClickCancel:(PYSearchViewController *)searchViewController{
    [self.searchBar resignFirstResponder];
    [searchViewController.navigationController popViewControllerAnimated:YES];
}
@end
