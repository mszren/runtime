//
//  hudongCell.h
//  FamilysHelper
//
//  Created by zhouwengang on 15/6/5.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopicModel.h"
@interface hudongCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbl_createTime;
@property (weak, nonatomic) IBOutlet UILabel *lbl_title;
@property (weak, nonatomic) IBOutlet UILabel *lbl_hitNum;
@property (weak, nonatomic) IBOutlet UILabel *lbl_replyNum;
@property (strong, nonatomic) IBOutlet EGOImageView *iv_Face;
@property (strong, nonatomic) IBOutlet UIImageView *ic_pic;


-(void) bindMsgModel:(TopicModel*)model;

-(void) initView;
@end
