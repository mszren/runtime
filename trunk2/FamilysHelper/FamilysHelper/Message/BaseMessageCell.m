//
//  BaseMessageCell.m
//  FamilysHelper
//
//  Created by 曹亮 on 14/11/7.
//  Copyright (c) 2014年 FamilyTree. All rights reserved.
//

#import "BaseMessageCell.h"


#import "FaceUtil.h"

#import "XMPPMessageArchiving_Message_CoreDataObject.h"

//#import "ChatMessage.h"
//#import "EGOImageButton.h"
#import "CurrentAccount.h"
#import "NSStringAdditions.h"

static NSDictionary * faceDic;
@interface BaseMessageCell()

@end

#define BEGIN_FLAG @"["
#define END_FLAG @"]"

#define MessageFontSize 14
#define timeFontSize 12
#define MessageLabelWidth 180


@implementation BaseMessageCell

@synthesize headBtn = _headBtn;

- (id)init{
    self = [super init];
    if (self) {
        messageBg = [[UIImageView alloc] initWithFrame:CGRectZero];
        messageBg.backgroundColor = [UIColor clearColor];
        [self addSubview:messageBg];
        
        messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 0, 0)];
        messageLabel.font = FONT_SIZE(MessageFontSize);
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = NSTextAlignmentLeft;
//        messageLabel.textColor = TitleFontColor;
        messageLabel.backgroundColor = [UIColor clearColor];
        
        timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 30, 150, 30)];
        timeLabel.font = FONT_SIZE(timeFontSize);
        timeLabel.numberOfLines = 0;
        timeLabel.textColor = [UIColor darkGrayColor];
        timeLabel.textAlignment = NSTextAlignmentLeft;
        timeLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:timeLabel];
        
        if (!faceDic) {
//            faceDic = [FaceUtil getFaceArray];
        }
    }
    return self;
}

- (void)setViewData:(XMPPMessageArchiving_Message_CoreDataObject *) aMessage{
    message = aMessage;
    
    [contentMessageView removeFromSuperview];
    contentMessageView = [BaseMessageCell assembleMessageAtIndex:aMessage.body from:YES];
    contentMessageView.frame = CGRectMake(80, 30, contentMessageView.frame.size.width, contentMessageView.frame.size.height);
    [self addSubview:contentMessageView];
    
    messageLabel.text = aMessage.body;
    timeLabel.text = [NSString daySinceDate:aMessage.timestamp];
    
    [self layoutFrame];
}
- (void)layoutFrame{
    NSString * contentText = message.body;
    CGSize textSize = [contentText sizeWithFont:FONT_SIZE(MessageFontSize) constrainedToSize:CGSizeMake(MessageLabelWidth, INT32_MAX)];

    if (message.isOutgoing) {
        UIImage *bubble0 = [UIImage imageNamed:@"msg_in_pressed.png"];
        UIImage *x = [[UIImage alloc] initWithCGImage:bubble0.CGImage scale:1.0 orientation:UIImageOrientationUp];
        messageBg.image = [x stretchableImageWithLeftCapWidth:30 topCapHeight:0];
        
        contentMessageView.frame = CGRectMake(25, 8, textSize.width + 20, textSize.height + 10);
        messageBg.frame = CGRectMake(0, 0 , textSize.width + 50, textSize.height + 20);
        timeLabel.textAlignment = NSTextAlignmentLeft;
        timeLabel.frame = CGRectMake(15, contentMessageView.frame.origin.y + contentMessageView.frame.size.height, timeLabel.frame.size.width, timeLabel.frame.size.height);
    }else{
        UIImage *bubble1 = [UIImage imageNamed:@"msg_out_pressed.png"];
        UIImage *x1 = [[UIImage alloc] initWithCGImage:bubble1.CGImage scale:1.0 orientation:UIImageOrientationUp];
        messageBg.image = [x1 stretchableImageWithLeftCapWidth:30 topCapHeight:0];
        
        contentMessageView.frame = CGRectMake(SCREEN_WIDTH - textSize.width -35, 10 , textSize.width + 20, textSize.height + 10);
        messageBg.frame = CGRectMake(SCREEN_WIDTH - textSize.width - 50, 5 , textSize.width + 50, textSize.height + 20);
        timeLabel.textAlignment = NSTextAlignmentRight;
        timeLabel.frame = CGRectMake(SCREEN_WIDTH - timeLabel.frame.size.width - 20, contentMessageView.frame.origin.y + contentMessageView.frame.size.height, timeLabel.frame.size.width, timeLabel.frame.size.height);
    }
}
+ (CGFloat)GetChatMessageHeight:(XMPPMessageArchiving_Message_CoreDataObject *) aMessage{
    UIView * lview = [BaseMessageCell assembleMessageAtIndex:aMessage.body from:YES];
    
    
    CGFloat cellHeight = (lview.frame.size.height == 0 ? 20 : lview.frame.size.height) + 55;
    return cellHeight;
}

