//
//  AttestationModel.m
//  Common
//
//  Created by zhouwengang on 15/6/4.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "AttestationModel.h"

@implementation AttestationModel

- (id)copyWithZone:(NSZone *)zone
{
    AttestationModel *copy = [[[self class] allocWithZone:zone] init];
    copy.userId = self.userId ;
    copy.brokerName = [self.brokerName copy];
    copy.brokerPhone = [self.brokerPhone copy];
    copy.cardId = [self.cardId copy];
    copy.status = self.status ;
    return copy;
}
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeInt64:self.userId forKey:@"userId"];
    [aCoder encodeObject:self.brokerName forKey:@"brokerName"];
    [aCoder encodeObject:self.brokerPhone forKey:@"brokerPhone"];
    [aCoder encodeInt64:self.status forKey:@"status"];
     [aCoder encodeObject:self.cardId forKey:@"cardId"];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.userId = [aDecoder decodeIntegerForKey:@"userId"];
        self.brokerName = [aDecoder decodeObjectForKey:@"brokerName"];
        self.brokerPhone = [aDecoder decodeObjectForKey:@"brokerPhone"];
        self.status = [aDecoder decodeIntegerForKey:@"status"];
         self.cardId = [aDecoder decodeObjectForKey:@"cardId"];
    }
    return self;
}

+ (AttestationModel *)JsonParse:(NSDictionary *)dic{
    AttestationModel * attestation = [[AttestationModel alloc] init];
    
    attestation.userId = ([dic objectForKey:@"userId"] != [NSNull null])&&([dic objectForKey:@"userId"] !=nil) ? [[dic objectForKey:@"userId" ] integerValue]: 0;
    attestation.brokerName = ([dic objectForKey:@"brokerName"] != [NSNull null])&&([dic objectForKey:@"brokerName"] !=nil) ? [dic objectForKey:@"brokerName"] : @"";
    attestation.brokerPhone = ([dic objectForKey:@"brokerPhone"] != [NSNull null])&&([dic objectForKey:@"brokerPhone"] !=nil) ? [dic objectForKey:@"iconURL"] : @"";
    attestation.status = ([dic objectForKey:@"status"] != [NSNull null])&&([dic objectForKey:@"status"] !=nil) ? [[dic objectForKey:@"status"] integerValue]: 0;
     attestation.cardId = ([dic objectForKey:@"cardId"] != [NSNull null])&&([dic objectForKey:@"cardId"] !=nil) ? [dic objectForKey:@"cardId"] : @"";
    return attestation;
}

@end
