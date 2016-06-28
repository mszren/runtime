//
//  TopicModel.m
//  Common
//
//  Created by Owen on 15/5/22.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "TopicModel.h"
#import "CommentModel.h"

@implementation TopicModel
- (id)copyWithZone:(NSZone *)zone
{
    TopicModel *copy = [[[self class] allocWithZone:zone] init];
    copy.operId = self.operId;
    copy.topic = [self.topic copy];
    copy.createTime = [self.createTime copy];
    copy.tagsColor = [self.tagsColor copy];
    copy.nickname = [self.nickname copy];
    copy.iconUrl = [self.iconUrl copy];
    copy.tagsName = [self.tagsName copy];
    
    copy.userAttentionNum = self.userAttentionNum;
    copy.hitNum = self.hitNum;
    copy.replyNum =self.replyNum;
    copy.rownum = self.rownum;
    copy.publishId = self.publishId;
    copy.shopName = [self.shopName copy];
    copy.shopId = self.shopId;
    copy.tagsId = self.tagsId;
    copy.typeId = self.typeId;
    copy.commentList=self.commentList;
    copy.contentInfo=[self.contentInfo copy];
    copy.face=[self.face copy];
    copy.images=[self.images copy];
    copy.userId=self.userId;
    copy.tribeld=self.tribeld;
    copy.tip=self.tip;
    copy.isEssence=self.isEssence;
    
    return copy;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeInt64:self.operId forKey:@"operId"];
    [aCoder encodeObject:self.topic forKey:@"topic"];
    [aCoder encodeObject:self.createTime forKey:@"createTime"];
    [aCoder encodeObject:self.tagsColor forKey:@"tagsColor"];
    
    [aCoder encodeObject:self.nickname forKey:@"nickname"];
    [aCoder encodeObject:self.iconUrl forKey:@"iconUrl"];
    [aCoder encodeObject:self.tagsName forKey:@"tagsName"];
    
    [aCoder encodeInt64:self.userAttentionNum forKey:@"userAttentionNum"];
    [aCoder encodeInt64:self.hitNum forKey:@"hitNum"];
    [aCoder encodeInt64:self.rownum forKey:@"rownum"];
    [aCoder encodeInt64:self.rownum forKey:@"replyNum"];
    [aCoder encodeInt64:self.publishId forKey:@"publishId"];
    [aCoder encodeObject:self.shopName forKey:@"shopName"];
    [aCoder encodeInt64:self.shopId forKey:@"shopId"];
    [aCoder encodeInt64:self.tagsId forKey:@"tagsId"];
    [aCoder encodeInt64:self.typeId forKey:@"typeId"];
    [aCoder encodeObject:self.commentList forKey:@"commentList"];
    [aCoder encodeInt64:self.userId forKey:@"userId"];
    [aCoder encodeInt64:self.tribeld forKey:@"tribeld"];
    [aCoder encodeInt64:self.tip forKey:@"tip"];
    [aCoder encodeInt64:self.isTop forKey:@"isTop"];
    [aCoder encodeInt64:self.isEssence forKey:@"isEssence"];
    [aCoder encodeObject:self.contentInfo forKey:@"contentInfo"];
    [aCoder encodeObject:self.face forKey:@"face"];
    [aCoder encodeObject:self.images forKey:@"images"];
    
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.operId = [aDecoder decodeIntegerForKey:@"operId"];
        self.topic = [aDecoder decodeObjectForKey:@"topic"];
        self.createTime = [aDecoder decodeObjectForKey:@"createTime"];
        self.tagsColor = [aDecoder decodeObjectForKey:@"tagsColor"];
        
        self.nickname = [aDecoder decodeObjectForKey:@"nickname"];
        self.iconUrl = [aDecoder decodeObjectForKey:@"iconUrl"];
        self.tagsName = [aDecoder decodeObjectForKey:@"tagsName"];
        
        self.userAttentionNum = [aDecoder decodeIntegerForKey:@"userAttentionNum"];
        self.hitNum = [aDecoder decodeIntegerForKey:@"hitNum"];
        self.rownum = [aDecoder decodeIntegerForKey:@"rownum"];
        
        self.replyNum = [aDecoder decodeIntegerForKey:@"replyNum"];
        self.publishId = [aDecoder decodeIntegerForKey:@"publishId"];
        self.shopName = [aDecoder decodeObjectForKey:@"shopName"];
        self.shopId = [aDecoder decodeIntegerForKey:@"shopId"];
        
        self.tagsId = [aDecoder decodeIntegerForKey:@"tagsId"];
        self.typeId = [aDecoder decodeIntegerForKey:@"typeId"];
        self.commentList=[aDecoder decodeObjectForKey:@"commentList"];
        self.contentInfo=[aDecoder decodeObjectForKey:@"contentInfo"];
        self.face=[aDecoder decodeObjectForKey:@"face"];
        self.images=[aDecoder decodeObjectForKey:@"images"];
        self.userId = [aDecoder decodeIntegerForKey:@"userId"];
        self.tribeld = [aDecoder decodeIntegerForKey:@"tribeld"];
        self.tip = [aDecoder decodeIntegerForKey:@"tip"];
        self.isEssence = [aDecoder decodeIntegerForKey:@"isEssence"];
        self.isTop = [aDecoder decodeIntegerForKey:@"isTop"];
        
        
    }
    return self;
}

