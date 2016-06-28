//
//  UUMessageCell.m
//  UUChatDemoForTextVoicePicture
//
//  Created by shake on 14-8-27.
//  Copyright (c) 2014年 uyiuyao. All rights reserved.
//

#import "UUMessageCell.h"

#import "UUMessageFrame.h"
#import "UUAVAudioPlayer.h"
#import "UIImageView+AFNetworking.h"
#import "UUImageAvatarBrowser.h"

#import "RecordAudio.h"
#import "RedPacketViewCell.h"
#import "AppImageUtil.h"

#define ChatMargin 10 //间隔
#define ChatIconWH 44 //头像宽高height、width
#define ChatPicWH 200 //图片宽高
#define ChatContentW 180 //内容宽度

#define ChatTimeMarginW 15 //时间文本与边框间隔宽度方向
#define ChatTimeMarginH 10 //时间文本与边框间隔高度方向

#define ChatContentTop 15 //文本内容与按钮上边缘间隔
#define ChatContentLeft 25 //文本内容与按钮左边缘间隔
#define ChatContentBottom 15 //文本内容与按钮下边缘间隔
#define ChatContentRight 15 //文本内容与按钮右边缘间隔

#define ChatTimeFont [UIFont systemFontOfSize:11] //时间字体

@interface UUMessageCell () <UUAVAudioPlayerDelegate, EGOImageButtonDelegate, RecordAudioDelegate, RedPacketViewCellDelegate> {
    RecordAudio* recordAudio;
    NSString* voiceURL;
    NSData* _songData;

    UUAVAudioPlayer* audio;

    UIView* headImageBackView;

    UILabel* _inviteLab;
    UIButton* _inviteAgreeBtn;
    UIButton* _inviteDisAgreeBtn;

    RedPacketViewCell* _redPacketViewCell;
}
@end

@implementation UUMessageCell

#pragma mark
#pragma mark-- initialize
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];

        // 1、创建时间
        self.labelTime = [[UILabel alloc] init];
        self.labelTime.textAlignment = NSTextAlignmentCenter;
        self.labelTime.textColor = [UIColor grayColor];
        self.labelTime.font = ChatTimeFont;
        self.labelTime.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.labelTime];

        // 2、创建头像
        headImageBackView = [[UIView alloc] init];
        headImageBackView.layer.cornerRadius = 22;
        headImageBackView.layer.masksToBounds = YES;
        headImageBackView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.4];
        [self.contentView addSubview:headImageBackView];
        self.btnHeadImage = [[EGOImageButton alloc] initWithPlaceholderImage:[UIImage imageNamed:@""] delegate:self];
        self.btnHeadImage.layer.cornerRadius = 20;
        self.btnHeadImage.layer.masksToBounds = YES;
        [self.btnHeadImage addTarget:self action:@selector(btnHeadImageClick:) forControlEvents:UIControlEventTouchUpInside];
        [headImageBackView addSubview:self.btnHeadImage];

        self.stateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.stateBtn setImage:[UIImage imageNamed:@"sendMessageFailed.png"] forState:UIControlStateNormal];
        [self.stateBtn addTarget:self action:@selector(stateBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        self.stateBtn.hidden = YES;
        [self.contentView addSubview:self.stateBtn];

        // 3、创建头像下标
        self.labelNum = [[UILabel alloc] init];
        self.labelNum.textColor = [UIColor grayColor];
        self.labelNum.textAlignment = NSTextAlignmentCenter;
        self.labelNum.font = ChatTimeFont;
        [self.contentView addSubview:self.labelNum];

        // 4、创建内容
        self.btnContent = [UUMessageContentButton buttonWithType:UIButtonTypeCustom];
        [self.btnContent setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.btnContent.titleLabel.font = ChatContentFont;
        self.btnContent.titleLabel.numberOfLines = 0;
        [self.btnContent addTarget:self action:@selector(btnContentClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.btnContent];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UUAVAudioPlayerDidFinishPlay) name:@"VoicePlayHasInterrupt" object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark
#pragma mark-- btnHeadImageClick action
- (void)btnHeadImageClick:(UIButton*)button
{
    if ([self.delegate respondsToSelector:@selector(headImageDidClick:userId:)]) {
        [self.delegate headImageDidClick:self userId:[NSString stringWithFormat:@"%d", self.messageFrame.messageInfoModel.msgId]];
    }
}
#pragma mark
#pragma mark-- 重发操作
- (void)stateBtnAction:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(messageState:withModel:)]) {
        [self.delegate messageState:self withModel:self.messageFrame.messageInfoModel];
    }
}
#pragma mark
#pragma mark-- 音频操作
- (void)btnContentClick
{
    //play audio
    if (self.messageFrame.messageInfoModel.chatInfoType == CHATINFO_FIL_Voice) {
        if (!recordAudio) {
            recordAudio = [[RecordAudio alloc] init];
            recordAudio.delegate = self;
        }
        if ([FilePathHandler checkFileExist:self.messageFrame.messageInfoModel.content]) {
            [recordAudio play:_songData];
        }
        else {
            [ToastManager showToast:Toast_NetWork_Bad withTime:Toast_Hide_TIME];
        }
    }
    //show the picture
    else if (self.messageFrame.messageInfoModel.chatInfoType == CHATINFO_FIL_IMG) {
        if (self.btnContent.backImageView) {
            [UUImageAvatarBrowser showImage:self.btnContent.backImageView];
        }
        if ([self.delegate isKindOfClass:[UIViewController class]]) {
            [[(UIViewController*)self.delegate view] endEditing:YES];
        }
    }
    // show text and gonna copy that
    else if (self.messageFrame.messageInfoModel.chatInfoType == CHATINFO_NML) {
        [self.btnContent becomeFirstResponder];
        UIMenuController* menu = [UIMenuController sharedMenuController];
        [menu setTargetRect:self.btnContent.frame inView:self.btnContent.superview];
        [menu setMenuVisible:YES animated:YES];
    }
}

