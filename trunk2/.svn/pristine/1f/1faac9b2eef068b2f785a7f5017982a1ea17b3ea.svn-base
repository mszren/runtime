//
//  BaseMessageCell.h
//  FamilysHelper
//
//  Created by 曹亮 on 14/11/7.
//  Copyright (c) 2014年 FamilyTree. All rights reserved.
//

@class XMPPMessageArchiving_Message_CoreDataObject;

@interface BaseMessageCell : UIView
{
    XMPPMessageArchiving_Message_CoreDataObject * message;
    
    UILabel * messageLabel;
    UILabel * timeLabel;
    UIImageView * messageBg;
    
    UIView * contentMessageView;
}
@property(nonatomic,strong) UIImageView * headBtn;

- (void)setViewData:(XMPPMessageArchiving_Message_CoreDataObject *) aMessage;
+ (CGFloat)GetChatMessageHeight:(XMPPMessageArchiving_Message_CoreDataObject *) aMessage;


+ (UIView *)assembleMessageAtIndex : (NSString *) lmessage from:(BOOL)fromself;
+ (void)getImageRange:(NSString*)lmessage : (NSMutableArray*)array;

@end
