//
//  UUMessageFrame.m
//  UUChatDemoForTextVoicePicture
//
//  Created by shake on 14-8-26.
//  Copyright (c) 2014年 uyiuyao. All rights reserved.
//

#import "UUMessageFrame.h"

#import "EmojiAndTextView.h"
#import "MessageInfoModel.h"

static NSString * lastModelTime = nil;
@implementation UUMessageFrame

- (void)setMessageInfoModel:(MessageInfoModel *)messageInfoModel
{

    _messageInfoModel = messageInfoModel;
    
    CGFloat screenW = SCREEN_WIDTH;
    
    // 1、计算时间的位置
    if (_showTime){
        CGFloat timeY = ChatMargin;

        CGRect timeSize = [[NSDate  daySinceTimeInterval:_messageInfoModel.time.doubleValue/1000.0f ] boundingRectWithSize:CGSizeMake(300, 100)
                                                          options:NSStringDrawingUsesLineFragmentOrigin
                                                       attributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                   ChatTimeFont, NSFontAttributeName,
                                                                   nil]
                                                          context:nil];
        
        _timeF = CGRectMake(0, timeY, SCREEN_WIDTH, timeSize.size.height + ChatTimeMarginH);
    }
    
    
    // 2、计算头像位置
    CGFloat iconX = ChatMargin;
    if (_messageInfoModel.isSend == 1) {
        iconX = screenW - ChatMargin - ChatIconWH;
    }
    CGFloat iconY = CGRectGetMaxY(_timeF) + ChatMargin;
    _iconF = CGRectMake(iconX, iconY, ChatIconWH, ChatIconWH);
    
    // 3、计算ID位置
    _nameF = CGRectMake(iconX, iconY+ChatIconWH, ChatIconWH, 20);
    
    // 4、计算内容位置
    CGFloat contentX = CGRectGetMaxX(_iconF)+ChatMargin;
    CGFloat contentY = iconY;
    
    //根据种类分
    CGSize contentSize;
    switch (_messageInfoModel.chatInfoType) {
        case CHATINFO_NML:{
            contentSize = [EmojiAndTextView assembleMessageAtIndex:_messageInfoModel.content];
            break;
        }
        case CHATINFO_FIL_IMG:
            contentSize = CGSizeMake(ChatPicWH, ChatPicWH);
            break;
        case CHATINFO_FIL_Voice:
            contentSize = CGSizeMake(80, 20);
            break;
        case CHATINFO_BFD:
            contentSize = CGSizeMake(130, 65);
            break;
        case CHATINFO_YFM:
            contentSize = CGSizeMake(160, 50);
        case CHATINFO_RED:
            contentSize = CGSizeMake(160, 100);
        default:
            break;
    }
    
    if (_messageInfoModel.isSend == 1) {
        contentX = iconX - contentSize.width - ChatContentLeft - ChatContentRight - ChatMargin;
    }
    _contentF = CGRectMake(contentX, contentY, contentSize.width + ChatContentLeft + ChatContentRight, contentSize.height + ChatContentTop + ChatContentBottom);
    _cellHeight = MAX(CGRectGetMaxY(_contentF), CGRectGetMaxY(_nameF))  + ChatMargin;
}


#pragma mark
#pragma mark -- MessageInfoModel Parse To UUMessageFrame
+ (void)changeParseToChatModel:(NSMutableArray *) ldataList
{
    NSUInteger num = ldataList.count;
    MessageInfoModel * model;

    for (int i = 0; i < num; i++) {
        model = [ldataList objectAtIndex:i];
        if ([model isKindOfClass:[UUMessageFrame class]]) {

        }else{
            UUMessageFrame *messageFrame = [[UUMessageFrame alloc]init];
            
            messageFrame.showTime = [UUMessageFrame checkShowCellTime:model.time];
            if (model.chatInfoType == CHATINFO_BFD) {
                messageFrame.showTime = YES;
            }
            lastModelTime = model.time;
            [messageFrame setMessageInfoModel:model];
            
            [ldataList replaceObjectAtIndex:i withObject:messageFrame];
        }
    }
}

+ (BOOL)checkShowCellTime:(NSString *) time{
    if (!lastModelTime) {
        return YES;
    }
    int timeDifference = abs((lastModelTime.intValue/1000)-(time.intValue/1000));

    if (timeDifference > KTimeDifference) {
        return YES;
    }else{
        return NO;
    }
}


@end
