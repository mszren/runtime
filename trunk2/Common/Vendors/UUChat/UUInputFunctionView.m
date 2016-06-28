//
//  UUInputFunctionView.m
//  UUChatDemoForTextVoicePicture
//
//  Created by shake on 14-8-27.
//  Copyright (c) 2014年 uyiuyao. All rights reserved.
//

#import "UUBaseMessageController.h"

#import "UUInputFunctionView.h"
#import "RecordAudio.h"
#import "UUProgressHUD.h"

#define ChatBarTopSpaceHeight 8

#define InputBottomFrame CGRectMake(0, SCREEN_HEIGHT-TopBarHeight-20-_currentChatBarHeight, SCREEN_WIDTH, _currentChatBarHeight)
#define InputBottomFrame1 CGRectMake(0, SCREEN_HEIGHT-TopBarHeight-20-_currentChatBarHeight, SCREEN_WIDTH, _currentChatBarHeight+KeyBoradHeight)
#define InputMoreTopFrame CGRectMake(0, SCREEN_HEIGHT-TopBarHeight-20-_currentChatBarHeight-KeyBoradHeight, SCREEN_WIDTH, _currentChatBarHeight+KeyBoradHeight)

#define EmojiViewFrame CGRectMake(0, _currentChatBarHeight, SCREEN_WIDTH, KeyBoradHeight)

#define EmojiViewAndMoreDefaultFrame CGRectMake(0, ChatBarHeight, SCREEN_WIDTH, KeyBoradHeight)
#define InputViewDefaultFrame CGRectMake(0, SCREEN_HEIGHT-TopBarHeight-20-ChatBarHeight , SCREEN_WIDTH, ChatBarHeight)



static OSSUnity * ossUnity = nil;
@interface UUInputFunctionView ()<UITextViewDelegate,RecordAudioDelegate,HPGrowingTextViewDelegate,EmojiPageViewDelegate>
{
    BOOL isbeginVoiceRecord;
    RecordAudio *recordAudio;
    NSData *curAudio;
    NSURL * recordFileUrl;
    NSInteger playTime;
    NSTimer *playTimer;
    
    NSRange textRange; //当前输入位置
    
    CGFloat _currentChatBarHeight;
    CGFloat _currentKeyBoardHeight;
}
@end

@implementation UUInputFunctionView