+ (TopicModel *)JsonParse:(NSDictionary *)dic{
    TopicModel * topic = [[TopicModel alloc] init];
    
    topic.operId = ([dic objectForKey:@"operId"] != [NSNull null])&&([dic objectForKey:@"operId"] !=nil) ? [[dic objectForKey:@"operId"] integerValue] : 0;
    topic.topic = ([dic objectForKey:@"topic"] != [NSNull null])&&([dic objectForKey:@"topic"] !=nil) ? [dic objectForKey:@"topic"] : @"";
    NSDictionary *createtime=[dic objectForKey:@"createTime"];
    
    topic.createTime=([createtime objectForKey:@"time"] != [NSNull null])&&([createtime objectForKey:@"time"] !=nil) ?[createtime objectForKey:@"time"] : @"";
   
    topic.tagsColor = ([dic objectForKey:@"tagsColor"] != [NSNull null])&&([dic objectForKey:@"tagsColor"] !=nil) ? [dic objectForKey:@"tagsColor"] : @"";
    topic.nickname = ([dic objectForKey:@"nickname"] != [NSNull null])&&([dic objectForKey:@"nickname"] !=nil) ? [dic objectForKey:@"nickname"] : @"";
    topic.iconUrl = ([dic objectForKey:@"iconUrl"] != [NSNull null])&&([dic objectForKey:@"iconUrl"] !=nil) ? [dic objectForKey:@"iconUrl"] : @"";
    topic.tagsName = ([dic objectForKey:@"tagsName"] != [NSNull null])&&([dic objectForKey:@"tagsName"] !=nil) ? [dic objectForKey:@"tagsName"] : @"";
    
    topic.userAttentionNum = ([dic objectForKey:@"userAttentionNum"] != [NSNull null])&&([dic objectForKey:@"userAttentionNum"] !=nil) ? [[dic objectForKey:@"userAttentionNum"] integerValue] : 0;
    topic.hitNum = ([dic objectForKey:@"hitNum"] != [NSNull null])&&([dic objectForKey:@"hitNum"] !=nil) ? [[dic objectForKey:@"hitNum"] integerValue] : 0;
    topic.rownum = ([dic objectForKey:@"rownum"] != [NSNull null])&&([dic objectForKey:@"rownum"] !=nil) ? [[dic objectForKey:@"rownum"] integerValue] : 0;
    topic.replyNum = ([dic objectForKey:@"replyNum"] != [NSNull null])&&([dic objectForKey:@"replyNum"] !=nil) ? [[dic objectForKey:@"replyNum"] integerValue] : 0;
    topic.publishId = ([dic objectForKey:@"publishId"] != [NSNull null])&&([dic objectForKey:@"publishId"] !=nil) ? [[dic objectForKey:@"publishId"] integerValue] : 0;
    
    topic.shopName = ([dic objectForKey:@"shopName"] != [NSNull null])&&([dic objectForKey:@"shopName"] !=nil) ? [dic objectForKey:@"shopName"] : @"";
    
    topic.shopId = ([dic objectForKey:@"shopId"] != [NSNull null])&&([dic objectForKey:@"shopId"] !=nil) ? [[dic objectForKey:@"shopId"] integerValue] : 0;
    topic.tagsId = ([dic objectForKey:@"tagsId"] != [NSNull null])&&([dic objectForKey:@"tagsId"] !=nil) ? [[dic objectForKey:@"tagsId"] integerValue] : 0;
    topic.typeId = ([dic objectForKey:@"typeId"] != [NSNull null])&&([dic objectForKey:@"typeId"] !=nil) ? [[dic objectForKey:@"typeId"] integerValue] : 0;
    topic.isEssence = ([dic objectForKey:@"isEssence"] != [NSNull null])&&([dic objectForKey:@"isEssence"] !=nil) ? [[dic objectForKey:@"isEssence"] integerValue] : 0;
    topic.isTop = ([dic objectForKey:@"isTop"] != [NSNull null])&&([dic objectForKey:@"isTop"] !=nil) ? [[dic objectForKey:@"isTop"] integerValue] : 0;
    topic.tip = ([dic objectForKey:@"tip"] != [NSNull null])&&([dic objectForKey:@"tip"] !=nil) ? [[dic objectForKey:@"tip"] integerValue] : 0;
    topic.tribeld = ([dic objectForKey:@"tribeld"] != [NSNull null])&&([dic objectForKey:@"tribeld"] !=nil) ? [[dic objectForKey:@"tribeld"] integerValue] : 0;
    topic.userId = ([dic objectForKey:@"userId"] != [NSNull null])&&([dic objectForKey:@"userId"] !=nil) ? [[dic objectForKey:@"userId"] integerValue] : 0;
    topic.images = ([dic objectForKey:@"images"] != [NSNull null])&&([dic objectForKey:@"images"] !=nil) ? [dic objectForKey:@"images"] : @"";
    topic.face = ([dic objectForKey:@"face"] != [NSNull null])&&([dic objectForKey:@"face"] !=nil) ? [dic objectForKey:@"face"] : @"";
    topic.contentInfo = ([dic objectForKey:@"contentInfo"] != [NSNull null])&&([dic objectForKey:@"contentInfo"] !=nil) ? [dic objectForKey:@"contentInfo"] : @"";
    
    
    
    
    CGRect contentRect = [topic.contentInfo boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-70, CGFLOAT_MAX) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)  attributes:[NSDictionary dictionaryWithObject:FONT_SIZE_12 forKey:NSFontAttributeName] context:nil];
    
    if (contentRect.size.height<30) {
        topic.contentHeight=30;
    }
    else
        topic.contentHeight+=contentRect.size.height+10;
    
    if (![topic.iconUrl isEqualToString:@""]) {
        topic.imageHeight=244;
    }
    else
        topic.imageHeight=0;
    
    
    NSArray* arrComment=[dic objectForKey:@"commentList"];
    
    NSMutableArray *dataArray=[[NSMutableArray alloc] initWithCapacity:0];
    if (arrComment) {
        for(id data in arrComment){
            [dataArray addObject:[CommentModel JsonParse:data]];
        }
        topic.commentList=dataArray;
    }
    
    return topic;
}
@end
