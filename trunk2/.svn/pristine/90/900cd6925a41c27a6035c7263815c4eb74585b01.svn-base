//
//  MsgCommentModel.m
//  Common
//
//  Created by Owen on 15/5/27.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "MsgCommentModel.h"

@implementation MsgCommentModel
- (id)copyWithZone:(NSZone *)zone
{
    MsgCommentModel *copy = [[[self class] allocWithZone:zone] init];
    
    copy.commentId=self.commentId;
    copy.commentTime=[self.commentTime copy];
    copy.content=[self.content copy];
    copy.face=[self.face copy];
    
    copy.mid=self.mid;
    copy.nickName=[self.nickName copy];
    copy.pageSize=self.pageSize;
    copy.replyId=self.replyId;
    
    copy.status=self.status;
    copy.type=self.type;
    copy.userId=self.userId;
    copy.userName=[self.userName copy];
    return copy;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeInt64:self.commentId forKey:@"commentId"];
    [aCoder encodeObject:self.commentTime forKey:@"commentTime"];
    [aCoder encodeObject:self.content forKey:@"content"];
    [aCoder encodeObject:self.face forKey:@"face"];
    
    [aCoder encodeInt64:self.mid forKey:@"mid"];
    [aCoder encodeObject:self.nickName forKey:@"nickName"];
    [aCoder encodeInt64:self.pageSize forKey:@"pageSize"];
    [aCoder encodeInt64:self.replyId forKey:@"replyId"];
    
    [aCoder encodeInt64:self.status forKey:@"status"];
    [aCoder encodeInt64:self.type forKey:@"type"];
    [aCoder encodeInt64:self.userId forKey:@"userId"];
    [aCoder encodeObject:self.userName forKey:@"userName"];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        
        self.commentId=[aDecoder decodeIntegerForKey:@"commentId"];

        self.commentTime=[aDecoder decodeObjectForKey:@"commentTime"];

        self.content=[aDecoder decodeObjectForKey:@"content"];

        self.face=[aDecoder decodeObjectForKey:@"face"];

        
        self.mid=[aDecoder decodeIntegerForKey:@"mid"];

        self.nickName=[aDecoder decodeObjectForKey:@"nickName"];

        self.pageSize=[aDecoder decodeIntegerForKey:@"pageSize"];

        self.replyId=[aDecoder decodeIntegerForKey:@"replyId"];

        
        self.status=[aDecoder decodeIntegerForKey:@"status"];

        self.type=[aDecoder decodeIntegerForKey:@"type"];

        self.userId=[aDecoder decodeIntegerForKey:@"userId"];

        self.userName=[aDecoder decodeObjectForKey:@"userName"];

    }
    return self;
}

+ (MsgCommentModel *)JsonParse:(NSDictionary *)dic{
    MsgCommentModel * msg = [[MsgCommentModel alloc] init];
    
    msg.commentId=([dic objectForKey:@"commentId"] != [NSNull null])&&([dic objectForKey:@"commentId"] !=nil) ? [[dic objectForKey:@"commentId"] integerValue] : 0;
    
    NSDictionary *createtime=[dic objectForKey:@"commentTime"];
    NSString *time=[createtime objectForKey:@"time"];
    msg.commentTime=time;
    
    msg.content=([dic objectForKey:@"content"] != [NSNull null])&&([dic objectForKey:@"content"] !=nil) ? [dic objectForKey:@"content"] : @"";
    
    msg.face=([dic objectForKey:@"face"] != [NSNull null])&&([dic objectForKey:@"face"] !=nil) ? [dic objectForKey:@"face"] : @"";
    
    
    msg.mid=([dic objectForKey:@"mid"] != [NSNull null])&&([dic objectForKey:@"mid"] !=nil) ? [[dic objectForKey:@"mid"] integerValue] : 0;
    
    msg.nickName=([dic objectForKey:@"nickName"] != [NSNull null])&&([dic objectForKey:@"nickName"] !=nil) ? [dic objectForKey:@"nickName"] : @"";
    
    msg.pageSize=([dic objectForKey:@"pageSize"] != [NSNull null])&&([dic objectForKey:@"pageSize"] !=nil) ? [[dic objectForKey:@"pageSize"] integerValue] :0;
    
    msg.replyId=([dic objectForKey:@"replyId"] != [NSNull null])&&([dic objectForKey:@"replyId"] !=nil) ? [[dic objectForKey:@"replyId"] integerValue ]: 0;
    
    
    msg.status=([dic objectForKey:@"status"] != [NSNull null])&&([dic objectForKey:@"status"] !=nil) ? [[dic objectForKey:@"status"] integerValue] : 0;
    
    msg.type=([dic objectForKey:@"type"] != [NSNull null])&&([dic objectForKey:@"type"] !=nil) ? [[dic objectForKey:@"type"] integerValue] : 0;
    
    msg.userId=([dic objectForKey:@"userId"] != [NSNull null])&&([dic objectForKey:@"userId"] !=nil) ? [[dic objectForKey:@"userId"] integerValue] : 0;
    
    msg.userName=([dic objectForKey:@"userName"] != [NSNull null])&&([dic objectForKey:@"userName"] !=nil) ? [dic objectForKey:@"userName"] : @"";
    
    
    return msg;
}
@end
