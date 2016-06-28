//
//  UserMessageModel.h
//  Common
//
//  Created by 曹亮 on 15/3/17.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

@class User;
@class GroupModel;
@class MessageInfoModel;

@interface UserMessageModel : NSObject <NSCoding>{
    
}
@property(nonatomic,assign) NSUInteger userMessageId;
@property(nonatomic,strong) NSString * name;
@property(nonatomic,strong) NSString * nick;
@property(nonatomic,strong) NSString * room_nick;
@property(nonatomic,strong) NSString * face;
@property(nonatomic,strong) NSString * content;
@property(nonatomic,strong) NSString * time;
@property(nonatomic,strong) NSString * num;
@property(nonatomic,assign) CHAT_TYPE type;
@property(nonatomic,assign) CHAT_INFO_TYPE msg_type;

@property(nonatomic,strong) NSString * msg_bg;
@property(nonatomic,strong) NSString * is_failure;
@property(nonatomic,strong) NSString * is_exit;
@property(nonatomic,strong) NSString * is_remind;
@property(nonatomic,strong) NSString * is_friends;
@property(nonatomic,strong) NSString * creator;
@property(nonatomic,strong) NSString * position;

+ (UserMessageModel *)JsonParse:(NSDictionary *)dic;

+ (UserMessageModel *)parseWithMessageInfoModel:(MessageInfoModel *)messageInfoModel;
+ (UserMessageModel *)parseWithGroupModel:(GroupModel *) groupModel;

- (User *) changeToUser;

@end