- (void)UUAVAudioPlayerBeiginLoadVoice
{
    [self.btnContent benginLoadVoice];
}
- (void)UUAVAudioPlayerBeiginPlay
{
    [self.btnContent didLoadVoice];
}
- (void)UUAVAudioPlayerDidFinishPlay
{
    [self.btnContent stopPlay];
    [[UUAVAudioPlayer sharedInstance] stopSound];
}

#pragma mark
#pragma mark--  //内容及Frame设置
- (void)setMessageFrame:(UUMessageFrame*)messageFrame
{
    _messageFrame = messageFrame;

    MessageInfoModel* lMessageInfoModel = messageFrame.messageInfoModel;

    // 1、设置时间
    self.labelTime.text = [NSDate daySinceTimeInterval:lMessageInfoModel.time.doubleValue / 1000.0f];
    self.labelTime.frame = messageFrame.timeF;

    // 2、设置头像
    headImageBackView.frame = messageFrame.iconF;
    self.btnHeadImage.frame = CGRectMake(2, 2, ChatIconWH - 4, ChatIconWH - 4);

    // 3、设置下标
    self.labelNum.text = lMessageInfoModel.toUser.nickname;
    if (lMessageInfoModel.isSend == 1) {
        self.labelNum.frame = CGRectMake(messageFrame.nameF.origin.x - 18, messageFrame.nameF.origin.y + 3, 60, messageFrame.nameF.size.height);
        self.labelNum.textAlignment = NSTextAlignmentRight;
    }
    else {
        self.labelNum.frame = CGRectMake(messageFrame.nameF.origin.x, messageFrame.nameF.origin.y + 3, 60, messageFrame.nameF.size.height);
        self.labelNum.textAlignment = NSTextAlignmentLeft;
    }

    // 4、设置内容
    [self.btnContent setTitle:@"" forState:UIControlStateNormal];
    self.btnContent.voiceBackView.hidden = YES;
    self.btnContent.backImageView.hidden = YES;

    self.btnContent.frame = messageFrame.contentF;

    if (lMessageInfoModel.isSend == 1) {
        self.btnContent.isMyMessage = YES;
        [self.btnContent setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.btnContent.contentEdgeInsets = UIEdgeInsetsMake(ChatContentTop, ChatContentRight, ChatContentBottom, ChatContentLeft);

        if (lMessageInfoModel.state == FAIL) {
            self.stateBtn.hidden = NO;
            self.stateBtn.frame = CGRectMake(self.btnContent.frame.origin.x - 50, self.btnContent.frame.origin.y, 30, 30);
        }
        else {
            self.stateBtn.hidden = YES;
        }
    }
    else {
        self.btnContent.isMyMessage = NO;
        [self.btnContent setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.btnContent.contentEdgeInsets = UIEdgeInsetsMake(ChatContentTop, ChatContentLeft, ChatContentBottom, ChatContentRight);

        self.stateBtn.hidden = YES;
    }

    if (_redPacketViewCell) {
        _redPacketViewCell.hidden = YES;
    }

    [self.btnContent removeContentDataText];
    switch (lMessageInfoModel.chatInfoType) {
    case CHATINFO_NML:
        [self.btnContent setContentDataText:lMessageInfoModel.content withFrom:lMessageInfoModel.isSend];
        break;
    case CHATINFO_FIL_IMG: {
        self.btnContent.backImageView.hidden = NO;
        [self.btnContent.backImageView setImageWithURL:[FilePathHandler getFileUrl:lMessageInfoModel.content withType:CHATINFO_FIL_IMG]];
    } break;
    case CHATINFO_FIL_Voice: {
        self.btnContent.voiceBackView.hidden = NO;

        if ([FilePathHandler checkFileExist:lMessageInfoModel.content]) {
            if (lMessageInfoModel.voiceLength) {
                self.btnContent.second.text = lMessageInfoModel.voiceLength;
            }
            else {
                _songData = [[NSData alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[FilePathHandler changeLocalFilePath:lMessageInfoModel.content]]];
                if (_songData) {
                    self.btnContent.second.text = [NSString stringWithFormat:@"%1.0f'' ", [RecordAudio getAudioTime:_songData]];
                    lMessageInfoModel.voiceLength = self.btnContent.second.text;
                }
                else {
                }
            }
        }
        else {
            NSURL* url = [NSURL URLWithString:lMessageInfoModel.content];
            NSMutableURLRequest* lrequest = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:RequestFileTimeOutInterval];

            NSString* targePath = [FilePathHandler changeLocalFilePath:lMessageInfoModel.content];
            AFDownloadRequestOperation* operation = [[AFDownloadRequestOperation alloc] initWithRequest:lrequest targetPath:targePath shouldResume:YES];

            [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation* loperation, id responseObject) {
                _songData = [[NSData alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[FilePathHandler changeLocalFilePath:lMessageInfoModel.content]]];
                if (_songData) {
                    self.btnContent.second.text = [NSString stringWithFormat:@"%1.0f'' ", [RecordAudio getAudioTime:_songData]];
                    lMessageInfoModel.voiceLength = self.btnContent.second.text;
                }
                else {
                }
            } failure:^(AFHTTPRequestOperation* loperation, NSError* error) {
                if ([loperation isExecuting]) {

                    NSLog(@"Error: %@", error);
                }

            }];
            [operation start];
        }
    } break;
    case CHATINFO_BFD:
        if (!_inviteLab) {
            if (_isFriend) {
                _inviteLab = [[UILabel alloc] initWithFrame:CGRectMake(80, 50, 150, 30)];
                _inviteLab.backgroundColor = [UIColor clearColor];
                _inviteLab.textColor = [UIColor blackColor];
                _inviteLab.font = FONT_SIZE_16;
                _inviteLab.text = @"申请成为您的好友";
                [self.contentView addSubview:_inviteLab];

                _inviteDisAgreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                _inviteDisAgreeBtn.frame = CGRectMake(130, 80, 120, 40);
                _inviteDisAgreeBtn.backgroundColor = [UIColor clearColor];
                [_inviteDisAgreeBtn setTitle:@"已经通过验证" forState:UIControlStateNormal];
                [_inviteDisAgreeBtn setTitleColor:HomeNavBarBgColor forState:UIControlStateNormal];
                _inviteDisAgreeBtn.titleLabel.font = FONT_SIZE_14;
                [self.contentView addSubview:_inviteDisAgreeBtn];
            }
            else {
                _inviteLab = [[UILabel alloc] initWithFrame:CGRectMake(80, 50, 150, 30)];
                _inviteLab.backgroundColor = [UIColor clearColor];
                _inviteLab.textColor = [UIColor blackColor];
                _inviteLab.font = FONT_SIZE_16;
                _inviteLab.text = @"申请成为您的好友";
                [self.contentView addSubview:_inviteLab];

                _inviteAgreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                _inviteAgreeBtn.frame = CGRectMake(130, 80, 40, 40);
                [_inviteAgreeBtn setTitle:@"同意" forState:UIControlStateNormal];
                [_inviteAgreeBtn addTarget:self action:@selector(inviteFriendsAgreeAction:) forControlEvents:UIControlEventTouchUpInside];
                [_inviteAgreeBtn setTitleColor:HomeNavBarBgColor forState:UIControlStateNormal];
                _inviteAgreeBtn.titleLabel.font = FONT_SIZE_14;
                [self.contentView addSubview:_inviteAgreeBtn];

                _inviteDisAgreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                _inviteDisAgreeBtn.frame = CGRectMake(180, 80, 40, 40);
                [_inviteDisAgreeBtn setTitle:@"忽略" forState:UIControlStateNormal];
                [_inviteDisAgreeBtn addTarget:self action:@selector(inviteFriendsAction:) forControlEvents:UIControlEventTouchUpInside];
                [_inviteDisAgreeBtn setTitleColor:HomeNavBarBgColor forState:UIControlStateNormal];
                _inviteDisAgreeBtn.titleLabel.font = FONT_SIZE_14;
                [self.contentView addSubview:_inviteDisAgreeBtn];
            }
        }
        break;
    case CHATINFO_YFM:
        [self.btnContent setContentDataText:lMessageInfoModel.content withFrom:lMessageInfoModel.isSend];
        break;

    case CHATINFO_RED:
        if (!_redPacketViewCell) {
            _redPacketViewCell = [[RedPacketViewCell alloc] initWithFrame:CGRectMake(80, 50, 160, 100)];
            _redPacketViewCell.delegate = self;
            [self.contentView addSubview:_redPacketViewCell];
        }
        _redPacketViewCell.hidden = NO;
        [_redPacketViewCell setRedPacketViewCellData:lMessageInfoModel.content];
        break;
    default:
        break;
    }

    //背景气泡图
    UIImage* normal;
    if (lMessageInfoModel.isSend == 1) {
        normal = [UIImage imageNamed:@"chatto_bg_normal"];
        normal = [normal resizableImageWithCapInsets:UIEdgeInsetsMake(35, 10, 10, 22)];
    }
    else {
        normal = [UIImage imageNamed:@"chatfrom_bg_normal"];
        normal = [normal resizableImageWithCapInsets:UIEdgeInsetsMake(35, 22, 10, 10)];
    }

    [self.btnContent setBackgroundImage:normal forState:UIControlStateNormal];
    [self.btnContent setBackgroundImage:normal forState:UIControlStateHighlighted];
}
#pragma mark
#pragma mark-- btn action method

