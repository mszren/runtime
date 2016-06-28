//
//  ActivityModel.h
//  Common
//
//  Created by 曹亮 on 14/11/18.
//  Copyright (c) 2014年 FamilyTree. All rights reserved.
//

@interface ActivityModel : NSObject <NSCoding> {
}
@property (nonatomic, assign) NSInteger activityId;
@property (nonatomic, assign) NSInteger isHot;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* desc;
@property (nonatomic, strong) NSString* startTime;
@property (nonatomic, assign) NSInteger shopId;
@property (nonatomic, assign) NSInteger money;

@property (nonatomic, strong) NSString* imageName;
@property (nonatomic, strong) NSString* endTimeStr;
@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* address;
@property (nonatomic, strong) NSString* shopName;
@property (nonatomic, strong) NSString* shopLogo;
@property (nonatomic, strong) NSString* beginTimeStr;

@property (nonatomic, strong) NSString* image;
@property (nonatomic, strong) NSString* content;
@property (nonatomic, assign) NSInteger hitNum;
@property (nonatomic, assign) NSInteger replyNum;
@property (nonatomic, assign) NSInteger isTop;

@property (nonatomic, strong) NSString* shopImages;
@property (nonatomic, strong) NSString* phone;
@property (nonatomic, assign) NSInteger joinNum;
@property (nonatomic, strong) NSArray* activityApplyList;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) NSInteger activityStatus;
@property (nonatomic, strong) NSString* endTime;

@property (nonatomic, strong) NSString* commentContent;
@property (nonatomic, strong) NSString* commentNickName;

@property (nonatomic, assign) NSInteger objectType;
@property (nonatomic,strong)NSString *imagePath;
@property (nonatomic, assign) NSInteger row;

+ (ActivityModel*)JsonParse:(NSDictionary*)dic;

@end
