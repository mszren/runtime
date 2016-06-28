//
//  ImgModel.h
//  Common
//
//  Created by Owen on 15/5/23.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImgModel : NSObject <NSCoding>
@property (nonatomic, assign) NSInteger imageid;
@property (nonatomic, strong) NSString* imagename;
@property (nonatomic, assign) NSInteger objectid;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) NSString* imgpath;
@property (nonatomic, assign) NSInteger sort;

+ (ImgModel*)JsonParse:(NSDictionary*)dic;
@end
