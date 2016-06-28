//
//  GroupInfoListController.m
//  FamilysHelper
//
//  Created by 我 on 15/8/20.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "GroupInfoListController.h"
#import <Masonry/Masonry.h>
#import "HomeService.h"
#import "GroupModel.h"
#import "SearchController.h"
#import "GroupRedPacketController.h"
#import "SettingViewController.h"
#import "GrounpInfoModel.h"
#import "GroupMemberController.h"
#import "UserInfoViewController.h"
#import "ApplyView.h"

@interface GroupInfoListController ()<EGOImageViewDelegate>

@end

@implementation GroupInfoListController{
    
    EGOImageView *_groupImage;
    UILabel *_groupName;
    UILabel *_groupTime;
    
    UIButton *_redPacketCount;
    EGOImageView *_groupHostImage;
    UILabel *_groupHostName;
    UILabel *_groupCount;
    UITextView *_descripe;
    
    UIButton *_joinButton;
    
    MBProgressHUD *_hud;
    ASIHTTPRequest *_request;
    GrounpInfoModel *_fistGroupModel;
    GrounpInfoModel *_secondGroupModel;
    
    ApplyView *_applyView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    [self initData];
}

-(void)initView{
    
    [self initializeWhiteBackgroudView:@"群资料"];
    self.view.backgroundColor = COLOR_RED_DEFAULT_BackGround;
    
    [self addGroupView];
    [self addGroupHostView];
    [self addRedPacketView];
    [self addGroupMemberView];
    [self addDescripeView];
    [self addJoinButton];
    
}

-(void)addGroupView{
    UIView *groundView = [[UIView alloc]init];
    [self.view addSubview:groundView];
    [groundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(1);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 75));
    }];
    groundView.backgroundColor = [UIColor whiteColor];
    
    _groupImage = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"pic_default_40x40"]];
    [groundView addSubview:_groupImage];
    [_groupImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(18);
        make.size.mas_equalTo(CGSizeMake(39, 39));
    }];
    _groupImage.layer.cornerRadius = 39/2;
    _groupImage.clipsToBounds = YES;
    
    _groupName = [[UILabel alloc]init];
    [groundView addSubview:_groupName];
    [_groupName mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(59);
        make.top.mas_equalTo(23);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 96, 17));
    }];
    _groupName.font = [UIFont systemFontOfSize:17];
    _groupName.textColor = COLOR_GRAY_DEFAULT_OPAQUE_1f;
    
    _groupTime = [[UILabel alloc]init];
    [groundView addSubview:_groupTime];
    [_groupTime mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(59);
        make.top.mas_equalTo(50);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 96, 11));
    }];
    _groupTime.font = [UIFont systemFontOfSize:12];
    _groupTime.textColor = COLOR_GRAY_DEFAULT_OPAQUE_b9;
    
}

-(void)addRedPacketView{
    
    UIView *RedPacketView = [[UIView alloc]init];
    [self.view addSubview:RedPacketView];
    [RedPacketView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(85);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 44));
    }];
    RedPacketView.backgroundColor = [UIColor whiteColor];
    RedPacketView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapRedPacketView = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTapRedPacketView:)];
    [RedPacketView addGestureRecognizer:tapRedPacketView];
    
    UILabel *redpacketLabel = [[UILabel alloc]init];
    [RedPacketView addSubview:redpacketLabel];
    [redpacketLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(70, 44));
    }];
    redpacketLabel.font = [UIFont systemFontOfSize:15];
    redpacketLabel.text = @"群红包";
    redpacketLabel.textColor = COLOR_GRAY_DEFAULT_OPAQUE_1f;
    
    _redPacketCount = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [RedPacketView addSubview:_redPacketCount];
    [_redPacketCount mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(SCREEN_WIDTH - 50);
        make.top.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(23, 14));
    }];
    _redPacketCount.layer.cornerRadius = 6;
    _redPacketCount.clipsToBounds = YES;
    _redPacketCount.titleLabel.font = [UIFont systemFontOfSize:9];
    [_redPacketCount setTintColor:[UIColor whiteColor]];
    [_redPacketCount setBackgroundColor:COLOR_RED_DEFAULT_78];
    
    EGOImageView *redPackJumpImage = [[EGOImageView alloc]init];
    [RedPacketView addSubview:redPackJumpImage];
    [redPackJumpImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(SCREEN_WIDTH - 17);
        make.top.mas_equalTo(17);
        make.size.mas_equalTo(CGSizeMake(7, 11));
    }];
    redPackJumpImage.image = [UIImage imageNamed:@"ic_arrow@2x"];
    
}

