//
//  SettingViewController.h
//  FamilysHelper
//
//  Created by zhouwengang on 15/6/9.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIView *clearcache;
@property (weak, nonatomic) IBOutlet UIView *resetpwd;
@property (weak, nonatomic) IBOutlet UIView *setstarttime;
@property (weak, nonatomic) IBOutlet UILabel *starttime;
@property (weak, nonatomic) IBOutlet UILabel *endtime;
@property (weak, nonatomic) IBOutlet UILabel *versioncode;
@property (weak, nonatomic) IBOutlet UIView *version;
@property (weak, nonatomic) IBOutlet UIView *setendtime;
@property (weak, nonatomic) IBOutlet UIView *about;
@property (weak, nonatomic) IBOutlet UISwitch *settime;
@property (weak, nonatomic) IBOutlet UIButton *outButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)loginOut:(id)sender;
@end
