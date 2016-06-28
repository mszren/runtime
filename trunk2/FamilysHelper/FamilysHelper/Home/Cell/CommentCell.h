//
//  CommentCell.h
//  FamilysHelper
//
//  Created by zhouwengang on 15/6/18.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MsgCommentModel.h"
@interface CommentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbl_createTime;
@property (weak, nonatomic) IBOutlet UILabel *lbl_NickName;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Content;
@property (strong, nonatomic) IBOutlet EGOImageView *iv_Face;


-(void) bindMsgModel:(MsgCommentModel*)model;

-(void) initView;
@end