- (id)initWithSuperVC:(UIViewController *)superVC
{
    ossUnity = [OSSUnity shareInstance];
    _currentChatBarHeight = ChatBarHeight;
    self.superVC = superVC;
    self = [super initWithFrame:InputViewDefaultFrame];
    if (self) {
        _isShowKeyBoard = NO;
        _isShowMoreView = NO;
        _isShowEmojiView = NO;
        
        recordAudio = [[RecordAudio alloc]init];
        recordAudio.delegate = self;

        _inputToolBarBgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, _currentChatBarHeight)];
        [_inputToolBarBgView setImage:[UIImage imageNamed:@"chat_ipunt_bar_bg.png"]];
        _inputToolBarBgView.userInteractionEnabled = YES;
        [self addSubview:_inputToolBarBgView];


        //（语音、文字）切换btn
        self.voiceTextStateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.voiceTextStateBtn.frame = CGRectMake(5, ChatBarTopSpaceHeight, 30, 30);
        isbeginVoiceRecord = NO;
        [self.voiceTextStateBtn setBackgroundImage:[UIImage imageNamed:@"chat_voice_record"] forState:UIControlStateNormal];
        self.voiceTextStateBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.voiceTextStateBtn addTarget:self action:@selector(voiceRecordChangeAction:) forControlEvents:UIControlEventTouchUpInside];
        [_inputToolBarBgView addSubview:self.voiceTextStateBtn];
        
        //输入框
        self.growingTextView = [[HPGrowingTextView alloc] initWithFrame:CGRectMake(45, ChatBarTopSpaceHeight, SCREEN_WIDTH-3*45, 32)];
        self.growingTextView.maxNumberOfLines = 3;
        self.growingTextView.layer.cornerRadius = 4;
        self.growingTextView.layer.masksToBounds = YES;
        self.growingTextView.delegate = self;
        self.growingTextView.layer.borderWidth = 1.0f;
        self.growingTextView.layer.borderColor = [[[UIColor lightGrayColor] colorWithAlphaComponent:0.4] CGColor];
        self.growingTextView.returnKeyType = UIReturnKeySend;
        self.growingTextView.internalTextView.enablesReturnKeyAutomatically = YES;
        [_inputToolBarBgView addSubview:self.growingTextView];
        
        //语音录入键
        self.voiceRecordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.voiceRecordBtn.frame = CGRectMake(45, ChatBarTopSpaceHeight, SCREEN_WIDTH-3*45, 30);
        self.voiceRecordBtn.hidden = YES;
        [self.voiceRecordBtn setBackgroundImage:[UIImage imageNamed:@"chat_message_back.png"] forState:UIControlStateNormal];
        [self.voiceRecordBtn setBackgroundImage:[UIImage imageNamed:@"chat_message_back_Highlighted.png"] forState:UIControlStateHighlighted];
        [self.voiceRecordBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self.voiceRecordBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
        [self.voiceRecordBtn setTitle:@"按住 说话" forState:UIControlStateNormal];
        [self.voiceRecordBtn setTitle:@"松开 结束" forState:UIControlStateHighlighted];
        [self.voiceRecordBtn addTarget:self action:@selector(beginRecordVoice:) forControlEvents:UIControlEventTouchDown];
        [self.voiceRecordBtn addTarget:self action:@selector(endRecordVoice:) forControlEvents:UIControlEventTouchUpInside];
        [self.voiceRecordBtn addTarget:self action:@selector(cancelRecordVoice:) forControlEvents:UIControlEventTouchUpOutside | UIControlEventTouchCancel];
        [self.voiceRecordBtn addTarget:self action:@selector(RemindDragExit:) forControlEvents:UIControlEventTouchDragExit];
        [self.voiceRecordBtn addTarget:self action:@selector(RemindDragEnter:) forControlEvents:UIControlEventTouchDragEnter];
        [_inputToolBarBgView addSubview:self.voiceRecordBtn];
    
        //emogi btn 初始化
        self.showEmogiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.showEmogiBtn.frame = CGRectMake(SCREEN_WIDTH-80, ChatBarTopSpaceHeight, 30, 30);
        [self.showEmogiBtn setBackgroundImage:[UIImage imageNamed:@"icon_Expression_nomal.png"] forState:UIControlStateNormal];
        [self.showEmogiBtn addTarget:self action:@selector(showEmogiViewAction:) forControlEvents:UIControlEventTouchUpInside];
        [_inputToolBarBgView addSubview:self.showEmogiBtn];
        
        //显示更多方式输入 btn
        self.moreViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.moreViewBtn.frame = CGRectMake(SCREEN_WIDTH-40, ChatBarTopSpaceHeight, 30, 30);
        [self.moreViewBtn setBackgroundImage:[UIImage imageNamed:@"keyboardMoreBtn.png"] forState:UIControlStateNormal];
        [self.moreViewBtn addTarget:self action:@selector(showMoreBtnsViewAction:) forControlEvents:UIControlEventTouchUpInside];
        [_inputToolBarBgView addSubview:self.moreViewBtn];
        
        //更多输入方式
        _moreView = [[UIView alloc] initWithFrame:CGRectMake(0, _currentChatBarHeight, SCREEN_WIDTH, KeyBoradHeight)];
        _moreView.backgroundColor = [UIColor lightGrayColor];
        [self insertSubview:_moreView atIndex:0];
        [self initializeMoreView];
        
        self.emojiView =[[EmojiPageView alloc]initWithFrame:CGRectMake(0,_currentChatBarHeight, SCREEN_WIDTH,KeyBoradHeight)];
        self.emojiView.delegate = self;
        [self addSubview:self.emojiView];
        self.emojiView.hidden = YES;

        //添加通知
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardDidShowOrHide:) name:UIKeyboardWillChangeFrameNotification object:nil];
    }
    return self;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
#pragma mark
#pragma mark -- private method
- (void) initializeMoreView{
    _moreImgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_moreImgBtn setTitle:@"相册" forState:UIControlStateNormal];
    _moreImgBtn.frame = CGRectMake(0, 0, 80, 80);
    _moreImgBtn.tag = 0;
    [_moreImgBtn addTarget:self action:@selector(moreBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_moreView addSubview:_moreImgBtn];
    
    _morePhotoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_morePhotoBtn setTitle:@"照相" forState:UIControlStateNormal];
    _morePhotoBtn.frame = CGRectMake(100, 0, 80, 80);
    _morePhotoBtn.tag = 1;
    [_morePhotoBtn addTarget:self action:@selector(moreBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_moreView addSubview:_morePhotoBtn];
    
    _moreVideoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_moreVideoBtn setTitle:@"视频" forState:UIControlStateNormal];
    _moreVideoBtn.frame = CGRectMake(200, 0, 80, 80);
    _moreVideoBtn.tag = 2;
    [_moreVideoBtn addTarget:self action:@selector(moreBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_moreView addSubview:_moreVideoBtn];
}

