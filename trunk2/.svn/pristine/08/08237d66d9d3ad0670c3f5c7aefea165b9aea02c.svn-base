//
//  SQLServiceController.h
//  FamilyCircle
//
//  Created by chs_net on 13-10-9.
//  Copyright (c) 2013年 Ecpalm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LKDBHelper.h"

typedef void (^Completion)(BOOL obj);
@interface SQLServiceController : NSObject

@property (nonatomic,strong) LKDBHelper* globalHelper ;
+(SQLServiceController *)getInstance;
-(void)deleteAllTable;
-(void)creatTable;
-(BOOL)deleteFrome:(NSString *)tableName;
-(void)getFriendList:(Completion)completion;

#pragma mark --- 查询聊天消息多少未读数
-(int)searchChatListNumber;

#pragma mark -----查训最近的一条聊天CHATDB
-(NSMutableArray*)searchLastChat:(DJTChatInfo *)lastInfo;
-(NSMutableArray*)searchInfo:(DJTChatInfo *)lastInfo;


//SELECT * FROM [user] WHERE u_name LIKE '%三%' AND u_name LIKE '%猫%'
#pragma mark ---- 查询聊天记录
-(NSMutableArray*)searchRecordChat:(NSString *)lastInfo searchText:(NSString *)text;
#pragma mark ----插入数据
-(BOOL) insert :(DJTChatInfo*)insertList table:(NSString*)tableName;



#pragma mark -----查询数据(根据CHATLISTDB 中的uID)CHATDB
-(NSMutableArray*)getallDateOfUIDInChatDB:(NSString *)searchID :(int)start :(int)count;
-(NSMutableArray*)getPreviousChatRecordDB:(DJTChatInfo *)preInfo :(int)start :(int)count;
#pragma mark -----查询定位数据(根据CHATLISTDB 中的uID)CHATDB
-(NSMutableArray*)getallDateOfInChatDB:(DJTChatInfo *)search  start:(int)start count:(int)count  isUpDrag:(BOOL)drag;
-(NSMutableArray*)getdownDateOfInChatDB:(DJTChatInfo *)search  start:(int)start count:(int)count ;

#pragma mark -----查询聊天列表的所有数据
-(NSMutableArray*)getallDataChatList;
-(NSMutableArray*)getallDelXGJDataChatList;

#pragma mark ----置顶聊天列表的数据
-(BOOL) updataTop:(NSString*)toReceiver time:(int)time;
#pragma mark ----更新是否进行推送（单条聊天纪录）
-(BOOL) updataTokenPush:(NSString*)toReceiver isToken:(int)token chat:(BOOL)isChat;
#pragma mark -----更新数据
-(BOOL) update :(DJTChatInfo *)updateList tableName:(NSString *)tablename;
-(BOOL) updateGroupName:(DJTChatInfo *)updateList;
-(BOOL) updategroupNameReal:(DJTChatInfo *)updateList;

-(BOOL) searchGroupName:(DJTChatInfo*)updateList;

-(BOOL) updateMarkName:(User *)user;
-(BOOL) updataChatListContent:(NSString *)receiver;

#pragma mark ------更新未读变已读
-(BOOL) updateDontRend:(NSString *)receiver;
#pragma mark ------更新未读数量
-(BOOL) updateDontRendCount:(NSString *)receiver;
#pragma mark -----更新接受到的数据
-(BOOL) updateReceive:(DJTChatInfo *)updateList tableName:(NSString *)tablename;
#pragma mark ------更新Comment
-(BOOL)updateComment:(DJTChatInfo*)Comment datetimp:(int)datetimp userid:(NSString *)toUser;
#pragma mark ------更新状态
-(BOOL)updateStatus:(int)state datetimp:(NSString *)datetimp userid:(NSString *)toUser tableName:(NSString*)tableName;
-(NSMutableArray*)searchMessageID:(NSString *)searchID  userid:(NSString *)toUser tableName:(NSString *)tablename;
-(BOOL)updateStatus:(int)state time:(NSString *)time userid:(NSString *)toUser tableName:(NSString*)tableName;
#pragma mark ------更新视频URL
-(BOOL)updateVideoUrl:(NSString *)url datetimp:(int)datetimp userid:(NSString *)toUser;
#pragma mark ----更新一个人的好友关系
-(BOOL) updateFriend:(DJTChatInfo*)updateList table:(NSString*)tableName;
-(BOOL) updateLoseFriend:(DJTChatInfo *)updateList table:(NSString *)tableName;

#pragma mark ----更新添加相册关系
-(BOOL) updateAlbum:(DJTChatInfo*)updateList table:(NSString*)tableName;
#pragma mark ----更新音频是读取状态
-(BOOL) updateAudioRend:(DJTChatInfo *)updateList table:(NSString *)tableName;

-(BOOL) updateAudioRendCus:(DJTChatInfo *)updateList table:(NSString *)tableName;
#pragma mark ----更新一个群组的好友关系
-(BOOL) updateGroup:(NSString*)roomName;
-(BOOL) updateGroupFriend:(NSString*)roomName;


#pragma mark -----删除聊天列表的数据 ..key可以没有
-(BOOL) deleteChatListDB:(DJTChatInfo *)deleteList key:(NSString *)key;
#pragma mark  ----删除一条消息
- (BOOL)deleteOne:(DJTChatInfo *)message tableName:(NSString *) tableName thorougt:(bool)isThorough;
- (BOOL)deleteMessageTime:(DJTChatInfo *)timeInfo;
#pragma mark  ----删除一个人所有消息
- (BOOL)deleteAllChats:(NSString *)toUser thorougt:(bool)isThorough;
#pragma mark ------查看未读数量
-(int)selectDontRendCount:(NSString *)receiver;
#pragma mark -----查询用户列表
-(NSMutableArray*)getallDataUserList;
#pragma mark 查找用户信息
- (User *)getUserCommentName:(NSString *)tempUserName;
#pragma mark 查找用户信息ID
- (User *)getUserUid:(NSString *)tempUserUid;
#pragma mark 查找用户信息ID -userName
- (User *)getUserUserName:(NSString *)userName;
#pragma mark 添加一条用户信息
- (BOOL)insertUserInfo:(User *)tempUserInfo;


#pragma marl 修改用户的聊天背景
- (BOOL)updataUserImageBackground:(User *)user imageStr:(NSString *)imgS;
#pragma marl 修改群的聊天背景
- (BOOL)updataGroupImageBackground:(DJTChatInfo *)user imageStr:(NSString *)imgS;
#pragma mark 查找是否有此用户
- (BOOL)isHaveUser:(NSString *)userid;
#pragma mark 更新用户信息
- (BOOL)updataUserInfo:(User *)tempUserInfo;
#pragma mark 删掉这个用户
-(BOOL)deleteUserOtherInfo:(NSString *)userid username:(NSString *)username;
-(BOOL)deleteUserOtherInfo:(NSString *)userid username:(NSString *)username isDelRecord:(BOOL)flag;
@end
