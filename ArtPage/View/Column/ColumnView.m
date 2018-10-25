//
//  ColumnView.m
//  ArtPage
//
//  Created by 华杉科技 on 2018/9/26.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import "ColumnView.h"

@implementation ColumnView

- (id)init
{
    if(self = [super init])
    {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor colorWithHexadecimal:0xa0a0a0];
        _titleLabel.font = [UIFont systemFontOfSize:15.0];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        [_titleLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(20);
            make.left.equalTo(0);
            make.size.equalTo(CGSizeMake(SCREENWIDTH, 45));
        }];
        
        _aTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 65, SCREENWIDTH, SCREENHEIGHT - 119) style:UITableViewStylePlain];
        _aTableView.backgroundColor = bgColor;
        [self addSubview:_aTableView];
        [_aTableView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.bottom).offset(0);
            make.left.equalTo(0);
            make.width.equalTo(SCREENWIDTH);
            make.height.equalTo(SCREENHEIGHT - 119);
        }];
        
    }
    return self;
}

@end
