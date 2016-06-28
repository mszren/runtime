//
//  MsgCommentModel.h
//  Common
//
//  Created by Owen on 15/5/27.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MsgCommentModel : NSObject<NSCoding>

@property (nonatomic,assign) NSInteger commentId;
@property (nonatomic,strong) NSString* commentTime;
@property (nonatomic,strong) NSString* content;
@property (nonatomic,strong) NSString* face;

@property (nonatomic,assign) NSInteger  mid;
@property (nonatomic,strong) NSString*  nickName;
@property (nonatomic,assign) NSInteger  pageSize;
@property (nonatomic,assign) NSInteger  replyId;

@property (nonatomic,assign) NSInteger  status;
@property (nonatomic,assign) NSInteger  type;
@property (nonatomic,assign) NSInteger  userId;
@property (nonatomic,strong) NSString*  userName;

+(MsgCommentModel *)JsonParse:(NSDictionary *)dic;

@end
