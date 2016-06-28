//
//  MsgModel.m
//  Common
//
//  Created by Owen on 15/5/23.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "MsgModel.h"
#import "ImgModel.h"

@implementation MsgModel

- (id)copyWithZone:(NSZone *)zone
{
    MsgModel *copy = [[[self class] allocWithZone:zone] init];
    
    copy.cityId = self.cityId;
    copy.cityName = [self.cityName copy];
    copy.commentNum = self.commentNum;
    copy.communityId = self.communityId;
    copy.communityName = [self.communityName copy];
    copy.content = [self.content copy];
    copy.createTime = [self.createTime copy];
    copy.face = [self.face copy];
    copy.hotNum = self.hotNum;
    copy.lifeCircleId = self.lifeCircleId;
    copy.lifeType = self.lifeType;
    copy.likeNum =self.likeNum;
    copy.imgList = [self.imgList copy];
    copy.mid = self.mid;
    copy.nickname = self.nickname;
    copy.pageSize =self.pageSize;
    
    copy.phone =[self.phone copy];
    copy.poiId = self.poiId;
    copy.replyCommentNumber = self.replyCommentNumber;
    copy.smallimageurl =[self.smallimageurl copy];
    
    copy.status = self.status;
    copy.title = [self.title copy];
    copy.type =self.type;
    copy.userId =self.userId;
    copy.cellHeight=self.cellHeight;
    copy.sumPrise = self.sumPrise;
    return copy;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    

    [aCoder encodeInt64:self.cityId forKey:@"cityId"];
    [aCoder encodeObject:self.cityName forKey:@"cityName"];
    [aCoder encodeInt64:self.commentNum forKey:@"commentNum"];
    
    [aCoder encodeObject:self.communityName forKey:@"communityName"];
    [aCoder encodeObject:self.content forKey:@"content"];
    [aCoder encodeObject:self.createTime forKey:@"createTime"];
    
    [aCoder encodeObject:self.face forKey:@"face"];
    [aCoder encodeInt64:self.hotNum forKey:@"hotNum"];
    [aCoder encodeInt64:self.lifeCircleId forKey:@"lifeCircleId"];
    
    [aCoder encodeInt64:self.lifeType forKey:@"lifeType"];
    [aCoder encodeInt64:self.likeNum forKey:@"likeNum"];
    [aCoder encodeObject:self.imgList forKey:@"imgList"];
    [aCoder encodeInt64:self.mid forKey:@"mid"];
    [aCoder encodeObject:self.nickname forKey:@"nickname"];
    [aCoder encodeInt64:self.pageSize forKey:@"pageSize"];
    [aCoder encodeObject:self.phone forKey:@"phone"];
    [aCoder encodeInt64:self.poiId forKey:@"poiId"];
    
    [aCoder encodeInt64:self.replyCommentNumber forKey:@"replyCommentNumber"];
    [aCoder encodeObject:self.smallimageurl forKey:@"smallimageurl"];
    
    [aCoder encodeInt64:self.status forKey:@"status"];
    [aCoder encodeObject:self.title forKey:@"title"];
    
    [aCoder encodeInt64:self.type forKey:@"type"];
    [aCoder encodeInt64:self.userId forKey:@"userId"];
    [aCoder encodeInt64:self.cellHeight forKey:@"cellHeight"];
    [aCoder encodeInteger:self.sumPrise forKey:@"sumPrise"];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        
        self.cityId = [aDecoder decodeIntegerForKey:@"cityId"];
        self.cityName = [aDecoder decodeObjectForKey:@"cityName"];
        self.commentNum = [aDecoder decodeIntegerForKey:@"commentNum"];
        self.communityId = [aDecoder decodeIntegerForKey:@"communityId"];
        self.communityName = [aDecoder decodeObjectForKey:@"communityName"];
        self.content = [aDecoder decodeObjectForKey:@"content"];
        self.createTime = [aDecoder decodeObjectForKey:@"createTime"];
        self.face = [aDecoder decodeObjectForKey:@"face"];
        self.hotNum = [aDecoder decodeIntegerForKey:@"hotNum"];
        self.lifeCircleId = [aDecoder decodeIntegerForKey:@"lifeCircleId"];
        self.lifeType = [aDecoder decodeIntegerForKey:@"lifeType"];
        self.likeNum = [aDecoder decodeIntegerForKey:@"likeNum"];
        self.cityId = [aDecoder decodeIntegerForKey:@"cityId"];
        self.imgList = [aDecoder decodeObjectForKey:@"imgList"];
        self.mid = [aDecoder decodeIntegerForKey:@"mid"];
        self.nickname = [aDecoder decodeObjectForKey:@"nickname"];
        self.pageSize = [aDecoder decodeIntegerForKey:@"pageSize"];
        
        self.phone = [aDecoder decodeObjectForKey:@"phone"];
        self.poiId = [aDecoder decodeIntegerForKey:@"poiId"];
        self.replyCommentNumber = [aDecoder decodeIntegerForKey:@"replyCommentNumber"];
        self.smallimageurl = [aDecoder decodeObjectForKey:@"smallimageurl"];
        
        self.status = [aDecoder decodeIntegerForKey:@"status"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.type = [aDecoder decodeIntegerForKey:@"type"];
        self.userId = [aDecoder decodeIntegerForKey:@"userId"];
        self.cellHeight=[aDecoder decodeIntegerForKey:@"cellHeight"];
        self.sumPrise = [aDecoder decodeIntegerForKey:@"sumPrise"];
    }
    return self;
}
/*
 
 hitNu  点赞数
 image 发布的图片
 messageInfo  发布的内容
 talkId  信息ID
 userLogo  发布人头像
 username  发布人用户名
 */
