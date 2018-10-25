//
//  WorkGroupViewController.h
//  ArtPage
//
//  Created by 华杉科技 on 2018/9/20.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import "ViewController.h"
#import "GroupObj.h"

@interface WorkGroupViewController : ViewController<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong) GroupObj *groupObj;
@property(nonatomic,strong) NSMutableArray *workArr;

@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UILabel *groupName;
@property(nonatomic,strong) UILabel *workCount;
@property(nonatomic,strong) UIButton *shareBtn;
@property(nonatomic,strong) UICollectionView *workCollection;

@end
