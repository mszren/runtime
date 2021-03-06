//
//  GroupModel.h
//  Common
//
//  Created by 曹亮 on 15/3/17.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

@interface GroupModel : NSObject <NSCoding>

@property(nonatomic,strong) NSString * groupId;
@property(nonatomic,strong) NSString * groupDescription;
@property(nonatomic,strong) NSString * groupImageUrl;
@property(nonatomic,strong) NSString * groupName;
@property(nonatomic,strong) NSString * name;
@property(nonatomic,strong) NSString * phone;
@property(nonatomic,strong) NSString * redPacketNumber;
@property(nonatomic,strong) NSString * roomIds;
@property(nonatomic,strong) NSString * totalCount;
@property(nonatomic,strong) NSString * totalPrice;

@property(nonatomic,strong) NSString * creationDate;
@property(nonatomic,strong) NSString * count;
@property(nonatomic,strong) NSString * naturalName;

@property(nonatomic,strong) NSString * memberNumber;
@property(nonatomic,strong) NSArray * mucOwners;
@property(nonatomic,strong) NSString *groupLogo;

@property(nonatomic,copy) NSString *group_image_url;
@property(nonatomic,assign) NSInteger roomID;
@property(nonatomic,assign) NSInteger applyNumer;

+ (GroupModel *)JsonParse:(NSDictionary *)dic;

+ (GroupModel *)JsonInfoParse:(NSDictionary *)dic;
@end

