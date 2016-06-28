//
//  APISDK+BangBang.h
//  Common
//
//  Created by Owen on 15/5/22.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "NetConnection.h"

@interface BangBangAPI : NetConnection
+ (ASIHTTPRequest*)getTagsByTribeId:(NSInteger)tribeId callback:(NetConnBlock)callback;

+ (ASIHTTPRequest*)getTagsByUserId:(NSInteger)userid callback:(NetConnBlock)callback;

+ (ASIHTTPRequest*)publishTopicWith:(NSString*)topic tribeId:(NSInteger)tribeId type:(NSInteger)type oper:(NSInteger)oper tag:(NSString*)tag images:(NSString*)images contentInfo:(NSString*)contentinfo callback:(NetConnBlock)callback;

+ (ASIHTTPRequest*)rewardTopicby:(NSInteger)objectid type:(NSInteger) typeid userID:(NSInteger)userID
                          target:(NSInteger)targetID
                           prise:(NSInteger)prise
                        callback:(NetConnBlock)callback;

+ (ASIHTTPRequest*)getTagsInterby:(NSInteger)userID title:(NSString*)title nextCursor:(NSInteger)nextCursor callback:(NetConnBlock)callback;

+ (ASIHTTPRequest*)getTribeInfoBy:(NSInteger)shopID userID:(NSInteger)userID callback:(NetConnBlock)callback;

+ (ASIHTTPRequest*)getTribeInteBy:(NSInteger)shopID typeID:(NSInteger)typeID callback:(NetConnBlock)callback;

+ (ASIHTTPRequest*)getTribeGoodsBy:(NSInteger)shopID nexCurror:(NSInteger)nexCurror callback:(NetConnBlock)callback;

+ (ASIHTTPRequest*)getMoreTribeBy:(NSString*)title userID:(NSInteger)userID nexCurror:(NSInteger)nexCurror callback:(NetConnBlock)callback;

+ (ASIHTTPRequest*)getTribeTopicDetailBy:(NSInteger)topicID typeID:(NSInteger)typeID callback:(NetConnBlock)callback;

+ (ASIHTTPRequest*)getTribeTopicBy:(NSInteger)userID typeID:(NSInteger)typeID title:(NSString*)title nextCursor:(NSInteger)nextCursor callback:(NetConnBlock)callback;

+ (ASIHTTPRequest*)priseInterBy:(NSInteger)userID objecteId:(NSInteger)objecteId
                       callback:(NetConnBlock)callback;

+ (ASIHTTPRequest*)getTribeDiscussReplyListBy:(NSInteger)publishId typeId:(NSInteger)typeId type:(NSInteger)type nextCursor:(NSInteger)nextCursor
                                     callback:(NetConnBlock)callback;

+ (ASIHTTPRequest*)discussInterBy:(NSInteger)userId content:(NSString*)content hudongId:(NSInteger)hudongId tribeId:(NSInteger)tribeId typeId:(NSInteger)typeId images:(NSString*)images callback:(NetConnBlock)callback;

+ (ASIHTTPRequest*)replyDiscussBy:(NSInteger)userId content:(NSString*)content parentId:(NSInteger)parentId tribeId:(NSInteger)tribeId typeId:(NSInteger)typeId publishId:(NSInteger)publishId images:(NSString*)images callback:(NetConnBlock)callback;

+ (ASIHTTPRequest*)topTopicBy:(NSInteger)topicID callback:(NetConnBlock)callback;

+ (ASIHTTPRequest*)addUserAttentionTags:(NSInteger)userId tagsID:(NSInteger)tagsId callback:(NetConnBlock)callback;

+ (ASIHTTPRequest*)removeUserAttentionTags:(NSInteger)userId tagsID:(NSInteger)tagsId callback:(NetConnBlock)callback;

+ (ASIHTTPRequest*)addUserAttentionTribe:(NSInteger)userId tribeId:(NSInteger)tribeId callback:(NetConnBlock)callback;

+ (ASIHTTPRequest*)removeUserAttentionTribe:(NSInteger)userId tribeId:(NSInteger)tribeId callback:(NetConnBlock)callback;

+ (ASIHTTPRequest*)getTribeUserList:(NSInteger)tribeId nextCursor:(NSInteger)nextCursor callback:(NetConnBlock)callback;

+ (ASIHTTPRequest*)getAttentionTribeList:(NSInteger)userId shopname:(NSString*)shopname callback:(NetConnBlock)callback;

+ (ASIHTTPRequest*)getTribeInterActionByUserId:(NSInteger)userId typeId:(NSInteger)typeId
                                         title:(NSString*)title
                                    nextCursor:(NSInteger)nextCursor
                                      callback:(NetConnBlock)callback;

+ (ASIHTTPRequest*)getUserInfoV2:(NSInteger)userId callback:(NetConnBlock)callback;

+ (ASIHTTPRequest*)getBangActivityList:(NSInteger)shopId nextCursor:(NSInteger)nextCursor
                              callback:(NetConnBlock)callback;

+ (ASIHTTPRequest*)getBangActivityDetail:(NSInteger)activityId callback:(NetConnBlock)callback;

+ (ASIHTTPRequest*)addMyCollect:(NSInteger)userId type:(NSInteger)type
                       objectId:(NSInteger)objectId
                       callback:(NetConnBlock)callback;

+ (ASIHTTPRequest*)joinBangActivity:(NSInteger)userId activityId:(NSInteger)activityId callback:(NetConnBlock)callback;

+ (ASIHTTPRequest*)getJoinMoreList:(NSInteger)activityId callback:(NetConnBlock)callback;

+ (ASIHTTPRequest*)getActivityReplyList:(NSInteger)activityId nextCursor:(NSInteger)nextCursor callback:(NetConnBlock)callback;

+ (ASIHTTPRequest*)priseActivityReply:(NSInteger)userId objectId:(NSInteger)objectId callback:(NetConnBlock)callback;

+ (ASIHTTPRequest*)commentActivityReply:(NSInteger)userId replyId:(NSInteger)replyId content:(NSString*)content callback:(NetConnBlock)callback;

+ (ASIHTTPRequest*)addInformAgainst:(NSInteger)userId objectId:(NSInteger)objectId content:(NSString*)content objectType:(NSInteger)objectType triberId:(NSInteger)triberId callback:(NetConnBlock)callback;
+ (ASIHTTPRequest*)getSignInfoA:(NSInteger)userId tribeId:(NSInteger)tribeId callback:(NetConnBlock)callback;
+ (ASIHTTPRequest*)getSignInfoB:(NSInteger)userId tribeId:(NSInteger)tribeId nextCursor:(NSInteger)nextCursor callback:(NetConnBlock)callback;
+ (ASIHTTPRequest*)bangSignIn:(NSInteger)userId tribeId:(NSInteger)tribeId callback:(NetConnBlock)callback;
+ (ASIHTTPRequest*)publishActivityReply:(NSInteger)user_id reply_content:(NSString*)reply_content activity_id:(NSInteger)activity_id images:(NSString*)images callback:(NetConnBlock)callback;
@end
