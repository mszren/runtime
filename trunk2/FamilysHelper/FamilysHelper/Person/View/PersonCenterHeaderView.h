//
//  PersonCenterHeaderView.h
//  FamilysHelper
//
//  Created by Owen on 15/6/2.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXPhotoBrowser.h"
@interface PersonCenterHeaderView : UIView <EGOImageViewDelegate, CXPhotoBrowserDataSource, CXPhotoBrowserDelegate, MessageRoutable>
// user info key for Dictionary
extern NSString* const XHUserNameKey;
extern NSString* const XHBirthdayKey;
// user info
@property (nonatomic, strong) EGOImageView* avatarButton;
@property (nonatomic, strong) UILabel* userNameLabel;
@property (nonatomic, strong) UILabel* birthdayLabel;
@property (nonatomic, strong) NSString* avatarUrlString;
- (void)setViewDefault;
- (void)setAvatarUrlString:(NSString*)avatarUrlString;
- (void)setInfo:(NSDictionary*)info;
@end
