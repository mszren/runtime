//
//  MsgModel.h
//  Common
//
//  Created by Owen on 15/5/23.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import <Foundation/Foundation.h>
/*lcdList  信息列表
cityId   城市ID
cityName  城市名称
commentNum  评论数
communityId   小区id
communityName  小区name
content   发布内容
createTime  发布时间
face   发送人头像
hotNum  点赞数
lifeCircleId   发布信息id
lifeType
likeNum  喜欢数
list   图片list
imageid  图片id
imagename  图片名称
objectid    发布信息id（与lifeCircleId 相等）
type  类型
nickname发布人昵称
phone    手机
userId  发布人id
 */
@interface MsgModel : NSObject<NSCoding>
@property (nonatomic,assign) NSInteger cityId;
@property (nonatomic,strong) NSString* cityName;
@property (nonatomic,assign) NSInteger commentNum;
@property (nonatomic,assign) NSInteger communityId;
@property (nonatomic,strong) NSString*  communityName;
@property (nonatomic,strong) NSString*  content;//发布内容
@property (nonatomic,strong) NSString*  createTime;//发布时间
@property (nonatomic,strong) NSString*  face;//发布人头像
@property (nonatomic,assign) NSInteger hotNum;//点赞数
@property (nonatomic,assign) NSInteger lifeCircleId;
@property (nonatomic,assign) NSInteger lifeType;
@property (nonatomic,assign) NSInteger likeNum;
@property (nonatomic,strong) NSMutableArray* imgList;//发布的图片
@property (nonatomic,assign) NSInteger mid;
@property (nonatomic,strong) NSString*  nickname;//发布人昵称
@property (nonatomic,assign) NSInteger pageSize;
@property (nonatomic,strong) NSString* phone;
@property (nonatomic,assign) NSInteger poiId;
@property (nonatomic,assign) NSInteger replyCommentNumber;//评论回复数
@property (nonatomic,strong) NSString*  smallimageurl;
@property (nonatomic,assign) NSInteger status;//状态
@property (nonatomic,strong) NSString* title;
@property (nonatomic,assign) NSInteger type;
@property (nonatomic,assign) NSInteger userId;//发布人id
@property (nonatomic,assign) NSInteger cellHeight;
@property (nonatomic,assign)NSInteger sumPrise;

+ (MsgModel *)JsonParse:(NSDictionary *)dic;
@end
