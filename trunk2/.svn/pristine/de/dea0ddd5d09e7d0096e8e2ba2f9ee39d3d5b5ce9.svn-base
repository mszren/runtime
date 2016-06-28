//
//  AddFriendsSearchPhoneController.m
//  FamilysHelper
//
//  Created by 曹亮 on 15/3/20.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "AddFriendsSearchPhoneController.h"

@interface AddFriendsSearchPhoneController () <EGOImageViewDelegate>

@end

static XMPPManager* xmppManager = nil;
@implementation AddFriendsSearchPhoneController
@synthesize currentUser = _currentUser;

#pragma mark
#pragma mark-- init & delloc
- (id)init
{
    self = [super init];
    if (self) {
        xmppManager = [XMPPManager shareInstance];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = BGViewColor1;

    [self initializeNavTitleView:@"搜索结果"];
    [self initializeNavBackView];

    headImg = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@""] delegate:self];
    headImg.frame = CGRectMake(10, 30, 90, 90);
    [headImg setImageURL:[AppImageUtil getImageURL:_currentUser.face Size:headImg.frame.size]];
    [self.view addSubview:headImg];

    nickNameLab = [[UILabel alloc] initWithFrame:CGRectMake(120, 30, 100, 30)];
    nickNameLab.textColor = [UIColor blackColor];
    nickNameLab.backgroundColor = [UIColor clearColor];
    nickNameLab.text = _currentUser.nickname;
    [self.view addSubview:nickNameLab];

    phoneLab = [[UILabel alloc] initWithFrame:CGRectMake(120, 60, 100, 30)];
    phoneLab.textColor = [UIColor blackColor];
    phoneLab.backgroundColor = [UIColor clearColor];
    phoneLab.text = _currentUser.username;
    [self.view addSubview:phoneLab];

    addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setTitle:@"添加" forState:UIControlStateNormal];
    addBtn.backgroundColor = [UIColor lightGrayColor];
    [addBtn addTarget:self action:@selector(addBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    addBtn.frame = CGRectMake(SCREEN_WIDTH - 100, 40, 80, 40);
    [self.view addSubview:addBtn];

    if (self.currentUser.isF == 1) {
        addBtn.enabled = NO;
    }
    else {
        addBtn.enabled = YES;
    }
}

#pragma mark
#pragma mark-- nav item action
- (void)addBtnAction:(id)sender
{
    MessageInfoModel* messageInfoModel = [[MessageInfoModel alloc] initWithMessageContent:@"邀请你成为好友" withType:CHATINFO_BFD withToUser:_currentUser];
    messageInfoModel.chatType = CHATTYPE_CHAT;
    messageInfoModel.isSend = 1;

    [xmppManager.xmppMessageManager sendMessage:messageInfoModel];
}

@end
