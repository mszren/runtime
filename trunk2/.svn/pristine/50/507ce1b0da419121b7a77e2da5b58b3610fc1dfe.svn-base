//
//  EmojiPageView.h
//  Common
//
//  Created by 曹亮 on 15/4/9.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PagePhotosView.h"
@protocol EmojiPageViewDelegate <NSObject>

-(void)emojiPageViewSelectString:(NSString *)emojiString;

@end
@interface EmojiPageView : UIView<PagePhotosDataSource>
{
    int pageOfNum ;
    int emojiOfCur ;
}
@property(nonatomic,weak)id<EmojiPageViewDelegate> delegate;

@end
