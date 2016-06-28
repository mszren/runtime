//
//  ActivityMemberCell.m
//  FamilysHelper
//
//  Created by 我 on 15/7/3.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "ActivityMemberCell.h"
#import "UIImageView+AFNetworking.h"

@implementation ActivityMemberCell {
    EGOImageView* _face;
    UILabel* _nickname;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        UIView* groundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 52)];
        groundView.backgroundColor = [UIColor whiteColor];
        [self addSubview:groundView];

        _face = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"pic_default_40x40"]];
        _face.frame = CGRectMake(10, 10, 32, 32);
        _face.layer.cornerRadius = 16;
        _face.clipsToBounds = YES;
        [groundView addSubview:_face];

        _nickname = [[UILabel alloc] initWithFrame:CGRectMake(52, 0, SCREEN_WIDTH - 52, 52)];
        _nickname.textColor = COLOR_GRAY_DEFAULT_OPAQUE_1f;
        _nickname.font = [UIFont systemFontOfSize:13];
        [groundView addSubview:_nickname];
    }
    return self;
}

- (void)bindModel:(ActivityListModel*)model
{
    if (![model.face isEqualToString:@""]) {
        [_face setImageWithURL:[AppImageUtil getImageURL:model.face Size:_face.frame.size]];
    }
    _nickname.text = model.nickname;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
