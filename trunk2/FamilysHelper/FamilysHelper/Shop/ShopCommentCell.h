//
//  ShopCommentCell.h
//  FamilysHelper
//
//  Created by 我 on 15/7/5.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"
#import "CXPhotoBrowser.h"

@interface ShopCommentCell : UITableViewCell<EGOImageViewDelegate,CXPhotoBrowserDelegate,CXPhotoBrowserDataSource>
-(void)bindcomment:(CommentModel *)model;
@property (nonatomic,strong)UIButton *informButton;

@end
