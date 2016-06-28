//
//  ChatModel.m
//  UUChatTableView
//
//  Created by shake on 15/1/6.
//  Copyright (c) 2015年 uyiuyao. All rights reserved.
//

#import "ChatModel.h"

#import "UUMessage.h"
#import "UUMessageFrame.h"



@implementation ChatModel

- (id)init {
    if (self = [super init]) {
        
    }
    return self;
}

+ (NSMutableArray *)changeParseToChatModel:(NSMutableArray *) ldataList
{
    int num = ldataList.count;
    MessageInfoModel * model;
    NSMutableArray * resultList = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < num; i++) {
        model = [ldataList objectAtIndex:i];
        if ([model isKindOfClass:[UUMessageFrame class]]) {
            [resultList addObject:model];
        }else{
            UUMessageFrame *messageFrame = [[UUMessageFrame alloc]init];
            UUMessage *message = [[UUMessage alloc] init];
            

            message.strContent = model.content;
            
            if (model.chatInfoType == CHATINFO_NML) {
                message.type =  UUMessageTypeText;
            }
            
            if (model.isSend) {
                message.strName = [CurrentAccount currentAccount].nickname;
                message.from = UUMessageFromMe;
                message.strIcon = getUserPhoto_x([CurrentAccount currentAccount].face);
                
                message.state = model.state;
            }else{
                message.strName = model.toUser.nickname;
                message.from = UUMessageFromOther;
                message.strIcon = getUserPhoto_x(model.toUser.face);
            }
            
            message.strTime = [[NSDate dateWithTimeIntervalSince1970:model.time.integerValue/1000] description];
            
            [message minuteOffSetStart:previousTime end:message.strTime];
            messageFrame.showTime = message.showDateLabel;
            
            [messageFrame setMessage:message];
            
            [resultList insertObject:messageFrame atIndex:0];
        }
    }
    return resultList;
}



- (void)populateRandomDataSource {
    
}

- (void)addRandomItemsToDataSource:(NSInteger)number{

    for (int i=0; i<number; i++) {

    }
}

- (void)addSpecifiedItem:(NSDictionary *)dic
{
    UUMessageFrame *messageFrame = [[UUMessageFrame alloc]init];
    UUMessage *message = [[UUMessage alloc] init];
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionaryWithDictionary:dic];
  
    NSString *URLStr = @"http://img0.bdstatic.com/img/image/shouye/xinshouye/mingxing16.jpg";
    [dataDic setObject:@1 forKey:@"from"];
    [dataDic setObject:[[NSDate date] description] forKey:@"strTime"];
    [dataDic setObject:@"Hello,sister" forKey:@"strName"];
    [dataDic setObject:URLStr forKey:@"strIcon"];
    
    [message setWithDict:dataDic];
    [message minuteOffSetStart:previousTime end:dataDic[@"strTime"]];
    messageFrame.showTime = message.showDateLabel;
    [messageFrame setMessage:message];
    
    if (message.showDateLabel) {
        previousTime = dataDic[@"strTime"];
    }
}

static NSString *previousTime = nil;

- (NSArray *)additems:(NSInteger)number
{
    NSMutableArray *result = [NSMutableArray array];
    
    for (int i=0; i<number; i++) {
        
        UUMessageFrame *messageFrame = [[UUMessageFrame alloc]init];
        UUMessage *message = [[UUMessage alloc] init];
        NSDictionary *dataDic = [self getDic];
        
        [message setWithDict:dataDic];
        [message minuteOffSetStart:previousTime end:dataDic[@"strTime"]];
        messageFrame.showTime = message.showDateLabel;
        [messageFrame setMessage:message];
        
        if (message.showDateLabel) {
            previousTime = dataDic[@"strTime"];
        }
        [result addObject:messageFrame];
    }
    return result;
}

static int dateNum = 10;

- (NSDictionary *)getDic
{
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    int randomNum = arc4random()%2;
    switch (randomNum) {
        case 0:// text
//            [dictionary setObject:[self randomString] forKey:@"strContent"];
            break;
        case 1:// picture
            [dictionary setObject:[UIImage imageNamed:@"haha.jpeg"] forKey:@"picture"];
            break;
//            case 2:// audio
//                [dictionary setObject:@"" forKey:@"voice"];
//                [dictionary setObject:@"" forKey:@"strVoiceTime"];
//                break;
        default:
            break;
    }
    NSString *URLStr = @"http://img0.bdstatic.com/img/image/shouye/xinshouye/chongwu16.jpg";
    NSDate *date = [[NSDate date]dateByAddingTimeInterval:arc4random()%1000*(dateNum++) ];
    [dictionary setObject:[NSNumber numberWithInt:0] forKey:@"from"];
    [dictionary setObject:[NSNumber numberWithInt:randomNum] forKey:@"type"];
    [dictionary setObject:[date description] forKey:@"strTime"];
    [dictionary setObject:@"Hello,Boss" forKey:@"strName"];
    [dictionary setObject:URLStr forKey:@"strIcon"];
    
    return dictionary;
}



@end