+ (MsgModel *)JsonParse:(NSDictionary *)dic{
    MsgModel * msg = [[MsgModel alloc] init];
        msg.sumPrise = ([dic objectForKey:@"sumPrise"] != [NSNull null])&&([dic objectForKey:@"sumPrise"] !=nil) ? [[dic objectForKey:@"sumPrise"] integerValue] : 0;
    
    msg.cityId = ([dic objectForKey:@"cityId"] != [NSNull null])&&([dic objectForKey:@"cityId"] !=nil) ? [[dic objectForKey:@"cityId"] integerValue] : 0;
    msg.cityName = ([dic objectForKey:@"cityName"] != [NSNull null])&&([dic objectForKey:@"cityName"] !=nil) ? [dic objectForKey:@"cityName"] : @"";
    msg.commentNum = ([dic objectForKey:@"commentNum"] != [NSNull null])&&([dic objectForKey:@"commentNum"] !=nil) ? [[dic objectForKey:@"commentNum"] integerValue] : 0;
    
    msg.communityId = ([dic objectForKey:@"communityId"] != [NSNull null])&&([dic objectForKey:@"communityId"] !=nil) ? [[dic objectForKey:@"communityId"] integerValue] : 0;
    
    msg.communityName = ([dic objectForKey:@"communityName"] != [NSNull null])&&([dic objectForKey:@"communityName"] !=nil) ? [dic objectForKey:@"communityName"] : @"";
    
    NSString* messageInfo = ([dic objectForKey:@"messageInfo"] != [NSNull null])&&([dic objectForKey:@"messageInfo"] !=nil) ? [dic objectForKey:@"messageInfo"] : @"";
    
   NSString* content = ([dic objectForKey:@"content"] != [NSNull null])&&([dic objectForKey:@"content"] !=nil) ? [dic objectForKey:@"content"] : @"";
    if (![messageInfo isEqual:@""]) {
        msg.content=messageInfo;
    }else if(![content isEqual:@""]){
        msg.content=content;
    }else {
        msg.content=@"";
    }

    NSDictionary *createtime=[dic objectForKey:@"createTime"];
    NSString *time=[createtime objectForKey:@"time"];
    msg.createTime = time;
    NSString * userLogo = ([dic objectForKey:@"userLogo"] != [NSNull null])&&([dic objectForKey:@"userLogo"] !=nil) ? [dic objectForKey:@"userLogo"] : @"";
    NSString * face = ([dic objectForKey:@"face"] != [NSNull null])&&([dic objectForKey:@"face"] !=nil) ? [dic objectForKey:@"face"] : @"";
    if (![userLogo isEqual:@""]) {
        msg.face=userLogo;
    }else if(![face isEqual:@""]){
        msg.face=face;
    }else {
        msg.face=@"";
    }
    
    
    NSInteger hitNu = ([dic objectForKey:@"hitNu"] != [NSNull null])&&([dic objectForKey:@"hitNu"] !=nil) ? [[dic objectForKey:@"hitNu"] integerValue] : 0;
    NSInteger hotNum = ([dic objectForKey:@"hotNum"] != [NSNull null])&&([dic objectForKey:@"hotNum"] !=nil) ? [[dic objectForKey:@"hotNum"] integerValue] : 0;
    if (hotNum!=0) {
        msg.hotNum=hotNum;
    }else if(hitNu!=0){
      msg.hotNum=hitNu;
    }else {
        msg.hotNum=0;
    }
    NSInteger talkId = ([dic objectForKey:@"talkId"] != [NSNull null])&&([dic objectForKey:@"talkId"] !=nil) ? [[dic objectForKey:@"talkId"] integerValue] : 0;
    NSInteger lifeCircleId = ([dic objectForKey:@"lifeCircleId"] != [NSNull null])&&([dic objectForKey:@"lifeCircleId"] !=nil) ? [[dic objectForKey:@"lifeCircleId"] integerValue] : 0;
    if (talkId!=0) {
        msg.lifeCircleId=talkId;
    }else if(lifeCircleId!=0){
        msg.lifeCircleId=lifeCircleId;
    }else {
        msg.lifeCircleId=0;
    }
    msg.lifeType = ([dic objectForKey:@"lifeType"] != [NSNull null])&&([dic objectForKey:@"lifeType"] !=nil) ? [[dic objectForKey:@"lifeType"] integerValue] : 0;
                         
    msg.likeNum =([dic objectForKey:@"likeNum"] != [NSNull null])&&([dic objectForKey:@"likeNum"] !=nil) ? [[dic objectForKey:@"likeNum"] integerValue]: 0;
    
                         
    msg.mid = ([dic objectForKey:@"mid"] != [NSNull null])&&([dic objectForKey:@"mid"] !=nil) ? [[dic objectForKey:@"mid"] integerValue] : 0;
                         
    msg.cityId = ([dic objectForKey:@"cityId"] != [NSNull null])&&([dic objectForKey:@"cityId"] !=nil) ? [[dic objectForKey:@"cityId"] integerValue] : 0;
                         
    msg.nickname =([dic objectForKey:@"nickname"] != [NSNull null])&&([dic objectForKey:@"nickname"] !=nil) ? [dic objectForKey:@"nickname"] : @"";
                         
    msg.pageSize =([dic objectForKey:@"pageSize"] != [NSNull null])&&([dic objectForKey:@"pageSize"] !=nil) ? [[dic objectForKey:@"pageSize"] integerValue] : 0;
    
    msg.phone = ([dic objectForKey:@"phone"] != [NSNull null])&&([dic objectForKey:@"phone"] !=nil) ? [dic objectForKey:@"phone"] : @"";
                         
    msg.poiId = ([dic objectForKey:@"poiId"] != [NSNull null])&&([dic objectForKey:@"poiId"] !=nil) ? [[dic objectForKey:@"poiId"] integerValue] : 0;
                         
    msg.replyCommentNumber =([dic objectForKey:@"replyCommentNumber"] != [NSNull null])&&([dic objectForKey:@"replyCommentNumber"] !=nil) ? [[dic objectForKey:@"replyCommentNumber"]integerValue] : 0;
                         
    msg.smallimageurl = ([dic objectForKey:@"smallimageurl"] != [NSNull null])&&([dic objectForKey:@"smallimageurl"] !=nil) ? [dic objectForKey:@"smallimageurl"] : @"";
    
    msg.status = ([dic objectForKey:@"status"] != [NSNull null])&&([dic objectForKey:@"tagsColor"] !=nil) ? [[dic objectForKey:@"status"] integerValue] : 0;
    msg.title = ([dic objectForKey:@"title"] != [NSNull null])&&([dic objectForKey:@"title"] !=nil) ? [dic objectForKey:@"title"] : @"";
    msg.type = ([dic objectForKey:@"type"] != [NSNull null])&&([dic objectForKey:@"type"] !=nil) ? [[dic objectForKey:@"type"] integerValue]: 0;
    msg.userId = ([dic objectForKey:@"userId"] != [NSNull null])&&([dic objectForKey:@"userId"] !=nil) ? [[dic objectForKey:@"userId"] integerValue]: 0;
    
    msg.imgList = ([dic objectForKey:@"imgList"] != [NSNull null])&&([dic objectForKey:@"imgList"] !=nil) ? [dic objectForKey:@"imgList"] : @"";
    
    NSArray *imgArr=[dic objectForKey:@"list"];
    NSArray *imgArr2=[dic objectForKey:@"image"];
    NSMutableArray *dataArray=[[NSMutableArray alloc] initWithCapacity:0];
    if (imgArr) {
        for(id data in imgArr){
            [dataArray addObject:[ImgModel JsonParse:data]];
        }
        msg.imgList=dataArray;
    }else if(imgArr2){
        for(id data in imgArr2){
            [dataArray addObject:[ImgModel JsonParse:data]];
        }
        msg.imgList=dataArray;
    }
    
   
    float contentHeight=[self heightForString:msg.content fontSize:16.0 andWidth:HOME_MSG_WIDTH];
    
    msg.cellHeight=240-65+contentHeight;
    return msg;
}

/**
 @method 获取指定宽度width,字体大小fontSize,字符串value的高度
 @param value 待计算的字符串
 @param fontSize 字体的大小
 @param Width 限制字符串显示区域的宽度
 @result float 返回的高度
 */
+ (float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width
{
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize], NSParagraphStyleAttributeName:paragraphStyle.copy};

    CGRect rect = [value boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];

    //此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
    return rect.size.height;
}

@end
