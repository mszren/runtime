//
//  HomeInfoController.h
//  FamilysHelper
//
//  Created by zhouwengang on 15/6/17.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MsgModel.h"
@interface HomeInfoController : BaseViewController {
    UITextField* _tf_comment;
    UIButton* _btncomment;
}
@property (nonatomic, strong) MsgModel* msgModel;
@end
