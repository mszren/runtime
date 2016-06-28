//
//  APISDK+Home.h
//  Common
//
//  Created by Owen on 15/5/23.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "NetConnection.h"

@interface HomeAPI : NetConnection
//获取兴趣群列表
+ (ASIHTTPRequest*)getGroupListV6:(NSString*)keyword sorttype:(NSString*)sorttype nextCursor:(NSInteger)nextCursor callback:(NetConnBlock)callback;
+ (ASIHTTPRequest*)getFamilyListNew:(NSInteger)userId nextCursor:(NSInteger)nextCursor callback:(NetConnBlock)callback;

//获得朋友圈信息
+ (ASIHTTPRequest*)getFriendsCircleNewBy:(NSInteger)userID nextCursor:(NSInteger)nextCursor callback:(NetConnBlock)callback;

+ (ASIHTTPRequest*)getNeighbourCircleInfoNew:(NSInteger)userID nextCursor:(NSInteger)nextCursor callback:(NetConnBlock)callback;

+ (ASIHTTPRequest*)priseLifeCircle:(NSInteger)user_id life_circle_id:(NSInteger)life_circle_id type:(NSInteger)type callback:(NetConnBlock)callback;

+ (ASIHTTPRequest*)getNewReplyCommentList:(NSInteger)comment_id flag:(NSInteger)flag nextCursor:(NSInteger)nextCursor callback:(NetConnBlock)callback;

+ (ASIHTTPRequest*)replyNewComment:(NSInteger)user_id Flag:(NSString*)Flag comment_id:(NSInteger)comment_id content:(NSString*)content
                          callback:(NetConnBlock)callback;

+ (ASIHTTPRequest*)getNewTalkList:(NSInteger)nextCursor
                         callback:(NetConnBlock)callback;

+ (ASIHTTPRequest*)praiseTalk:(NSInteger)talkId userId:(NSInteger)userId
                     callback:(NetConnBlock)callback;

+ (ASIHTTPRequest*)addLifeCircleInfo:(NSInteger)userId content:(NSString*)content life_type:(NSInteger)life_type imageUrl:(NSString*)imageUrl callback:(NetConnBlock)callback;

+ (ASIHTTPRequest*)insertTalk:(NSInteger)userId content:(NSString*)content imageUrl:(NSString*)imageUrl callback:(NetConnBlock)callback;

+ (ASIHTTPRequest*)ManagerRoomMember:(NSInteger)roomId roomname:(NSString*)roomname roomUserId:
(NSInteger )roomUserId status:(NSInteger)status callback:(NetConnBlock)callback;

+ (ASIHTTPRequest*)getNewGroupMemberList:(NSString *)name nextCursor:(NSInteger)nextCursor callback:(NetConnBlock)callback;

+ (ASIHTTPRequest*)GetAskMemberList:(NSInteger)roomId callback:(NetConnBlock)callback;

+ (ASIHTTPRequest*)AskForRoom:(NSInteger)roomId reason:(NSString*)reason userId:
(NSInteger)userId callback:(NetConnBlock)callback;

+ (ASIHTTPRequest*)getGroupInfoV6 :(NSString *)name callback:(NetConnBlock)callback;

+ (ASIHTTPRequest*)findFriendByPhone :(NSInteger )userId uid:(NSString *)uid state:(NSInteger)state callback:(NetConnBlock)callback;

+ (ASIHTTPRequest*)contactsCheckNew :(NSInteger )userId num:(NSString *)num  callback:(NetConnBlock)callback;
@end
