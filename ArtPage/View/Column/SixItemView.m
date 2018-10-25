//
//  SixItemView.m
//  ArtPage
//
//  Created by 华杉科技 on 2018/9/26.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import "SixItemView.h"

@implementation SixItemView

- (id)initWithNormalArr:(NSArray *)normalArr andSelectArr:(NSArray *)selectArr
{
    if(self = [super init])
    {
        for(int i = 0; i < normalArr.count; i++)
        {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.layer.borderColor = [UIColor colorWithRed:140 green:140 blue:140].CGColor;
            btn.layer.borderWidth = 1.f;
            [btn setImage:UIImageFile(normalArr[i], @"png") forState:UIControlStateNormal];
            [btn setImage:UIImageFile(selectArr[i], @"png") forState:UIControlStateSelected];
            btn.tag = i;
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            [btn makeConstraints:^(MASConstraintMaker *make) {
                if(i < 3)
                {
                    make.top.equalTo(0);
                }
                else{
                    make.top.equalTo(87.5);
                }
                switch (i % 3) {
                    case 0:make.centerX.equalTo(self.centerX).offset(-81.5); break;
                    case 1:make.centerX.equalTo(self.centerX); break;
                    case 2:make.centerX.equalTo(self.centerX).offset(81.5); break;
                }
                make.size.equalTo(CGSizeMake(80, 80));
            }];
            
            switch (i) {
                case 0:{
                    if([getUD(@"publicWorkIsShow") isEqual:@"NO"])
                    {
                        btn.selected = YES;
                        btn.userInteractionEnabled = NO;
                    }
                } break;
                case 1:{
                    if([getUD(@"nonPublicWorkIsShow") isEqual:@"NO"])
                    {
                        btn.selected = YES;
                        btn.userInteractionEnabled = NO;
                    }
                } break;
                case 2:{
                    if([getUD(@"aboutIsShow") isEqual:@"NO"])
                    {
                        btn.selected = YES;
                        btn.userInteractionEnabled = NO;
                    }
                } break;
                case 3:{
                    if([getUD(@"newsIsShow") isEqual:@"NO"])
                    {
                        btn.selected = YES;
                        btn.userInteractionEnabled = NO;
                    }
                } break;
                case 5:{
                    if([getUD(@"语言") isEqual:@"英文"])
                    {
                        btn.selected = YES;
                    }
                } break;
            }
        }
    }
    return self;
}


- (id)initWithNormalArr:(NSArray *)normalArr
{
    if(self = [super init])
    {
        for(int i = 0; i < normalArr.count; i++)
        {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setImage:UIImageFile(normalArr[i], @"png") forState:UIControlStateNormal];
            btn.tag = i;
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            [btn makeConstraints:^(MASConstraintMaker *make) {
                if(i < 3)
                {
                    make.top.equalTo(0);
                }
                else{
                    make.top.equalTo(87.5);
                }
                switch (i % 3) {
                    case 0:make.centerX.equalTo(self.centerX).offset(-81.5); break;
                    case 1:make.centerX.equalTo(self.centerX); break;
                    case 2:make.centerX.equalTo(self.centerX).offset(81.5); break;
                }
                make.size.equalTo(CGSizeMake(80, 80));
            }];
        }
    }
    return self;
}


- (void)btnClick:(UIButton *)btn
{
    if(_columnBlock)
    {
        self.columnBlock(btn);
    }
}

@end
















