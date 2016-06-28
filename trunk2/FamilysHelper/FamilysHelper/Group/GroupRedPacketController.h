//
//  GroupRedPacketController.h
//  FamilysHelper
//
//  Created by 曹亮 on 15/4/10.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

@interface GroupRedPacketController : BaseViewController
{
    NSMutableArray * _dataList;
    ASIHTTPRequest * request;
}
@property(nonatomic, strong) UserMessageModel * currentGroupModel;


@end
