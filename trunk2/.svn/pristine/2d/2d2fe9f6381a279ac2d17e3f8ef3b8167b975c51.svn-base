//
//  HomeService.h
//  Common
//
//  Created by Owen on 15/5/23.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "BaseService.h"

@interface HomeService : BaseService

+ (instancetype)shareInstance;
- (ASIHTTPRequest*)getGroupListV6:(NSString*)keyword sorttype:(NSString*)sorttype nextCursor:(NSInteger)nextCursor onSuccess:(onSuccess)onSuccess;
- (ASIHTTPRequest*)getFamilyListNew:(NSInteger)userId nextCursor:(NSInteger)nextCursor onSuccess:(onSuccess)onSuccess;
- (ASIHTTPRequest*)getFriendsCircleNewBy:(NSInteger)userID nextCursor:(NSInteger)nextCursor onSuccess:(onSuccess)onSuccess;

- (ASIHTTPRequest*)getNeighbourCircleInfoNew:(NSInteger)userID nextCursor:(NSInteger)nextCursor onSuccess:(onSuccess)onSuccess;

- (ASIHTTPRequest*)priseLifeCircle:(NSInteger)user_id life_circle_id:(NSInteger)life_circle_id type:(NSInteger)type onSuccess:(onSuccess)onSuccess;

- (ASIHTTPRequest*)getNewReplyCommentList:(NSInteger)comment_id flag:(NSInteger)flag nextCursor:(NSInteger)nextCursor onSuccess:(onSuccess)onSuccess;

- (ASIHTTPRequest*)replyNewComment:(NSInteger)user_id Flag:(NSString*)Flag comment_id:(NSInteger)comment_id content:(NSString*)content
                         onSuccess:(onSuccess)onSuccess;

- (ASIHTTPRequest*)getNewTalkList:(NSInteger)nextCursor
                        onSuccess:(onSuccess)onSuccess;

- (ASIHTTPRequest*)addLifeCircleInfo:(NSInteger)userId content:(NSString*)content life_type:(NSInteger)life_type imageUrl:(NSString*)imageUrl onSuccess:(onSuccess)onSuccess;

- (ASIHTTPRequest*)insertTalk:(NSInteger)userId content:(NSString*)content imageUrl:(NSString*)imageUrl
    onSuccess:(onSuccess)onSuccess;

- (ASIHTTPRequest*)ManagerRoomMember:(NSInteger)roomId roomname:(NSString*)roomname roomUserId:
(NSInteger )roomUserId status:(NSInteger)status onSuccess:(onSuccess)onSuccess;

- (ASIHTTPRequest*)getNewGroupMemberList:(NSString *)name nextCursor:(NSInteger)nextCursor onSuccess:(onSuccess)onSuccess;

- (ASIHTTPRequest*)GetAskMemberList:(NSInteger)roomId onSuccess:(onSuccess)onSuccess;

- (ASIHTTPRequest*)AskForRoom:(NSInteger)roomId reason:(NSString*)reason userId:(NSInteger)userId onSuccess:(onSuccess)onSuccess;

- (ASIHTTPRequest*)getGroupInfoV6 :(NSString *)name onSuccess:(onSuccess)onSuccess;

- (ASIHTTPRequest*)findFriendByPhone :(NSInteger )userId uid:(NSString *)uid state:(NSInteger)state onSuccess:(onSuccess)onSuccess;

- (ASIHTTPRequest*)Addfriends:(NSInteger)userId nextCursor:(NSInteger)nextCursor onSuccess:(onSuccess)onSuccess;

- (ASIHTTPRequest*)contactsCheckNew :(NSInteger )userId num:(NSString *)num  onSuccess:(onSuccess)onSuccess;

@end
