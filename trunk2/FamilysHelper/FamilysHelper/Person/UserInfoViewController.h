//
//  UserInfoViewController.h
//  WeShare
//
//  Created by Elliott on 13-5-16.
//  Copyright (c) 2013年 Elliott. All rights reserved.
//

#import <UIKit/UIKit.h>
#import  "User.h"
#import "CXPhotoBrowser.h"

@interface UserInfoViewController : BaseViewController<EGOImageViewDelegate,CXPhotoBrowserDataSource,CXPhotoBrowserDelegate>
@property (strong, nonatomic) IBOutlet UILabel *lb_nickname;
@property (strong, nonatomic) IBOutlet UILabel *lb_birthday;
@property (strong, nonatomic) IBOutlet UILabel *lb_age;
@property (strong, nonatomic) IBOutlet UILabel *lb_city;
@property (strong, nonatomic) IBOutlet UILabel *lb_commitity;
@property (strong, nonatomic) IBOutlet UILabel *lb_addr;
@property (strong, nonatomic) IBOutlet UILabel *lb_sign;
@property (strong, nonatomic) IBOutlet UIButton *but_sex;
@property (strong, nonatomic) IBOutlet EGOImageView *iv_Face;
@property (strong, nonatomic) IBOutlet UIButton *bt_button;
@property(nonatomic, assign) NSInteger userId;
@property(nonatomic, strong) User *user;
@property(nonatomic, strong) NSString* phone;
@property(nonatomic, strong) NSString* nickname;
@property(nonatomic, strong) NSString* birthday;
@property(nonatomic, strong) NSString* sex;
@property(nonatomic, strong) NSString* face;
@property(nonatomic, strong) NSString *cityId;
@property(nonatomic, strong) NSString *communityId;
@property(nonatomic, strong) NSString *signature;
@property(nonatomic, strong) NSString* address;
@end
