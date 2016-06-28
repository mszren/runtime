//
//  BangCommentCell.h
//  FamilysHelper
//
//  Created by 我 on 15/7/3.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"
#import "CXPhotoBrowser.h"

@interface BangCommentCell : UITableViewCell <EGOImageViewDelegate,MessageRoutable,CXPhotoBrowserDataSource,CXPhotoBrowserDelegate>
@property (nonatomic, strong) UIButton* btnComment;
@property (nonatomic, strong) UIButton* informButton;
@property (nonatomic, assign) NSInteger row;
@property (nonatomic, assign) NSInteger nextCurosr;

- (void)bindCommentModel:(CommentModel*)model row:(NSInteger)row;

@end
