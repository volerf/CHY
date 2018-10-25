//
//  WorkDetailViewController.h
//  ArtPage
//
//  Created by 华杉科技 on 2018/10/3.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import "ViewController.h"
#import "GroupObj.h"
#import "WorkObj.h"
#import "WorkInfoView.h"
#import "WorkNavView.h"
#import "WorkImgScaleView.h"

@interface WorkDetailViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong) GroupObj *group;
@property(nonatomic,assign) NSInteger index;
@property(nonatomic,strong) NSMutableArray *worksArr;
@property(nonatomic,strong) UICollectionView *workCollectionView;

@property(nonatomic,strong) WorkNavView *navView;
@property(nonatomic,strong) WorkInfoView *infoView;

@end
