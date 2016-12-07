//
//  SignViewController.m
//  XDPRO
//
//  Created by XiaDian on 2016/11/29.
//  Copyright © 2016年 vdchina. All rights reserved.
//

#import "SignViewController.h"
#import "SignViewCollectionViewCell.h"
@interface SignViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionView *collectionView;
@end
@implementation SignViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self CreatUI];
    
    [self getData];
}
-(void)CreatUI{
 //   UICollectionViewLayout *layout=[[UICollectionViewLayout alloc]init];
    UICollectionViewFlowLayout *lay=[[UICollectionViewFlowLayout alloc]init];
    self.collectionView =[[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:lay];
    self.collectionView.backgroundColor=XDRGBColor(49, 192, 96);
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
    [self.collectionView registerClass:[SignViewCollectionViewCell class] forCellWithReuseIdentifier:@"xd"];
    [self.view addSubview:self.collectionView];
}
-(void)viewDidLayoutSubviews{
    [self LayOutUI];
}
-(void)LayOutUI{
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
    }];
}
-(void)getData{
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"xd" forIndexPath:indexPath];
    cell.backgroundView.backgroundColor=[UIColor whiteColor];
    cell.backgroundColor=[UIColor yellowColor];
    return cell;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 31;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(XDSW/7.0,XDSW/7.0);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(100,100,100,100);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0.0f;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0.0f;
}

@end
