//
//  MsgCell.h
//  FamilysHelper
//
//  Created by Owen on 15/5/28.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MsgModel.h"

@interface MsgCell : UITableViewCell <MessageRoutable>
@property (weak, nonatomic) IBOutlet UILabel* lbl_createTime;
@property (weak, nonatomic) IBOutlet UILabel* lbl_NickName;
@property (weak, nonatomic) IBOutlet UILabel* lbl_Content;
@property (strong, nonatomic) IBOutlet EGOImageView* iv_Face;

@property (weak, nonatomic) IBOutlet EGOImageView* iv_img1;

@property (weak, nonatomic) IBOutlet EGOImageView* iv_img2;

@property (weak, nonatomic) IBOutlet EGOImageView* iv_img3;

@property (weak, nonatomic) IBOutlet UIButton* btn_zan;
@property (weak, nonatomic) IBOutlet UIButton* btn_coment;
@property (weak, nonatomic) IBOutlet UIView* v_jianxi;

- (void)bindMsgModel:(MsgModel*)model type:(NSInteger)msg_type;

- (void)initView:(NSInteger)from_type;

@end