#pragma mark - 录音touch事件
- (void)beginRecordVoice:(UIButton *)button
{
    [recordAudio stopPlay];
    [recordAudio startRecord];
    playTime = 0;
    playTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countVoiceTime) userInfo:nil repeats:YES];
    [UUProgressHUD show];
}

- (void)endRecordVoice:(UIButton *)button
{
    if (playTimer) {
        recordFileUrl =  [recordAudio stopRecord];
        [self recordFinish];
        [playTimer invalidate];
        playTimer = nil;
    }
}

- (void)cancelRecordVoice:(UIButton *)button
{
    if (playTimer) {
        recordFileUrl = [recordAudio stopRecord];
        [playTimer invalidate];
        playTimer = nil;
    }
    [UUProgressHUD dismissWithError:@"取消"];
}

- (void)RemindDragExit:(UIButton *)button
{
    [UUProgressHUD changeSubTitle:@"松开取消"];
}

- (void)RemindDragEnter:(UIButton *)button
{
    [UUProgressHUD changeSubTitle:@"上滑取消"];
}
- (void)countVoiceTime
{
    playTime ++;
    if (playTime>=60) {
        [self endRecordVoice:nil];
    }
}

#pragma mark
#pragma mark -- more btn action method
- (void)moreBtnAction:(UIButton *) sender
{
    switch (sender.tag) {
        case 0:{
            [self openPicLibrary];
            break;
        }
        case 1:{
            [self addCarema];
            break;
        }
        case 3:{

            break;
        }
        default:
            break;
    }

}

#pragma mark
#pragma mark -- btn Action method 
//改变输入与录音状态
- (void)voiceRecordChangeAction:(UIButton *)sender
{
    self.voiceRecordBtn.hidden = !self.voiceRecordBtn.hidden;
    self.growingTextView.hidden  = !self.growingTextView.hidden;
    isbeginVoiceRecord = !isbeginVoiceRecord;
    _isShowMoreView = isbeginVoiceRecord;
    if (isbeginVoiceRecord) {
        [self.voiceTextStateBtn setBackgroundImage:[UIImage imageNamed:@"chat_ipunt_message"] forState:UIControlStateNormal];
        [self.growingTextView resignFirstResponder];
        if (_isShowMoreView) {
            self.frame = InputViewDefaultFrame;
            _isShowMoreView = NO;
            _isShowEmojiView = NO;
        }
    }else{
        [self.voiceTextStateBtn setBackgroundImage:[UIImage imageNamed:@"chat_voice_record"] forState:UIControlStateNormal];
        [self.growingTextView becomeFirstResponder];
    }
}

- (void)showMoreBtnsViewAction:(id) sender
{
    _isShowMoreView = !_isShowMoreView;
     _emojiView.hidden = YES;
    
    if (isbeginVoiceRecord) {
        [self.voiceTextStateBtn setBackgroundImage:[UIImage imageNamed:@"chat_ipunt_message"] forState:UIControlStateNormal];
        self.voiceRecordBtn.hidden = YES;
        self.growingTextView.hidden  = NO;
        isbeginVoiceRecord = NO;
    }
    if (_isShowMoreView) {
        if ([self.growingTextView isFirstResponder]) {
             [self.growingTextView resignFirstResponder];
        }else {
            if (!_isShowKeyBoard) {
                if ([_superVC isKindOfClass:[UUBaseMessageController class]]) {
                    UUBaseMessageController * controller = (UUBaseMessageController *)_superVC;
                    [controller  changeTableViewFrameByInputHeightGrowing:KeyBoradHeight+_currentChatBarHeight];
                }
                _isShowKeyBoard = YES;
            }
        }
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3f];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        self.frame = InputMoreTopFrame;
        _moreView.frame = EmojiViewFrame;
        _moreView.hidden = NO;
        [UIView commitAnimations];
  
    }else{
        [self.growingTextView becomeFirstResponder];
    }
}

