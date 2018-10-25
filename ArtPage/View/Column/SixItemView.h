//
//  SixItemView.h
//  ArtPage
//
//  Created by 华杉科技 on 2018/9/26.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SixItemView : UIView

typedef void (^ColumnBlock)(UIButton *btn);
@property(nonatomic,copy) ColumnBlock columnBlock;

- (id)initWithNormalArr:(NSArray *)normalArr andSelectArr:(NSArray *)selectArr;

- (id)initWithNormalArr:(NSArray *)normalArr;

@end
