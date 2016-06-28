//
//  AnswerView.h
//  FamilysHelper
//
//  Created by 我 on 15/7/1.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PublishAlbumTopView.h"
#import "UzysAssetsPickerController.h"
#import "CommentModel.h"
typedef void(^BlockAnswer)();

@interface AnswerView : UIView<UITextViewDelegate,UIScrollViewDelegate,MessageRoutable,PublishAlbumTopViewDelegate,UzysAssetsPickerControllerDelegate>
@property (nonatomic,assign)NSInteger hudongId;
@property (nonatomic,assign)NSInteger tribeId;
@property (nonatomic,assign)NSInteger typeId;
@property (nonatomic,assign)NSInteger parenteld;
@property (nonatomic,copy)CommentModel *replyCommentModel;
@property (nonatomic,assign)NSInteger floorNum;
@property (nonatomic,copy)BlockAnswer blockAnswer;

@end
