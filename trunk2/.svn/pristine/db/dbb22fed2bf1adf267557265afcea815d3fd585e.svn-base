//
//  BaseModel.h
//  Common
//
//  Created by Owen on 15/5/21.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JSONCoder
- (id)initWithDictionary:(NSDictionary*)dic;
@end
@interface DataModel : NSObject <NSCoding, JSONCoder>
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, assign) NSInteger previousCursor;
@property (nonatomic, assign) NSInteger nextCursor;
@property (nonatomic, strong) NSString* error;
@property (nonatomic, strong) id data;
@end
