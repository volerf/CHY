//
//  SettingView.m
//  ArtPage
//
//  Created by 华杉科技 on 2018/9/28.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import "SettingView.h"
#import "UserObj.h"

@implementation SettingView

- (id)init
{
    if(self = [super init])
    {
        UILabel *line1 = [[UILabel alloc] init];
        line1.backgroundColor = [UIColor colorWithHexadecimal:0xa0a0a0];
        [self addSubview:line1];
        [line1 makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(90);
            make.left.equalTo(0);
            make.width.equalTo(SCREENWIDTH);
            make.height.equalTo(1);
        }];
        //获取当前用户信息
        UserObj *user = [[CHYDatabaseManager shareDataBaseManager] selectWithTableName:@"UserObj" andSelectCondition:@{@"UserID":getUD(@"UserID")}][0];
        //拼接用户个性域名
        NSString *domain = [NSString stringWithFormat:@"%@.artp.cc", user.ACCOUNT_DOMAIN];
        if([getUD(@"语言") isEqual:@"中文"])
        {
            //获取用户名的值
            NSString *userNameRight = [[CHYDatabaseManager shareDataBaseManager] selectWithColumn:@"ARTIST_NAME_CN" fromTable:@"AboutObj" whereCondition:@{@"UserID":getUD(@"UserID")}][0];
            //用户名
            _userName = [[LeftRightLabel alloc] initWithLeftText:@"当前用户：" andRightText:userNameRight];
            [self addSubview:_userName];
            [_userName makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(line1.bottom).offset(20);
                make.left.equalTo(0);
                make.size.equalTo(CGSizeMake(SCREENWIDTH, 30));
            }];

            //域名
            _domainName = [self setlrLabelWithLeftText:@"个性域名：" andRightText:domain andTopView:self.userName];

            //账户类型
            _userType = [self setlrLabelWithLeftText:@"账户类型：" andRightText:@"正式版" andTopView:self.domainName];

            //账户有效期
            _endDate = [self setlrLabelWithLeftText:@"账户有效期：" andRightText:user.endDate andTopView:self.userType];

            //上一次同步时间
            _updateDate = [self setlrLabelWithLeftText:@"上一次同步时间：" andRightText:user.lastSync andTopView:self.endDate];
        }
        else
        {
            NSString *userNameRight = [[CHYDatabaseManager shareDataBaseManager] selectWithColumn:@"ARTIST_NAME_EN" fromTable:@"AboutObj" whereCondition:@{@"UserID":getUD(@"UserID")}][0];
            //用户名
            _userName = [[LeftRightLabel alloc] initWithLeftText:@"USERNAME:" andRightText:userNameRight];
            [self addSubview:_userName];
            [_userName makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(line1.bottom).offset(20);
                make.left.equalTo(0);
                make.size.equalTo(CGSizeMake(SCREENWIDTH, 30));
            }];

            //域名
            _domainName = [self setlrLabelWithLeftText:@"DOMAIN:" andRightText:domain andTopView:self.userName];

            //账户类型
            _userType = [self setlrLabelWithLeftText:@"USERTYPE:" andRightText:@"final version" andTopView:self.domainName];

            //账户有效期
            _endDate = [self setlrLabelWithLeftText:@"ENDDATE:" andRightText:user.endDate andTopView:self.userType];

            //上一次同步时间
            _updateDate = [self setlrLabelWithLeftText:@"LAST SYNC:" andRightText:user.lastSync andTopView:self.endDate];
        }

        UILabel *line2 = [[UILabel alloc] init];
        line2.backgroundColor = [UIColor colorWithHexadecimal:0xa0a0a0];
        [self addSubview:line2];
        [line2 makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.updateDate.bottom).offset(20);
            make.left.equalTo(0);
            make.width.equalTo(SCREENWIDTH);
            make.height.equalTo(1);
        }];

        //添加六个按钮
        NSArray *norArr = @[@"btn_同步数据", @"btn_变更账户", @"btn_栏目设定", @"btn_访问网页版", @"!@#", @"btn_关于ArtPage"];
        _sixItem = [[SixItemView alloc] initWithNormalArr:norArr];
        [self addSubview:_sixItem];
        [_sixItem makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(-60);
            make.centerX.equalTo(self.centerX);
            make.size.equalTo(CGSizeMake(SCREENWIDTH, 175));
        }];
    }
    return self;
}

- (LeftRightLabel *)setlrLabelWithLeftText:(NSString *)leftText
                              andRightText:(NSString *)rightText
                                andTopView:(UIView *)topView
{
    LeftRightLabel *lr = [[LeftRightLabel alloc] initWithLeftText:leftText andRightText:rightText];
    [self addSubview:lr];
    [lr makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.bottom).offset(0);
        make.left.equalTo(0);
        make.size.equalTo(CGSizeMake(SCREENWIDTH, 30));
    }];
    [lr layoutIfNeeded];
    return lr;
}

@end


















