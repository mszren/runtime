//
//  CellModel.m
//  Common
//
//  Created by Owen on 15/6/3.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "CellModel.h"

@implementation CellModel

- (id)copyWithZone:(NSZone *)zone
{
    CellModel *copy = [[[self class] allocWithZone:zone] init];
    copy.iconName = [self.iconName copy];
    copy.titleName = [self.titleName copy];
    copy.iconURL = [self.iconURL copy];
    return copy;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.iconName forKey:@"iconName"];
    [aCoder encodeObject:self.titleName forKey:@"titleName"];
    [aCoder encodeObject:self.iconURL forKey:@"iconURL"];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.iconName = [aDecoder decodeObjectForKey:@"iconName"];
        self.titleName = [aDecoder decodeObjectForKey:@"titleName"];
        self.iconURL = [aDecoder decodeObjectForKey:@"iconURL"];
    }
    return self;
}

+ (CellModel *)JsonParse:(NSDictionary *)dic{
    CellModel * cell = [[CellModel alloc] init];
    
    cell.iconName = ([dic objectForKey:@"iconName"] != [NSNull null])&&([dic objectForKey:@"iconName"] !=nil) ? [dic objectForKey:@"iconName"] : @"";
    cell.titleName = ([dic objectForKey:@"titleName"] != [NSNull null])&&([dic objectForKey:@"titleName"] !=nil) ? [dic objectForKey:@"titleName"] : @"";
    cell.iconURL = ([dic objectForKey:@"iconURL"] != [NSNull null])&&([dic objectForKey:@"iconURL"] !=nil) ? [dic objectForKey:@"iconURL"] : @"";
    return cell;
}


@end
