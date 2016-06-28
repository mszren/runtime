//
//  hotTribeView.h
//  FamilysHelper
//
//  Created by zhouwengang on 15/6/12.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataModel.h"

@interface HotTribeCell : UITableViewCell
@property (nonatomic,strong)EGOImageView *tribeImage;
@property (nonatomic,strong)EGOImageView *tribeImage3;
@property (nonatomic,strong)EGOImageView *tribeImage2;

-(void)bindTribe:(NSArray *)model ;

@end
