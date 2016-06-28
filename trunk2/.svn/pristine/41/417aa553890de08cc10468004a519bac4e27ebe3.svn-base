//
//  ChatHomeCell.h
//  FamilysHelper
//
//  Created by 曹亮 on 15/3/17.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

@class BadgeView;
@class EGOImageView;
@class UserMessageModel;


@interface ChatHomeCell : UITableViewCell
{
    EGOImageView * headImg;
    
    UILabel * nickNameLab;
    UILabel * lastMessageContentLab;
    
    UILabel * timeLab;
    
    BadgeView * badgeView;
}

- (void) setViewDefault;
- (void) setViewData:(UserMessageModel *) aModel;

- (void) cancelAllBtnImageLoad;
- (void) loadHeadImg:(UserMessageModel *)userModel;

@end
