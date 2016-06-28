//
//  SelectTopicView.h
//  FamilysHelper
//
//  Created by zhouwengang on 15/7/16.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^BlockComment)();
@interface SelectTopicView : UIView
@property (nonatomic,assign)NSInteger type;
@property (nonatomic,copy)BlockComment blockComment;
@property (nonatomic,strong)UILabel *lb_all;
@property (nonatomic,strong)UILabel *lb_new;
@property (nonatomic,strong)UILabel *lb_lz;
@end
