//
//  ChatHomeCell.m
//  FamilysHelper
//
//  Created by 曹亮 on 15/3/16.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "ChatHomeDefaultCell.h"


@implementation ChatHomeDefaultCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}


- (void)setViewDefault
{
    
    UIView * myGroupView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2, TableChatHomeCellHeight)];

    UIImageView * myGroupImg = [[UIImageView alloc] initWithFrame:CGRectMake(TableLeftSpaceWidth,  TableTopSpaceWidth, TableCellLeftImgWidth, TableCellLeftImgWidth)];
    myGroupImg.image = [UIImage imageNamed:@"myGroupsBtn.png"];
    myGroupImg.userInteractionEnabled = YES;
    [myGroupView addSubview:myGroupImg];

    UILabel * myGroupLab1 = [[UILabel alloc] init];
    myGroupLab1.backgroundColor = [UIColor clearColor];
    myGroupLab1.text = @"亲友群";
    myGroupLab1.font = TableCellTitleFont;
    myGroupLab1.textColor = TableCellTitleColor;
    myGroupLab1.textAlignment = NSTextAlignmentLeft;
    myGroupLab1.frame = CGRectMake(TableLeftSpaceWidth + TableCellLeftImgWidth+TableLeftImageSpaceWidth, TableTopSpaceWidth, 100, 25);
    [myGroupView addSubview:myGroupLab1];

    UILabel * myGroupLab2 = [[UILabel alloc] init];
    myGroupLab2.backgroundColor = [UIColor clearColor];
    myGroupLab2.text = @"我的一度亲友";
    myGroupLab2.textAlignment = NSTextAlignmentLeft;
    myGroupLab2.frame = CGRectMake(TableLeftSpaceWidth + TableCellLeftImgWidth+TableLeftImageSpaceWidth, TableTopSpaceWidth+25, 100, 20);
    myGroupLab2.font = TableCellDescFont;
    myGroupLab2.textColor = TableCellDescColor;
    [myGroupView addSubview:myGroupLab2];
    [self addSubview:myGroupView];

}


@end
