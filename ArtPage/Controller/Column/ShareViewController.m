//
//  ShareViewController.m
//  ArtPage
//
//  Created by 华杉科技 on 2018/9/26.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import "ShareViewController.h"
#import "WXApi.h"
#import "WeiboSDK.h"

@interface ShareViewController ()

@end

@implementation ShareViewController

- (void)viewDidLoad {
    super.isAButton = YES;
    [super viewDidLoad];
    
    //设置父类相关属性
    [self.centerBtn setImage:[UIImage imageNamed:@"btn_关闭"] forState:UIControlStateNormal];
    [self.centerBtn addTarget:self action:@selector(backColumn) forControlEvents:UIControlEventTouchUpInside];
    
    //初始化视图
    [self initThatView];
    
    //实现六按钮视图的block完成点击事件
    __weak typeof(self) weakSelf = self;
    self.sixView.columnBlock = ^(UIButton *btn) {
        switch (btn.tag) {
            case 0:{
                //点击复制链接
                UIPasteboard *pasted = [UIPasteboard generalPasteboard];
                pasted.string = weakSelf.shareUrl;
                UIAlertController *alert = [UIAlertController alertCancelWithTitle:@"链接复制完成" andMessage:weakSelf.shareUrl andCancelInfo:@"确定"];
                [weakSelf presentViewController:alert animated:YES completion:nil];
            } break;
            case 1:{
                //这种分享是带文字和图片的分享，属于网页分享，注意分享的图片大小不能超过32k。
                WXMediaMessage *message = [WXMediaMessage message];
                message.title = @"ArtPage";
                message.description = @"分享给你一个好东西";
                [message setThumbImage:UIImageFile(@"share", @"png")];
                
                WXWebpageObject *ext = [WXWebpageObject object];
                ext.webpageUrl = weakSelf.shareUrl;
                message.mediaObject = ext;
                
                SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
                req.bText = NO;
                req.message = message;
                //这个属性表示分享到好友
                req.scene = WXSceneSession;
                [WXApi sendReq:req];
                
                //这种分享的是纯文字的信息。
                //            SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
                //            req.text = @"http://www.huashankeji.com";
                //            req.bText = YES;
                //            req.scene = WXSceneSession;
                //            [WXApi sendReq:req];
            } break;
            case 2:{
                WXMediaMessage *message = [WXMediaMessage message];
                message.title = @"ArtPage";
                message.description = @"分享给你一个好东西";
                [message setThumbImage:UIImageFile(@"share", @"png")];
                
                WXWebpageObject *ext = [WXWebpageObject object];
                ext.webpageUrl = weakSelf.shareUrl;
                message.mediaObject = ext;
                
                SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
                req.bText = NO;
                req.message = message;
                //这个属性表示分享到朋友圈
                req.scene = WXSceneTimeline;
                [WXApi sendReq:req];
                
            } break;
            case 3:
            {
                WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
                
                WBMessageObject *message = [WBMessageObject message];
                
                WBWebpageObject *webpage = [WBWebpageObject object];
                webpage.objectID = @"identifier1";
                webpage.title = @"ArtPage";
                webpage.description = @"分享一个好东西";
                //切记分享的图片大小不能超过32k，否则分享不成功。
                webpage.thumbnailData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"share" ofType:@"png"]];
                webpage.webpageUrl = weakSelf.shareUrl;
                message.mediaObject = webpage;
                
                WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message authInfo:authRequest access_token:nil];
                [WeiboSDK sendRequest:request];
            }
        }
    };
    
}

//初始化视图
- (void)initThatView
{
    //添加六个按钮
    NSArray *norArr = @[@"btn_复制链接", @"btn_微信好友", @"btn_朋友圈", @"btn_新浪微博", @"btn_信息", @"btn_邮件"];
    _sixView = [[SixItemView alloc] initWithNormalArr:norArr];
    [self.view addSubview:_sixView];
    [_sixView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(-100);
        make.centerX.equalTo(self.view.centerX);
        make.size.equalTo(CGSizeMake(SCREENWIDTH, 175));
    }];
    //下线
    UILabel *lineBot = [[UILabel alloc] init];
    lineBot.backgroundColor = [UIColor colorWithHexadecimal:0x626262];
    [self.view addSubview:lineBot];
    [lineBot makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.sixView.top).offset(-25);
        make.centerX.equalTo(self.view.centerX);
        make.size.equalTo(CGSizeMake(SCREENWIDTH, 1));
    }];
    
    //分享de链接
    _urlLabel = [[UILabel alloc] init];
    _urlLabel.font = [UIFont systemFontOfSize:14.0];
    _urlLabel.text = _shareUrl;
    _urlLabel.textColor = [UIColor colorWithHexadecimal:0x626262];
    _urlLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_urlLabel];
    [_urlLabel makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineBot.top).offset(0);
        make.centerX.equalTo(self.view.centerX);
        make.size.equalTo(CGSizeMake(SCREENWIDTH, 54));
    }];
    
    //上线
    UILabel *lineTop = [[UILabel alloc] init];
    lineTop.backgroundColor = [UIColor colorWithHexadecimal:0x626262];
    [self.view addSubview:lineTop];
    [lineTop makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.urlLabel.top).offset(0);
        make.centerX.equalTo(self.view.centerX);
        make.size.equalTo(CGSizeMake(SCREENWIDTH, 1));
    }];
    
    //分享链接
    _shareLabel = [[UILabel alloc] init];
    _shareLabel.font = [UIFont systemFontOfSize:15.0];
    _shareLabel.textAlignment = NSTextAlignmentCenter;
    _shareLabel.textColor = [UIColor colorWithHexadecimal:0xa0a0a0];
    if([getUD(@"语言") isEqual:@"中文"])
    {
        _shareLabel.text = @"分享链接";
    }
    else{
        _shareLabel.text = @"Share link";
    }
    [self.view addSubview:_shareLabel];
    [_shareLabel makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineTop.top).offset(-25);
        make.centerX.equalTo(self.view.centerX);
        make.size.equalTo(CGSizeMake(SCREENWIDTH, 15));
    }];
}

//返回栏目页面
- (void)backColumn
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
