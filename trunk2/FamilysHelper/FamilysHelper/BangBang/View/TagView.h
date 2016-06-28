//
//  TagView.h
//  FamilysHelper
//
//  Created by Owen on 15/6/25.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TagModel.h"


@protocol TagViewDelegate <NSObject>
-(void)tagViewSelected:(TagModel*)tagModel;
@end
 
@interface TagView : UIView
@property (nonatomic,strong) NSArray *tagList;
@property (nonatomic,strong) TagModel *selectTag;
@property (nonatomic,assign) id<TagViewDelegate> delegate;


-(id)initWithFrame:(CGRect)frame Tags:(NSArray*)taglist;
@end
