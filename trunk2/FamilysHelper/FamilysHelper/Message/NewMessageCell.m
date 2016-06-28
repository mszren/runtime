//
//  NewMessageCell.m
//  FamilysHelper
//
//  Created by 曹亮 on 14/11/8.
//  Copyright (c) 2014年 FamilyTree. All rights reserved.
//

#import "NewMessageCell.h"

#import "XMPPMessage.h"

static NSDictionary * faceDic;
@interface NewMessageCell()

@end

#define BEGIN_FLAG @"["
#define END_FLAG @"]"

#define MessageFontSize 14
#define timeFontSize 12
#define MessageLabelWidth 180

@implementation NewMessageCell

- (id)init
{
    self = [super init];
    if (self) {
        
        
    }
    return self;
}


- (void)setNewMessage:(XMPPMessage *) aMessage;
{
    _currentMessage = aMessage;
    
    [contentMessageView removeFromSuperview];
    contentMessageView = [NewMessageCell assembleMessageAtIndex:aMessage.body from:YES];
    contentMessageView.frame = CGRectMake(80, 30, contentMessageView.frame.size.width, contentMessageView.frame.size.height);
    
    NSString * contentText = aMessage.body;
    CGSize textSize = [contentText sizeWithFont:FONT_SIZE(MessageFontSize) constrainedToSize:CGSizeMake(MessageLabelWidth, INT32_MAX)];
    
    UIImage *bubble1 = [UIImage imageNamed:@"msg_out_pressed.png"];
    UIImage *x1 = [[UIImage alloc] initWithCGImage:bubble1.CGImage scale:1.0 orientation:UIImageOrientationUp];
    messageBg.image = [x1 stretchableImageWithLeftCapWidth:30 topCapHeight:0];
    
    contentMessageView.frame = CGRectMake(SCREEN_WIDTH - textSize.width -35, 10 , textSize.width + 20, textSize.height + 10);
    messageBg.frame = CGRectMake(SCREEN_WIDTH - textSize.width - 50, 5 , textSize.width + 50, textSize.height + 20);
    timeLabel.textAlignment = NSTextAlignmentRight;
    timeLabel.frame = CGRectMake(SCREEN_WIDTH - timeLabel.frame.size.width - 20, contentMessageView.frame.origin.y + contentMessageView.frame.size.height, timeLabel.frame.size.width, timeLabel.frame.size.height);
}
+ (CGFloat)GetChatMessageHeight:(XMPPMessage *) aMessage
{
    UIView * lview = [NewMessageCell assembleMessageAtIndex:aMessage.body from:YES];
    
    
    CGFloat cellHeight = (lview.frame.size.height == 0 ? 20 : lview.frame.size.height) + 55;
    return cellHeight;

}

@end