//
//  GroupsCell.h
//  FamilysHelper
//
//  Created by 曹亮 on 15/3/17.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

@class EGOImageView;
@class GroupModel;
@class BadgeView;

@interface GroupsCell : UITableViewCell
{
    EGOImageView * headImg;
    
    UILabel * nickNameLab;
    UILabel * lastMessageContentLab;
    
    BadgeView * badgeView;
    UILabel * redPacketLab;
}

- (void)setViewDefault;
- (void)setViewData:(GroupModel *) aModel;

- (void) cancelAllBtnImageLoad;
- (void) loadHeadImg:(GroupModel *)userModel;

@end