#pragma mark -
#pragma mark Manage 图文混排
+(void)getImageRange:(NSString*)lmessage : (NSMutableArray*)array
{
    NSRange range=[lmessage rangeOfString: BEGIN_FLAG];
    NSRange range1=[lmessage rangeOfString: END_FLAG];
    //判断当前字符串是否还有表情的标志。
    if (range.length>0 && range1.length>0) {
        if (range.location > 0) {
            [array addObject:[lmessage substringToIndex:range.location]];
            [array addObject:[lmessage substringWithRange:NSMakeRange(range.location, range1.location+1-range.location)]];
            NSString *str=[lmessage substringFromIndex:range1.location+1];
            [self getImageRange:str :array];
        }else {
            NSString *nextstr=[lmessage substringWithRange:NSMakeRange(range.location, range1.location+1-range.location)];
            //排除文字是“”的
            if (![nextstr isEqualToString:@""]) {
                [array addObject:nextstr];
                NSString *str=[lmessage substringFromIndex:range1.location+1];
                [self getImageRange:str :array];
            }else {
                return;
            }
        }
    } else if (lmessage != nil) {
        [array addObject:lmessage];
    }
}

#define KFacialSizeWidth  18
#define KFacialSizeHeight 18
//#define MAX_WIDTH 150
+(UIView *)assembleMessageAtIndex : (NSString *) lmessage from:(BOOL)fromself
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [self getImageRange:lmessage :array];
    UIView *returnView = [[UIView alloc] initWithFrame:CGRectZero];
    NSArray *data = array;
    UIFont *fon = [UIFont systemFontOfSize:MessageFontSize];
    CGFloat upX = 0;
    CGFloat upY = 0;
    CGFloat X = 0; //width
    CGFloat Y = 0; //height
    if (data) {
        for (int i=0;i < [data count];i++) {
            NSString *str=[data objectAtIndex:i];
            //            NSLog(@"str--->%@",str);
            if ([str hasPrefix: BEGIN_FLAG] && [str hasSuffix: END_FLAG])
            {
                if (upX >= MessageLabelWidth)
                {
                    upY = upY + KFacialSizeHeight;
                    upX = 0;
                    X = 150;
                    Y = upY;
                }
                //                NSLog(@"str(image)---->%@",str);
                NSString *imageNameStr=[str substringWithRange:NSMakeRange(1, str.length - 2)];
                NSString * imageName = [faceDic objectForKey:imageNameStr];
                
                UIImageView *img= [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
                img.frame = CGRectMake(upX, upY, KFacialSizeWidth, KFacialSizeHeight);
                [returnView addSubview:img];
                upX= KFacialSizeWidth+upX;
                if (X<150) X = upX;
            } else {
                for (int j = 0; j < [str length]; j++) {
                    NSString *temp = [str substringWithRange:NSMakeRange(j, 1)];
                    if (upX >= MessageLabelWidth)
                    {
                        upY = upY + KFacialSizeHeight;
                        upX = 0;
                        X = 150;
                        Y =upY;
                    }
                    CGSize size=[temp sizeWithFont:fon constrainedToSize:CGSizeMake(150, 40)];
                    UILabel *la = [[UILabel alloc] initWithFrame:CGRectMake(upX,upY,size.width,size.height)];
                    la.font = fon;
                    la.text = temp;
                    la.backgroundColor = [UIColor clearColor];
//                    la.textColor = TitleFontColor;
                    [returnView addSubview:la];
                    upX=upX+size.width;
                    if (X<150) {
                        X = upX;
                    }
                }
            }
        }
    }
    returnView.frame = CGRectMake(15.0f,1.0f, X, Y); //@ 需要将该view的尺寸记下，方便以后使用
    //    NSLog(@"%.1f %.1f", X, Y);
    return returnView;
}



@end