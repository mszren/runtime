//
//  GroupRedPacketCell.h
//  FamilysHelper
//
//  Created by 曹亮 on 15/4/11.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

@class EGOImageView;
@class RedPacketModel;
@class BadgeView;

@interface GroupRedPacketCell : UITableViewCell
{
    EGOImageView * headImg;
    
    UILabel * nickNameLab;
    UILabel * lastMessageContentLab;
    
    UILabel * _statusLab;
    
    RedPacketModel * _currentRedPacketModel;
}

- (void)setViewDefault;
- (void)setViewData:(RedPacketModel *) aModel;


@end
