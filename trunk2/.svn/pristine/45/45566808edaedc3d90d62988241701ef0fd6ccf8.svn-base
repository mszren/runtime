//
//  TopicModel.h
//  Common
//
//  Created by Owen on 15/5/22.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopicModel : NSObject<NSCoding>
@property (nonatomic,assign) NSInteger operId;
@property (nonatomic,strong) NSString* topic;
@property (nonatomic,strong) NSString* createTime;
@property (nonatomic,strong) NSString* tagsColor;
@property (nonatomic,strong) NSString* nickname;
@property (nonatomic,strong) NSString* iconUrl;
@property (nonatomic,strong) NSString* tagsName;
@property (nonatomic,assign) NSInteger userAttentionNum;
@property (nonatomic,assign) NSInteger hitNum;
@property (nonatomic,assign) NSInteger replyNum;
@property (nonatomic,assign) NSInteger rownum;

@property (nonatomic,assign) NSInteger publishId;
@property (nonatomic,strong) NSString* shopName;
@property (nonatomic,assign) NSInteger shopId;
@property (nonatomic,assign) NSInteger tagsId;
@property (nonatomic,assign) NSInteger typeId;

@property (nonatomic,strong) NSMutableArray* commentList;


@property (nonatomic,strong)NSString *  contentInfo;
@property (nonatomic,strong)NSString * face;
@property (nonatomic,strong)NSString * images;
@property (nonatomic,assign)NSInteger  userId;
@property (nonatomic,assign)NSInteger tribeld;
@property (nonatomic,assign)NSInteger tip;
@property (nonatomic,assign)NSInteger isEssence;
@property (nonatomic,assign)NSInteger isTop;
@property (nonatomic,assign)NSInteger contentHeight;
@property (nonatomic,assign)NSInteger imageHeight;



+(TopicModel *)JsonParse:(NSDictionary *)dic;
@end