-(void)addGroupHostView{
    
    UIView *groupHostView = [[UIView alloc]init];
    [self.view addSubview:groupHostView];
    [groupHostView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(130);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH , 44));
    }];
    groupHostView.backgroundColor = [UIColor whiteColor];
    groupHostView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapgroupHostView = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTapgroupHostView:)];
    [groupHostView addGestureRecognizer:tapgroupHostView];
    
    UILabel *hostLabel = [[UILabel alloc]init];
    [groupHostView addSubview:hostLabel];
    [hostLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(70, 44));
    }];
    hostLabel.textColor = COLOR_GRAY_DEFAULT_OPAQUE_1f;
    hostLabel.font = [UIFont systemFontOfSize:15];
    hostLabel.text = @"群主";
    
    _groupHostImage = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@""]];
    [groupHostView addSubview:_groupHostImage];
    [_groupHostImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(SCREEN_WIDTH - 112);
        make.top.mas_equalTo(5);
        make.size.mas_equalTo(CGSizeMake(34, 34));
    }];
    _groupHostImage.layer.cornerRadius = 17;
    _groupHostImage.clipsToBounds = YES;
    
    _groupHostName = [[UILabel alloc]init];
    [groupHostView addSubview:_groupHostName];
    [_groupHostName mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(SCREEN_WIDTH - 77);
        make.top.mas_equalTo(17);
        make.size.mas_equalTo(CGSizeMake(50, 11));
    }];
    _groupHostName.textAlignment = NSTextAlignmentRight;
    _groupHostName.font = [UIFont systemFontOfSize:12];
    _groupHostName.textColor = COLOR_GRAY_DEFAULT_OPAQUE_7a;
    
    
    EGOImageView *redPackJumpImage = [[EGOImageView alloc]init];
    [groupHostView addSubview:redPackJumpImage];
    [redPackJumpImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(SCREEN_WIDTH - 17);
        make.top.mas_equalTo(17);
        make.size.mas_equalTo(CGSizeMake(7, 11));
    }];
    redPackJumpImage.image = [UIImage imageNamed:@"ic_arrow@2x"];
    
}

-(void)addGroupMemberView{
    
    UIView *groupMemberView = [[UIView alloc]init];
    [self.view addSubview:groupMemberView];
    [groupMemberView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(175);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 44));
    }];
    groupMemberView.backgroundColor = [UIColor whiteColor];
    groupMemberView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapGroupMemberView = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTapGroupMemberView:)];
    [groupMemberView addGestureRecognizer:tapGroupMemberView];
    
    UILabel *groupMember = [[UILabel alloc]init];
    [groupMemberView addSubview:groupMember];
    [groupMember mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(70, 44));
    }];
    groupMember.font = [UIFont systemFontOfSize:15];
    groupMember.textColor = COLOR_GRAY_DEFAULT_OPAQUE_1f;
    groupMember.text = @"群成员";
    
    _groupCount = [[UILabel alloc]init];
    [groupMemberView addSubview:_groupCount];
    [_groupCount mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(SCREEN_WIDTH - 77);
        make.top.mas_equalTo(17);
        make.size.mas_equalTo(CGSizeMake(50, 11));
    }];
    _groupCount.textAlignment = NSTextAlignmentRight;
    _groupCount.font = [UIFont systemFontOfSize:12];
    _groupCount.textColor = COLOR_GRAY_DEFAULT_OPAQUE_7a;
    
    EGOImageView *redPackJumpImage = [[EGOImageView alloc]init];
    [groupMemberView addSubview:redPackJumpImage];
    [redPackJumpImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(SCREEN_WIDTH - 17);
        make.top.mas_equalTo(17);
        make.size.mas_equalTo(CGSizeMake(7, 11));
    }];
    redPackJumpImage.image = [UIImage imageNamed:@"ic_arrow@2x"];
}