- (void)showEmogiViewAction:(id) sender
{
    _isShowEmojiView = !_isShowEmojiView;
    if (_isShowEmojiView) {

    }else{

    }
    if (isbeginVoiceRecord) {
        [self.voiceTextStateBtn setBackgroundImage:[UIImage imageNamed:@"chat_ipunt_message"] forState:UIControlStateNormal];
        self.voiceRecordBtn.hidden = YES;
        self.growingTextView.hidden  = NO;
        isbeginVoiceRecord = NO;
    }
    if (_isShowEmojiView) {
        if ([self.growingTextView isFirstResponder]) {
            [self.growingTextView resignFirstResponder];
        }else {
            if (!_isShowKeyBoard) {
                if ([_superVC isKindOfClass:[UUBaseMessageController class]]) {
                    UUBaseMessageController * controller = (UUBaseMessageController *)_superVC;
                    [controller  changeTableViewFrameByInputHeightGrowing:KeyBoradHeight+_currentChatBarHeight];
                }
                _isShowKeyBoard = YES;
            }
        }
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3f];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        self.frame = InputMoreTopFrame;
        _emojiView.frame = EmojiViewFrame;
        _emojiView.hidden = NO;
        [UIView commitAnimations];
        
    }else{
        _emojiView.hidden = YES;
        [self.growingTextView becomeFirstResponder];
    }

}

- (void)hideMoreView{
    if (_isShowMoreView) {
        if ([self.growingTextView isFirstResponder]) {
            [self.growingTextView resignFirstResponder];
        }
        [UIView animateWithDuration:0.3f animations:^{
            self.frame = InputBottomFrame1;
        } completion:^(BOOL finish){
            self.frame = InputBottomFrame;
            _isShowMoreView = NO;
            
            if ([_superVC isKindOfClass:[UUBaseMessageController class]]) {
                UUBaseMessageController * controller = (UUBaseMessageController *)_superVC;
                [controller  changeTableViewFrameByInputHeightGrowing:KeyBoradHeight+_currentChatBarHeight];
            }
            _isShowKeyBoard = YES;
        }];
    }
}

#pragma mark
#pragma mark -- Keyboard methods  跟随键盘高度变化
-(void)keyboardDidShowOrHide:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    CGRect keyboardEndFrame;
    
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardEndFrame];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    CGRect newFrame = self.frame;
    newFrame.origin.y = keyboardEndFrame.origin.y - _currentChatBarHeight-TopBarHeight-20;
    newFrame.size.height = _currentChatBarHeight;
    self.frame = newFrame;
    [UIView commitAnimations];

    _currentKeyBoardHeight = keyboardEndFrame.size.height;
    
    if ([_superVC isKindOfClass:[UUBaseMessageController class]]) {
        UUBaseMessageController * controller = (UUBaseMessageController *)_superVC;
        
        if (keyboardEndFrame.origin.y < KeyBoradHideY) {
            [controller  changeTableViewFrameByInputHeightGrowing:_currentChatBarHeight+_currentKeyBoardHeight ];
            _isShowKeyBoard = YES;
            _isShowMoreView = NO;
            _isShowEmojiView = NO;
        }
        if (keyboardEndFrame.origin.y > KeyBoradHideY && !_isShowMoreView && !_isShowEmojiView) {
            _currentKeyBoardHeight = 0.0f;
            
            [controller  changeTableViewFrameByInputHeightGrowing:_currentKeyBoardHeight + _currentChatBarHeight ];
            _isShowKeyBoard = NO;
        }
    }
}
#pragma mark
#pragma mark --  发送消息（文字图片）
- (void)sendMessage:(UIButton *)sender
{
    if (self.growingTextView.text.length > 0) {
        [self.delegate UUInputFunctionView:self sendMessage:self.growingTextView.text];
        self.growingTextView.text = @"";
    }
}

#pragma mark -
#pragma mark HPGrowingTextViewDelegate
- (void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height {
    float diff = (growingTextView.frame.size.height - height);
    _currentChatBarHeight -= diff;
    
    CGRect inputToolBarBgViewFrame = _inputToolBarBgView.frame;
    inputToolBarBgViewFrame.size.height -= diff;
    _inputToolBarBgView.frame = inputToolBarBgViewFrame;
    
    CGRect selfFrame = self.frame;
    selfFrame.size.height -= diff;
    selfFrame.origin.y += diff;
    self.frame = selfFrame;
    
    if ([_superVC isKindOfClass:[UUBaseMessageController class]]) {
        UUBaseMessageController * controller = (UUBaseMessageController *)_superVC;
        [controller changeTableViewFrameByInputHeightGrowing:_currentChatBarHeight + _currentKeyBoardHeight];
    }
    _emojiView.frame = EmojiViewFrame;
}

- (void)growingTextViewDidEndEditing:(HPGrowingTextView *)growingTextView{
    textRange = growingTextView.selectedRange;
}
- (BOOL)growingTextViewShouldReturn:(HPGrowingTextView *)growingTextView {
    
    if ([growingTextView.text isEqualToString: @""]) {
        return NO;
    }else {
        [self sendMessage:nil];
        return YES;
    }
    return NO;
}

#pragma mark
#pragma mark -- Add Picture
-(void)addCarema{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self.superVC presentViewController:picker animated:YES completion:^{}];
    }else{
        //如果没有提示用户
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您的设备照相机不可用" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
}

