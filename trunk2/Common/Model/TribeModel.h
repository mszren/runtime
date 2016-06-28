//
//  TribeModel.h
//  Common
//
//  Created by Owen on 15/5/22.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TribeModel : NSObject<NSCoding>


@property (nonatomic,strong) NSArray* tagsList;
@property (nonatomic,strong) NSString* shopAddress;
@property (nonatomic,strong) NSString* face;
@property (nonatomic,strong) NSString* tribeName;
@property (nonatomic,assign) NSInteger isattention;
@property (nonatomic,assign) NSInteger isAttention;
@property (nonatomic,strong) NSString* shopNotice;
@property (nonatomic,strong) NSString* shopIntro;
@property (nonatomic,strong) NSString* nickname;
@property (nonatomic,assign) NSInteger tribeMainId;
@property (nonatomic,strong) NSString* shopName;
@property (nonatomic,assign) NSInteger shopId;
@property (nonatomic,assign) NSInteger attentionNum;
@property (nonatomic,assign) NSInteger interActionNum;
@property (nonatomic,strong) NSString* shopMobile;
@property (nonatomic,strong) NSString* shopLogo;
@property (nonatomic,assign)NSInteger contentNum;

@property (nonatomic,strong)NSString *mapX;
@property (nonatomic,strong)NSString *mapY;
@property (nonatomic,strong)NSString *star;
@property (nonatomic,strong)NSString *shopImages;
@property (nonatomic,assign)NSInteger distance;
@property (nonatomic,strong)NSArray *goodslist;

+(TribeModel *)JsonParse:(NSDictionary *)dic;
@end
