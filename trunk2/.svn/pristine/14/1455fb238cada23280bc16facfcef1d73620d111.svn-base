//
//  EmojiAndTextView.m
//  Common
//
//  Created by 曹亮 on 15/4/9.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "EmojiAndTextView.h"
#import "FaceUtil.h"


#define BEGIN_FLAG @"[/"
#define END_FLAG @"]"
#define MessageWidth 180

@implementation EmojiAndTextView

- (id) init{
    self = [super init];
    if (self) {
        
    }
    return self;
}
#pragma mark -
#pragma mark Manage 图文混排
+ (void)getImageRange:(NSString*)lmessage withArray: (NSMutableArray*)array {
    NSRange range=[lmessage rangeOfString: BEGIN_FLAG];
    NSRange range1=[lmessage rangeOfString: END_FLAG];
    //判断当前字符串是否还有表情的标志。
    if (range.length>0 && range1.length>0) {
        if (range.location > 0) {
            [array addObject:[lmessage substringToIndex:range.location]];
            [array addObject:[lmessage substringWithRange:NSMakeRange(range.location, range1.location+1-range.location)]];
            NSString *str=[lmessage substringFromIndex:range1.location+1];
            [self getImageRange:str withArray:array];
        }else {
            NSString *nextstr=[lmessage substringWithRange:NSMakeRange(range.location, range1.location+1-range.location)];
            //排除文字是“”的
            if (![nextstr isEqualToString:@""]) {
                [array addObject:nextstr];
                NSString *str=[lmessage substringFromIndex:range1.location+1];
                [self getImageRange:str withArray:array];
            }else {
                return;
            }
        }
    } else if (lmessage != nil) {
        [array addObject:lmessage];
    }
}

#define KFacialSizeWidth  25
#define KFacialSizeHeight 25
#define MAX_WIDTH 185
-(void)assembleMessageAtIndex : (NSString *) lmessage withisFrom:(BOOL) isFrom{
    UIColor * labColor;
    if (isFrom) {
        labColor = [UIColor whiteColor];
    }else{
        labColor = [UIColor lightGrayColor];
    }
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [EmojiAndTextView getImageRange:lmessage withArray:array];

    NSArray *data = array;
    UIFont *fon = ChatContentFont;
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
                if (upX >= MessageWidth)
                {
                    upY = upY + KFacialSizeHeight;
                    upX = 0;
                    X = MAX_WIDTH;
                    Y = upY;
                }
                NSString *imageNameStr=[str substringWithRange:NSMakeRange(2, str.length - 3)];
                UIImageView *img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:imageNameStr]];
                img.frame = CGRectMake(upX, upY, KFacialSizeWidth, KFacialSizeHeight);
                [self addSubview:img];
                upX=KFacialSizeWidth+upX;
                if (X<MAX_WIDTH) X = upX;
            } else {
                for (int j = 0; j < [str length]; j++) {
                    NSString *temp = [str substringWithRange:NSMakeRange(j, 1)];
                    if (upX >= MessageWidth)
                    {
                        upY = upY + KFacialSizeHeight;
                        upX = 0;
                        X = MAX_WIDTH;
                        Y =upY;
                    }
                    
                    CGRect contentRect = [temp boundingRectWithSize:CGSizeMake(MAX_WIDTH, 40)
                                                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                                                              attributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                                          fon, NSFontAttributeName,
                                                                                          nil]
                                                                                 context:nil];
                    
                    CGSize size= contentRect.size;
                    UILabel *la = [[UILabel alloc] initWithFrame:CGRectMake(upX,upY,size.width,size.height)];
                    la.font = fon;
                    la.text = temp;
                    la.backgroundColor = [UIColor clearColor];
                    la.textColor = labColor;
                    [self addSubview:la];
                    upX=upX+size.width;
                    if (X<MAX_WIDTH) {
                        X = upX;
                    }
                }
            }
        }
    }
    if (isFrom) {
        self.frame = CGRectMake(8.0f,8.0f, X, Y); //@ 需要将该view的尺寸记下，方便以后使用
    }else{
        self.frame = CGRectMake(18.0f,8.0f, X, Y+15); //@ 需要将该view的尺寸记下，方便以后使用
    }
}

+ (CGSize)assembleMessageAtIndex: (NSString *) lmessage{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [self getImageRange:lmessage withArray:array];
    
    NSArray *data = array;
    UIFont *fon = ChatContentFont;
    CGFloat upX = 0;
    CGFloat upY = 0;
    CGFloat X = 0; //width
    CGFloat Y = 0; //height
    if (data) {
        for (int i=0;i < [data count];i++) {
            NSString *str=[data objectAtIndex:i];
  
            if ([str hasPrefix: BEGIN_FLAG] && [str hasSuffix: END_FLAG])
            {
                if (upX >= MessageWidth)
                {
                    upY = upY + KFacialSizeHeight;
                    upX = 0;
                    X = MAX_WIDTH;
                    Y = upY;
                }
                upX=KFacialSizeWidth+upX;
                if (X<MAX_WIDTH) X = upX;
            } else {
                for (int j = 0; j < [str length]; j++) {
                    NSString *temp = [str substringWithRange:NSMakeRange(j, 1)];
                    if (upX >= MessageWidth)
                    {
                        upY = upY + KFacialSizeHeight;
                        upX = 0;
                        X = MAX_WIDTH;
                        Y =upY;
                    }
                    CGRect contentRect = [temp boundingRectWithSize:CGSizeMake(MAX_WIDTH, 40)
                                                            options:NSStringDrawingUsesLineFragmentOrigin
                                                         attributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                     fon, NSFontAttributeName,
                                                                     nil]
                                                            context:nil];
                    CGSize size= contentRect.size;
                    upX=upX+size.width;
                    if (X<MAX_WIDTH) {
                        X = upX;
                    }
                }
            }
        }
    }
    return CGSizeMake(X, Y+15);
}




@end
