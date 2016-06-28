//
//  TribeService.h
//  Common
//
//  Created by Owen on 15/5/22.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "BaseService.h"

@interface TribeService : BaseService
+ (instancetype)shareInstance;

- (ASIHTTPRequest*)getTagsByTribeId:(NSInteger)tribeId
                          OnSuccess:(onSuccess)onSuccess;
- (ASIHTTPRequest*)getTagsInterByUserID:(NSInteger)userID
                              OnSuccess:(onSuccess)onSuccess;

- (ASIHTTPRequest*)publishTopicWith:(NSString*)title tribeId:(NSInteger)tribeId typeId:(NSInteger)typeId oper:(NSInteger)operId tag:(NSString*)tag images:(NSString*)images contentInfo:(NSString*)contentInfo
                          OnSuccess:(onSuccess)onSuccess;

- (ASIHTTPRequest*)rewardTopicby:(NSInteger)objectid type:(NSInteger) typeid userID:(NSInteger)userID
                          target:(NSInteger)targetID
                           prise:(NSInteger)prise
                       OnSuccess:(onSuccess)onSuccess;

- (ASIHTTPRequest*)getTagsInterby:(NSInteger)userID title:(NSString*)title nextCursor:(NSInteger)nextCursor OnSuccess:(onSuccess)onSuccess;

- (ASIHTTPRequest*)getTribeInfoBy:(NSInteger)shopID userID:(NSInteger)userID OnSuccess:(onSuccess)onSuccess;

- (ASIHTTPRequest*)getTribeInteBy:(NSInteger)shopID typeID:(NSInteger)typeID OnSuccess:(onSuccess)onSuccess;

- (ASIHTTPRequest*)getTribeGoodsBy:(NSInteger)shopID nexCurror:(NSInteger)nexCurror OnSuccess:(onSuccess)onSuccess;

- (ASIHTTPRequest*)getMoreTribeBy:(NSString*)title userID:(NSInteger)userID nexCurror:(NSInteger)nexCurror OnSuccess:(onSuccess)onSuccess;

- (ASIHTTPRequest*)getTribeTopicDetailBy:(NSInteger)topicID typeID:(NSInteger)typeID OnSuccess:(onSuccess)onSuccess;

- (ASIHTTPRequest*)getTribeTopicBy:(NSInteger)userID typeID:(NSInteger)typeID title:(NSString*)title nextCursor:(NSInteger)nextCursor OnSuccess:(onSuccess)onSuccess;

- (ASIHTTPRequest*)priseInterBy:(NSInteger)userID objecteId:(NSInteger)objecteId
                      OnSuccess:(onSuccess)onSuccess;

- (ASIHTTPRequest*)getTribeDiscussReplyListBy:(NSInteger)publishId typeId:(NSInteger)typeId type:(NSInteger)type nextCursor:(NSInteger)nextCursor
                                    OnSuccess:(onSuccess)onSuccess;

- (ASIHTTPRequest*)discussInterBy:(NSInteger)userId content:(NSString*)content hudongId:(NSInteger)hudongId tribeId:(NSInteger)tribeId typeId:(NSInteger)typeId images:(NSString*)images OnSuccess:(onSuccess)onSuccess;

- (ASIHTTPRequest*)replyDiscussBy:(NSInteger)userId content:(NSString*)content parentId:(NSInteger)parentId tribeId:(NSInteger)tribeId typeId:(NSInteger)typeId publishId:(NSInteger)publishId images:(NSString*)images OnSuccess:(onSuccess)onSuccess;

- (ASIHTTPRequest*)topTopicBy:(NSInteger)topicID OnSuccess:(onSuccess)onSuccess;

- (ASIHTTPRequest*)addUserAttentionTags:(NSInteger)userId tagsID:(NSInteger)tagsId OnSuccess:(onSuccess)onSuccess;

- (ASIHTTPRequest*)removeUserAttentionTags:(NSInteger)userId tagsID:(NSInteger)tagsId OnSuccess:(onSuccess)onSuccess;

- (ASIHTTPRequest*)addUserAttentionTribe:(NSInteger)userId tribeId:(NSInteger)tribeId OnSuccess:(onSuccess)onSuccess;

- (ASIHTTPRequest*)removeUserAttentionTribe:(NSInteger)userId tribeId:(NSInteger)tribeId OnSuccess:(onSuccess)onSuccess;

- (ASIHTTPRequest*)getTribeUserList:(NSInteger)tribeId nextCursor:(NSInteger)nextCursor OnSuccess:(onSuccess)onSuccess;

- (ASIHTTPRequest*)getAttentionTribeList:(NSInteger)userId shopname:(NSString*)shopname OnSuccess:(onSuccess)onSuccess;

- (ASIHTTPRequest*)getTribeInterActionByUserId:(NSInteger)userId typeId:(NSInteger)typeId title:(NSString*)title nextCursor:(NSInteger)nextCursor
                                     OnSuccess:(onSuccess)onSuccess;
- (ASIHTTPRequest*)getUserInfoV2:(NSInteger)userId OnSuccess:(onSuccess)onSuccess;

- (ASIHTTPRequest*)getBangActivityList:(NSInteger)shopId nextCursor:(NSInteger)nextCursor
                             OnSuccess:(onSuccess)onSuccess;
- (ASIHTTPRequest*)getBangActivityDetail:(NSInteger)activityId OnSuccess:(onSuccess)onSuccess;

- (ASIHTTPRequest*)addMyCollect:(NSInteger)userId type:(NSInteger)type
                       objectId:(NSInteger)objectId
                      OnSuccess:(onSuccess)onSuccess;

- (ASIHTTPRequest*)joinBangActivity:(NSInteger)userId activityId:(NSInteger)activityId OnSuccess:(onSuccess)onSuccess;

- (ASIHTTPRequest*)getJoinMoreList:(NSInteger)activityId OnSuccess:(onSuccess)onSuccess;

- (ASIHTTPRequest*)getActivityReplyList:(NSInteger)activityId nextCursor:(NSInteger)nextCursor OnSuccess:(onSuccess)onSuccess;

- (ASIHTTPRequest*)priseActivityReply:(NSInteger)userId objectId:(NSInteger)objectId OnSuccess:(onSuccess)onSuccess;

- (ASIHTTPRequest*)commentActivityReply:(NSInteger)userId replyId:(NSInteger)replyId content:(NSString*)content OnSuccess:(onSuccess)onSuccess;
- (ASIHTTPRequest*)addInformAgainst:(NSInteger)userId objectId:(NSInteger)objectId content:(NSString*)content objectType:(NSInteger)objectType triberId:(NSInteger)triberId OnSuccess:(onSuccess)onSuccess;

- (ASIHTTPRequest*)getSignInfoA:(NSInteger)userId tribeId:(NSInteger)tribeId OnSuccess:(onSuccess)onSuccess;

- (ASIHTTPRequest*)bangSignIn:(NSInteger)userId tribeId:(NSInteger)tribeId OnSuccess:(onSuccess)onSuccess;

- (ASIHTTPRequest*)getSignInfoB:(NSInteger)userId tribeId:(NSInteger)tribeId nextCursor:(NSInteger)nextCursor OnSuccess:(onSuccess)onSuccess;
- (ASIHTTPRequest*)publishActivityReply:(NSInteger)user_id reply_content:(NSString*)reply_content activity_id:(NSInteger)activity_id images:(NSString*)images OnSuccess:(onSuccess)onSuccess;
@end
