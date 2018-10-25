//
//  WorkGroupCollectionViewCell.m
//  ArtPage
//
//  Created by 华杉科技 on 2018/10/3.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import "WorkGroupCollectionViewCell.h"

@implementation WorkGroupCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        _imgView = [[UIImageView alloc] init];
        _imgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_imgView];
        [_imgView makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
    }
    return self;
}

@end
