//
//  MemberCell.m
//  FamilysHelper
//
//  Created by zhouwengang on 15/7/2.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "MemberCell.h"
#import <CoreText/CoreText.h>
#import "UserInfoViewController.h"
@interface MemberCell () <EGOImageViewDelegate> {
    EGOImageView* _ivFace1;
    EGOImageView* _ivFace2;
    EGOImageView* _ivFace3;
    UILabel* _lbnickname1;
    UILabel* _lbnickname2;
    UILabel* _lbnickname3;
    UIView* _BGview1;
    UIView* _BGview2;
    UIView* _BGview3;
    User* _UserModel1;
    User* _UserModel2;
    User* _UserModel3;
}

@end
@implementation MemberCell
@synthesize messageListner;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        self.backgroundColor = [UIColor clearColor];

        _BGview1 = [[UIView alloc] init];
        _BGview1.frame = CGRectMake(10, 10, (SCREEN_WIDTH - 40) / 3, 135);
        _BGview1.backgroundColor = [UIColor whiteColor];
        [self addSubview:_BGview1];

        _ivFace1 = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"pic_default_60x60"]];
        _ivFace1.frame = CGRectMake(_BGview1.frame.size.width / 2 - 35, 10, 70, 70);
        _ivFace1.layer.cornerRadius = _ivFace1.bounds.size.width / 2;
        _ivFace1.delegate = self;
        _ivFace1.clipsToBounds = YES;
        _ivFace1.tag = 0;
        [_BGview1 addSubview:_ivFace1];

        _lbnickname1 = [[UILabel alloc] init];
        _lbnickname1.frame = CGRectMake(0, _ivFace1.frame.origin.y + _ivFace1.frame.size.height + 20, _BGview1.frame.size.width, 20);
        [_lbnickname1 setText:@"泡菜乐园"];
        _lbnickname1.textAlignment = NSTextAlignmentCenter;
        [_lbnickname1 setFont:TableCellTitleFont];
        [_lbnickname1 setTextColor:TableCellTitleColor];
        [_BGview1 addSubview:_lbnickname1];

        _BGview2 = [[UIView alloc] init];
        _BGview2.frame = CGRectMake((SCREEN_WIDTH - 40) / 3 + 20, 10, (SCREEN_WIDTH - 40) / 3, 135);
        _BGview2.backgroundColor = [UIColor whiteColor];
        [self addSubview:_BGview2];

        _ivFace2 = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"pic_default_60x60"]];
        _ivFace2.frame = CGRectMake(_BGview2.frame.size.width / 2 - 35, 10, 70, 70);
        _ivFace2.layer.cornerRadius = _ivFace2.bounds.size.width / 2;
        _ivFace2.delegate = self;
        _ivFace2.clipsToBounds = YES;
        _ivFace2.tag = 1;
        [_BGview2 addSubview:_ivFace2];

        _lbnickname2 = [[UILabel alloc] init];
        _lbnickname2.frame = CGRectMake(0, _ivFace2.frame.origin.y + _ivFace2.frame.size.height + 20, _BGview2.frame.size.width, 20);
        [_lbnickname2 setText:@"泡菜乐园"];
        _lbnickname2.textAlignment = NSTextAlignmentCenter;
        [_lbnickname2 setFont:TableCellTitleFont];
        [_lbnickname2 setTextColor:TableCellTitleColor];
        [_BGview2 addSubview:_lbnickname2];

        _BGview3 = [[UIView alloc] init];
        _BGview3.frame = CGRectMake(2 * (SCREEN_WIDTH - 40) / 3 + 30, 10, (SCREEN_WIDTH - 40) / 3, 135);
        _BGview3.backgroundColor = [UIColor whiteColor];
        [self addSubview:_BGview3];

        _ivFace3 = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"pic_default_60x60"]];
        _ivFace3.frame = CGRectMake(_BGview3.frame.size.width / 2 - 35, 10, 70, 70);
        _ivFace3.layer.cornerRadius = _ivFace3.bounds.size.width / 2;
        _ivFace3.clipsToBounds = YES;
        _ivFace3.tag = 2;
        _ivFace3.delegate = self;
        [_BGview3 addSubview:_ivFace3];

        _lbnickname3 = [[UILabel alloc] init];
        _lbnickname3.frame = CGRectMake(0, _ivFace3.frame.origin.y + _ivFace3.frame.size.height + 20, _BGview3.frame.size.width, 20);
        [_lbnickname3 setText:@"泡菜乐园"];
        _lbnickname3.textAlignment = NSTextAlignmentCenter;
        [_lbnickname3 setFont:TableCellTitleFont];
        [_lbnickname3 setTextColor:TableCellTitleColor];
        [_BGview3 addSubview:_lbnickname3];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)bindUserModel:(NSArray*)modellsit
{
    _BGview1.hidden = YES;
    _BGview2.hidden = YES;
    _BGview3.hidden = YES;

    if (modellsit.count > 0) {
        _UserModel1 = [modellsit objectAtIndex:0];
       
            [_ivFace1 setImageURL:[AppImageUtil getImageURL:_UserModel1.face Size:_ivFace1.frame.size]];
        

        [_lbnickname1 setText:_UserModel1.nickname];
        CATransition* animation = [CATransition animation];
        animation.type = kCATransitionFade;
        animation.duration = 0.4;
        [_BGview1.layer addAnimation:animation forKey:nil];
        _BGview1.hidden = NO;
    }
    if (modellsit.count > 1) {
        _UserModel2 = [modellsit objectAtIndex:1];
      
            [_ivFace2 setImageURL:[AppImageUtil getImageURL:_UserModel2.face Size:_ivFace2.frame.size]];

        [_lbnickname2 setText:_UserModel2.nickname];
        CATransition* animation = [CATransition animation];
        animation.type = kCATransitionFade;
        animation.duration = 0.4;
        [_BGview2.layer addAnimation:animation forKey:nil];
        _BGview2.hidden = NO;
    }
    else {
    }

    if (modellsit.count > 2) {
        _UserModel3 = [modellsit objectAtIndex:2];
        //if (![_UserModel3.face isEqual:@""])
            [_ivFace3 setImageURL:[AppImageUtil getImageURL:_UserModel3.face Size:_ivFace3.frame.size]];

        [_lbnickname3 setText:_UserModel3.nickname];
        CATransition* animation = [CATransition animation];
        animation.type = kCATransitionFade;
        animation.duration = 0.4;
        [_BGview3.layer addAnimation:animation forKey:nil];
        _BGview3.hidden = NO;
    }
    else {
    }
}

#pragma mark -
#pragma mark EGOImageViewDelegate

#define MSG_IMAGE_INDEX_CONTEXT_PHOTO1 0
#define MSG_IMAGE_INDEX_CONTEXT_PHOTO2 1
#define MSG_IMAGE_INDEX_CONTEXT_PHOTO3 2
- (void)imageViewDidTouched:(EGOImageView*)imageView
{
    NSString* phone;
    switch (imageView.tag) {

    case MSG_IMAGE_INDEX_CONTEXT_PHOTO1: {
        phone = _UserModel1.username;
        break;
    }
    case MSG_IMAGE_INDEX_CONTEXT_PHOTO2: {
        phone = _UserModel2.username;
        break;
    }
    case MSG_IMAGE_INDEX_CONTEXT_PHOTO3: {
        phone = _UserModel3.username;
        break;
    }
    default:
        phone = _UserModel1.username;
        break;
    }
    [messageListner RouteMessage:ACTION_SHOW_PERSON_USERINFO withContext:@{ ACTION_Controller_Name : messageListner, ACTION_Controller_Data : phone }];
}

@end
