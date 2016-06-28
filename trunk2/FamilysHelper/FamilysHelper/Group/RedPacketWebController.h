//
//  RedPacketWebController.h
//  FamilysHelper
//
//  Created by 曹亮 on 15/4/13.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "RedPacketModel.h"

@interface RedPacketWebController : BaseViewController<UIWebViewDelegate>{
    UIWebView * webView;
}
@property (nonatomic,strong) RedPacketModel * currentRedPacketModel;

@property (nonatomic,strong) NSString * groupName;

@end