-(void)addDescripeView{
    
    UIView *descripeView = [[UIView alloc]init];
    [self.view addSubview:descripeView];
    [descripeView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(230);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 100));
    }];
    descripeView.backgroundColor = [UIColor whiteColor];
    
    UILabel *descripeLabel = [[UILabel alloc]init];
    [descripeView addSubview:descripeLabel];
    [descripeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(50, 11));
    }];
    descripeLabel.text = @"介绍";
    descripeLabel.font = [UIFont systemFontOfSize:15];
    descripeLabel.textColor = [UIColor orangeColor];
    
    _descripe = [[UITextView alloc]init];
    [descripeView addSubview:_descripe];
    [_descripe mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(25);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20, 70));
    }];
    _descripe.backgroundColor = [UIColor whiteColor];
    _descripe.font = [UIFont systemFontOfSize:13];
    _descripe.textColor = COLOR_GRAY_DEFAULT_OPAQUE_7a;
    _descripe.editable = NO;
}

-(void)addJoinButton{
    
    _joinButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_joinButton];
    [_joinButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(340);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20, 40));
    }];
    [_joinButton setBackgroundColor:COLOR_RED_DEFAULT_78];
    [_joinButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _joinButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [_joinButton setTitle:@"申请加入" forState:UIControlStateNormal];
    [_joinButton addTarget:self action:@selector(onBtnJoin:) forControlEvents:UIControlEventTouchUpInside];
    _joinButton.layer.cornerRadius = 10;
    _joinButton.clipsToBounds = YES;
}

-(void)initData{
    
    if (_request) {
        [_request cancel];
    }
    
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _request = [[HomeService shareInstance]getGroupInfoV6:_currentUserMessageModel.name onSuccess:^(DataModel *dataModel) {
        if (dataModel.code == 200) {
            
            _fistGroupModel = dataModel.data[0];
            _secondGroupModel = dataModel.data[1];
            [self bindData];
        }
        else{
            
            [ToastManager showToast:dataModel.error withTime:Toast_Hide_TIME];
        }
        
        _hud.hidden = YES;
    }];
}

-(void)bindData{
    
    [_groupImage setImageURL:[AppImageUtil getImageURL:_fistGroupModel.group_image_url Size:_groupImage.frame.size]];
    [_redPacketCount setTitle:[NSString stringWithFormat:@"%d",_fistGroupModel.count] forState:UIControlStateNormal];
    [_groupHostImage setImageURL:[AppImageUtil getImageURL:_secondGroupModel.group_image_url Size:_groupHostImage.frame.size]];
    _groupHostName.text = _secondGroupModel.naturalName;
    _groupCount.text = [NSString stringWithFormat:@"%d",_fistGroupModel.memberNumber];
    _descripe.text = _fistGroupModel.groupDescription;
    _groupName.text = _fistGroupModel.naturalName;
    _groupTime.text = [NSDate dateYMDTimeInterval:_fistGroupModel.creationDate.doubleValue];
}

#pragma mark
#pragma mark -- UITapGestureRecognizer
-(void)onTapRedPacketView:(UITapGestureRecognizer *)sender{
    
    GroupRedPacketController * controller = [[GroupRedPacketController  alloc] init];
    controller.hidesBottomBarWhenPushed = YES;
    controller.currentGroupModel = _currentUserMessageModel;
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)onTapgroupHostView:(UITapGestureRecognizer *)sender{
    
    
    UserInfoViewController *userInfoVc = [[UserInfoViewController alloc]init];
    userInfoVc.phone = _secondGroupModel.name;
    userInfoVc.userId = _secondGroupModel.memberNumber;
    userInfoVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:userInfoVc animated:YES];
}

-(void)onTapGroupMemberView:(UITapGestureRecognizer *)sender{
    GroupMemberController *groupMemberVc = [[GroupMemberController alloc]init];
    groupMemberVc.name = _fistGroupModel.name;
    groupMemberVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:groupMemberVc animated:YES];
}

#pragma mark
#pragma mark -- UIButtonAction
-(void)onBtnJoin:(UIButton *)sender{
    
    _applyView = [[ApplyView alloc]init];
    [self.view.window addSubview:_applyView];
    [_applyView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT));
    }];
    _applyView.userID = [CurrentAccount currentAccount].uid;
    _applyView.roomID = _fistGroupModel.roomID;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

@end
