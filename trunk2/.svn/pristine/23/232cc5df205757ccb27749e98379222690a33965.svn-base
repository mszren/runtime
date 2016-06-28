//
//  UUInputFunctionView.h
//  UUChatDemoForTextVoicePicture
//
//  Created by shake on 14-8-27.
//  Copyright (c) 2014年 uyiuyao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EmojiPageView.h"
#import "HPGrowingTextView.h"

@class UUInputFunctionView;

@protocol UUInputFunctionViewDelegate <NSObject>

// text
- (void)UUInputFunctionView:(UUInputFunctionView *)funcView sendMessage:(NSString *)message;

// image
- (void)UUInputFunctionView:(UUInputFunctionView *)funcView sendPicture:(NSString *)imageUrl;

// audio
- (void)UUInputFunctionView:(UUInputFunctionView *)funcView sendVoice:(NSString *)messageUrl time:(NSInteger)second;

@end

@interface UUInputFunctionView : UIView <UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    UIView * _moreView;
    UIButton * _moreImgBtn;
    UIButton * _morePhotoBtn;
    UIButton * _moreVideoBtn;
    BOOL _isShowMoreView;
    BOOL _isShowEmojiView;
    
    BOOL _isShowKeyBoard;
    
    UIImageView * _inputToolBarBgView;
}

@property (nonatomic, retain) UIButton * moreViewBtn;
@property (nonatomic, retain) UIButton * voiceTextStateBtn;
@property (nonatomic, retain) UIButton * voiceRecordBtn;
@property (nonatomic, retain) UIButton * showEmogiBtn;

@property (nonatomic, retain) HPGrowingTextView * growingTextView;
@property (nonatomic, strong) EmojiPageView * emojiView;

@property (nonatomic, assign) BOOL isAbleToSendTextMessage;

@property (nonatomic, retain) UIViewController *superVC;

@property (nonatomic, assign) id<UUInputFunctionViewDelegate>delegate;


- (id)initWithSuperVC:(UIViewController *)superVC;

- (void)hideMoreView;

@end