-(void)openPicLibrary{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self.superVC presentViewController:picker animated:YES completion:^{
        }];
    }
}

#pragma mark
#pragma mark -- UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
   
    [self hideMoreView];
    [self.superVC dismissViewControllerAnimated:YES completion:^{
        UIImage *editImage = [info objectForKey:UIImagePickerControllerEditedImage];
        NSData *editImageData = UIImageJPEGRepresentation(editImage,0.8f);
        
        NSString * path;
        NSString * name = [NSString stringWithFormat:@"%lu_%@.jpg",(unsigned long)[CurrentAccount currentAccount].uid,[NSDate currentTimeByJava]];
        path = [[PathHelper cacheDirectoryPathWithName:CHAT_Img_Dir_Name] stringByAppendingPathComponent:name];
        [editImageData writeToFile:path atomically:YES];
        
        
        [ossUnity uploadFile:path withTargetSubPath:OSSMessagePath withBlock:^(BOOL status, NSString *alocalPathStr, NSString *aSubStr, NSString *resourceURLStr) {
            if (status) {
                NSString * toPathName = [resourceURLStr lastPathComponent];
                [editImageData writeToFile:[[PathHelper cacheDirectoryPathWithName:[resourceURLStr stringByDeletingLastPathComponent]] stringByAppendingPathComponent:toPathName] atomically:YES];
                [self.delegate UUInputFunctionView:self sendPicture:resourceURLStr];
            }else{
            }
        }];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self hideMoreView];
    [self.superVC dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark
#pragma mark -- Mp3RecorderDelegate
- (void)endConvertWithData:(NSData *)voiceData
{
    [self.delegate UUInputFunctionView:self sendVoice:@"" time:playTime+1];
    [UUProgressHUD dismissWithSuccess:@"成功"];
    
    //缓冲消失时间 (最好有block回调消失完成)
    self.voiceRecordBtn.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.voiceRecordBtn.enabled = YES;
    });
}

- (void)failRecord
{
    [UUProgressHUD dismissWithSuccess:@"太短"];
    
    //缓冲消失时间 (最好有block回调消失完成)
    self.voiceRecordBtn.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.voiceRecordBtn.enabled = YES;
    });
}
#pragma mark
#pragma mark -- RecordAudioDelegate
//0 播放 1 播放完成 2出错
-(void)RecordStatus:(int)status{

}
- (void) recordFinish{
    if (playTime < KSendMinTime) {
        [self failRecord];
        return;
    }
    NSString * path;
    if (recordFileUrl != nil) {
        curAudio = EncodeWAVEToAMR([NSData dataWithContentsOfURL:recordFileUrl],1,16);
        
        NSString * name = [NSString stringWithFormat:@"%lu_%@.amr",(unsigned long)[CurrentAccount currentAccount].uid,[NSDate currentTimeByJava]];
        path = [[PathHelper cacheDirectoryPathWithName:CHAT_MP3_Dir_Name] stringByAppendingPathComponent:name];
        [curAudio writeToFile:path atomically:YES];
    }
    
    [ossUnity uploadFile:path withTargetSubPath:OSSMessagePath withBlock:^(BOOL status, NSString *alocalPathStr, NSString *aSubStr, NSString *resourceURLStr) {
        if (status) {
            NSString * toPathName = [resourceURLStr lastPathComponent];
            [curAudio writeToFile:[[PathHelper cacheDirectoryPathWithName:[resourceURLStr stringByDeletingLastPathComponent]] stringByAppendingPathComponent:toPathName] atomically:YES];
            [self.delegate UUInputFunctionView:self sendVoice:resourceURLStr time:playTime+1];
            [UUProgressHUD dismissWithSuccess:@"成功"];
        }else{
            [UUProgressHUD dismissWithSuccess:@"失败"];
        }
    }];

    //缓冲消失时间 (最好有block回调消失完成)
    self.voiceRecordBtn.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.voiceRecordBtn.enabled = YES;
    });

}

-(void)emojiPageViewSelectString:(NSString *)emojiString
{
    self.growingTextView.selectedRange = textRange;
    [self.growingTextView.internalTextView insertText:emojiString];
    [self.growingTextView  textViewDidChange:self.growingTextView.internalTextView];
    textRange = self.growingTextView.selectedRange;
}



@end
