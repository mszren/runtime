//
//  AddressBookCell.m
//  qeebuConference
//
//  Created by caoliang on 13-9-24.
//  Copyright (c) 2013年 caoliang. All rights reserved.
//

#import "User.h"
#import "AddressBookCell.h"
#import "UserInfoViewController.h"

@interface AddressBookCell () <EGOImageViewDelegate>{
    
    User *_userModel;
}

@end

#define UserLabelWidth 250
#define UserLabelHeight 20
#define padding 20

@implementation AddressBookCell
@synthesize addressBookCellDelegate = _addressBookCellDelegate;
@synthesize messageListner;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}
- (void)setCellDefault
{
    self.backgroundColor = [UIColor clearColor];

    headImg = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"pic_default_40x40"] delegate:self];
    headImg.layer.cornerRadius = 22.0f;
    headImg.layer.masksToBounds = YES;
    headImg.contentMode = UIViewContentModeScaleAspectFit;
    headImg.frame = CGRectMake(TableLeftSpaceWidth, 10, TableCellHeaderImageWidth, TableCellHeaderImageWidth);
    headImg.backgroundColor = [UIColor clearColor];
    headImg.userInteractionEnabled = YES;
    [self addSubview:headImg];
    

    nameLab = [[UILabel alloc] initWithFrame:CGRectMake(85, 20, 255, UserLabelHeight)];
    nameLab.font = TableCellTitleFont;
    nameLab.backgroundColor = [UIColor clearColor];
    [self addSubview:nameLab];
}

- (void)setCellData:(User*)aUser
{
    currentUser = aUser;
    nameLab.text = aUser.nickname;
}

- (void)cancelAllBtnImageLoad
{
    [headImg cancelImageLoad];
}

- (void)loadHeadImg:(User*)userModel
{
    _userModel = userModel;
    [headImg setImageURL:[AppImageUtil getImageURL:userModel.face Size:headImg.frame.size]];
}

- (void)ChatBtnAction:(id)sender
{
    if ([self.addressBookCellDelegate respondsToSelector:@selector(showChatChatContact:)]) {
        [self.addressBookCellDelegate showChatChatContact:currentUser];
    }
    else {
    }
}
#pragma mark -
#pragma mark EGOImageViewDelegate
- (void)imageViewLoadedImage:(EGOImageView*)imageView
{
    imageView.contentMode = UIViewContentModeScaleAspectFit;
}
- (void)imageViewFailedToLoadImage:(EGOImageView*)imageView error:(NSError*)error
{
    imageView.contentMode = UIViewContentModeScaleAspectFit;
}


@end
