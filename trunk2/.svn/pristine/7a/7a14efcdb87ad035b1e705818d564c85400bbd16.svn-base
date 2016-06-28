//
//  EmojiPageView.m
//  Common
//
//  Created by 曹亮 on 15/4/9.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "EmojiPageView.h"

@implementation EmojiPageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        pageOfNum =4;
        emojiOfCur =0;
        
        PagePhotosView *pagePhotosView = [[PagePhotosView alloc] initWithFrame: CGRectMake(0, 0, frame.size.width, frame.size.height) withDataSource: self];
        [self  addSubview:pagePhotosView];

    }
    return self;
}
#pragma mark - 有多少页

- (int)numberOfPages
{
	return pageOfNum;
}

-(int)emojiOfCurrent
{
    return emojiOfCur;
}

// 每页的图片
//
- (UIView *)imageAtIndex:(int)index :(int)btn
{
    int row   =4;
    int col   =8;
    int emojiBtnWidth = 35;
    int emojiBtnHight = 35;
    int intervalWidth = 5;
    int intervalhight = 5;
    
    UIView *view =[[UIView alloc] init];
    switch (btn)
    {
        default:
        {
            row   =4;
            col   =8;
            emojiBtnWidth = 35;
            emojiBtnHight = 35;
            intervalWidth = 5;
            intervalhight = 9;
            NSString *filePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"emoji_biaoqing.plist"];
            NSDictionary *m_pEmojiDic = [[NSDictionary alloc] initWithContentsOfFile:filePath];
            for (int i=1; i<=row;i++ )
            {
                
                for (int j=1; j<=col; j++)
                {
                    int n=(i-1)*col+j+row*col*index;
                    UIButton *btn = [[UIButton alloc]init];
                    [btn setFrame:CGRectMake(emojiBtnWidth*(j-1)+intervalWidth*j,emojiBtnHight*(i-1)+(i)*intervalhight, emojiBtnWidth, emojiBtnHight)];
                    [btn setBackgroundColor:[UIColor clearColor]];
                    NSString *i_transCharacter = [m_pEmojiDic objectForKey:[NSString stringWithFormat:@"%d",n]];
                    
                    [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",i_transCharacter]] forState:UIControlStateNormal];
                    [btn addTarget:self action:@selector(emojiButtonPress:) forControlEvents:UIControlEventTouchUpInside];
                    [btn setTag:n];
                    [view addSubview:btn];
                }
            }
        }
            break;
    }
    
    
	return view;
}
#pragma mark -------表情事件响应()
-(void)emojiButtonPress:(id)sender
{
    UIButton *selectedButton = (UIButton *) sender;
    if (selectedButton.currentImage==NULL)
    {
        return;
    }
    switch (emojiOfCur) {
        case 0:
        {
            //获取对应的button
            NSUInteger  n = selectedButton.tag;
            //根据button的tag获取对应的图片名
            NSString *filePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"emoji_biaoqing.plist"];
            NSDictionary *m_pEmojiDic = [[NSDictionary alloc] initWithContentsOfFile:filePath];
            NSString *i_transCharacter=[NSString stringWithFormat:@"[/%@]", [m_pEmojiDic objectForKey:[NSString stringWithFormat:@"%ld",n]]];
            //判断输入框是否有内容，追加转义字符
            
            
            if (self.delegate && [_delegate respondsToSelector:@selector(emojiPageViewSelectString:)]) {
                [_delegate emojiPageViewSelectString:i_transCharacter];
                
            }
                  }
            break;
        default:
            break;
    }
    
}

@end