- (void)inviteFriendsAction:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(inviteFriends:)]) {
        [self.delegate inviteFriends:NO];
    }
}
- (void)inviteFriendsAgreeAction:(id)sender
{
    _inviteAgreeBtn.hidden = YES;
    [_inviteDisAgreeBtn setTitle:@"已通过验证" forState:UIControlStateNormal];
    _inviteDisAgreeBtn.frame = CGRectMake(130, 80, 120, 40);
    _inviteDisAgreeBtn.enabled = NO;
    if ([self.delegate respondsToSelector:@selector(inviteFriends:)]) {
        [self.delegate inviteFriends:YES];
    }
}

#pragma mark
#pragma mark-- EGOImageButtonDelegate
- (void)imageButtonLoadedImage:(EGOImageButton*)imageButton
{
}
- (void)imageButtonFailedToLoadImage:(EGOImageButton*)imageButton error:(NSError*)error
{
}
- (void)imageIsExistLoadedImage:(EGOImageButton*)imageButton
{
}

#pragma mark
#pragma mark-- image load
- (void)cancelAllBtnImageLoad
{
    [_btnHeadImage cancelImageLoad];
}

- (void)loadHeadImg:(UUMessageFrame*)aUUMessageFrame
{
    if (aUUMessageFrame.messageInfoModel.isSend == 1) {
        [self.btnHeadImage setImageURL:[AppImageUtil getImageURL:[CurrentAccount currentAccount].face Size:self.btnHeadImage.frame.size]];
    }
    else {
        [self.btnHeadImage setImageURL:[AppImageUtil getImageURL:aUUMessageFrame.messageInfoModel.toUser.face Size:self.btnHeadImage.frame.size]];
    }
}
#pragma mark
#pragma mark-- RecordAudioDelegate
//0 播放 1 播放完成 2出错
- (void)RecordStatus:(int)status
{

    if (status == 0) {
        [self.btnContent didLoadVoice];
    }
    else if (status == 1) {
        [self.btnContent stopPlay];
    }
    else {
    }
}

#pragma mark
#pragma mark-- RedPacketViewCellDelegate
- (void)tapRedPacket
{
    if ([self.delegate respondsToSelector:@selector(tapRedPacketAction:)]) {
        [self.delegate tapRedPacketAction:_messageFrame.messageInfoModel];
    }
}
@end
