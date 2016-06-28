//
//  PersonCenterHeaderView.m
//  FamilysHelper
//
//  Created by Owen on 15/6/2.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "PersonCenterHeaderView.h"
#import "UserInfoViewController.h"
NSString* const XHUserNameKey = @"XHUserName";
NSString* const XHBirthdayKey = @"XHBirthday";

@implementation PersonCenterHeaderView
@synthesize messageListner;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)setViewDefault
{
    _avatarButton = [[EGOImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - 32, 80, 64, 64)];
    _avatarButton.layer.cornerRadius = _avatarButton.bounds.size.width / 2;
    _avatarButton.clipsToBounds = YES;
    _avatarButton.delegate = self;
    _userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 155, SCREEN_WIDTH, 22)];
    _userNameLabel.textAlignment = NSTextAlignmentCenter;
    _userNameLabel.textColor = [UIColor whiteColor];
    _userNameLabel.font = [UIFont boldSystemFontOfSize:20];
    //设置阴影
    _userNameLabel.shadowColor = [UIColor blackColor];
    _userNameLabel.shadowOffset = CGSizeMake(0.5, 0.5);
    _birthdayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 185, SCREEN_WIDTH, 22)];
    _birthdayLabel.textAlignment = NSTextAlignmentCenter;
    _birthdayLabel.textColor = [UIColor whiteColor];
    //设置阴影
    _birthdayLabel.shadowColor = [UIColor blackColor];
    _birthdayLabel.shadowOffset = CGSizeMake(0.5, 0.5);

    UIImageView* bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pic_bg"]];
    bgView.frame = self.bounds;
    [self addSubview:bgView];
    [self addSubview:_avatarButton];
    [self addSubview:_userNameLabel];
    [self addSubview:_birthdayLabel];
}

// avatar

- (void)setAvatarUrlString:(NSString*)UrlString
{
    if (UrlString) {
        _avatarUrlString = UrlString;
        if (_avatarUrlString == nil || [@"" isEqualToString:_avatarUrlString]) {
            [_avatarButton setImage:[UIImage imageNamed:@"ic_face"]];
        }
        else {
            [_avatarButton setImageURL:[AppImageUtil getImageURL:_avatarUrlString Size:_avatarButton.frame.size]];
        }
    }
}

// set info
- (void)setInfo:(NSDictionary*)info
{
    NSString* userName = [info valueForKey:XHUserNameKey];
    if (userName) {
        self.userNameLabel.text = userName;
    }

    NSString* birthday = [info valueForKey:XHBirthdayKey];
    if (birthday) {
        self.birthdayLabel.text = birthday;
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
- (void)imageViewDidTouched:(EGOImageView*)imageView
{
    [messageListner RouteMessage:ACTION_SHOW_SYSTEM_PhotoView
                     withContext:@{ ACTION_Controller_Name : messageListner,
                         ACTION_Controller_Data : @{ @"index" : [NSString stringWithFormat:@"%d", 0], @"dataSource" : self } }];
}

#pragma mark -
#pragma mark CXPhotoBrowserDataSource
- (NSUInteger)numberOfPhotosInPhotoBrowser:(CXPhotoBrowser*)photoBrowser
{
    return 1;
}
- (id<CXPhotoProtocol>)photoBrowser:(CXPhotoBrowser*)photoBrowser photoAtIndex:(NSUInteger)index
{
    CXPhoto* photo = [[CXPhoto alloc] initWithURL:[NSURL URLWithString:getOriginalImage(_avatarUrlString)]];
    return photo;
}
#pragma mark -
#pragma mark CXPhotoBrowserDelegate
- (void)photoBrowser:(CXPhotoBrowser*)photoBrowser didChangedToPageAtIndex:(NSUInteger)index
{
}

- (void)photoBrowser:(CXPhotoBrowser*)photoBrowser didFinishLoadingWithCurrentImage:(UIImage*)currentImage
{
}
- (BOOL)supportReload
{
    return NO;
}

@end
