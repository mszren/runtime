//
//  interactionView.m
//  FamilysHelper
//
//  Created by zhouwengang on 15/6/12.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "InteractCell.h"
#import "TopicModel.h"
#import "IndexModel.h"
#import "MoreInteractionViewController.h"
#import "TopicDetailController.h"

#import "UIImageView+AFNetworking.h"

@implementation InteractCell {

    UILabel* _firstImageLabel;
    UILabel* _secondImageLabel;
    UILabel* _thirdImageLabel;
    NSMutableArray* _interactionArry;
    TopicModel* _topicModel;
}
@synthesize messageListner;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        UILabel* topicLabel = [[UILabel alloc] initWithFrame:CGRectMake(22, 15, 100, 15)];
        topicLabel.text = @"热门互动";
        topicLabel.textColor = COLOR_GRAY_DEFAULT_30;
        topicLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:topicLabel];

        UILabel* backgroundLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 2, 15)];
        backgroundLabel.backgroundColor = [UIColor orangeColor];
        [self addSubview:backgroundLabel];

        UIButton* moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        moreButton.frame = CGRectMake(SCREEN_WIDTH - 57, 15, 60, 15);
        [moreButton setTitle:@"更多" forState:UIControlStateNormal];
        moreButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [moreButton setTitleColor:COLOR_GRAY_DEFAULT_185 forState:UIControlStateNormal];
        [moreButton setImage:[UIImage imageNamed:@"ic_arrow"] forState:UIControlStateNormal];
        [moreButton addTarget:self action:@selector(onBtnMore:) forControlEvents:UIControlEventTouchUpInside];

        moreButton.titleEdgeInsets = UIEdgeInsetsMake(0, -moreButton.imageView.frame.size.width, 0, moreButton.imageView.frame.size.width);
        moreButton.imageEdgeInsets = UIEdgeInsetsMake(0, moreButton.titleLabel.frame.size.width + 15, 0, 0);
        [self addSubview:moreButton];

        NSInteger width = (SCREEN_WIDTH - 30) / 3;

        _firstImage = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"pic_default_95x95"]];
        _firstImage.frame = CGRectMake(10, 45, width * 2, width * 2 + 10);

        [self addSubview:_firstImage];
        _firstImage.tag = 200;

        UIView* firstView = [[UIView alloc] initWithFrame:CGRectMake(0, _firstImage.bounds.size.height - 30, _firstImage.bounds.size.width, 30)];
        firstView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
        [_firstImage addSubview:firstView];

        _firstImageLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _firstImage.bounds.size.height - 25, 180, 15)];
        _firstImageLabel.textColor = COLOR_GRAY_DEFAULT_255;
        _firstImageLabel.font = [UIFont systemFontOfSize:12];
        _firstImage.userInteractionEnabled = YES;
        [_firstImage addSubview:_firstImageLabel];

        _secondImage = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"pic_default_60x60"]];
        _secondImage.frame = CGRectMake(20 + _firstImage.frame.size.width, 45, width, width);
        [self addSubview:_secondImage];
        _secondImage.userInteractionEnabled = YES;
        _secondImage.tag = 201;

        UIView* secondView = [[UIView alloc] initWithFrame:CGRectMake(0, _secondImage.bounds.size.height - 30, _secondImage.bounds.size.width, 30)];
        secondView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
        [_secondImage addSubview:secondView];

        _secondImageLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _secondImage.bounds.size.height - 20, 100, 15)];
        _secondImageLabel.textColor = COLOR_GRAY_DEFAULT_255;
        _secondImageLabel.font = [UIFont systemFontOfSize:12];
        [_secondImage addSubview:_secondImageLabel];

        _thirdImage = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"pic_default_60x60"]];
        _thirdImage.frame = CGRectMake(20 + _firstImage.frame.size.width, 55 + width, width, width);
        [self addSubview:_thirdImage];
        _thirdImage.tag = 202;
        _thirdImage.userInteractionEnabled = YES;

        UIView* thirdView = [[UIView alloc] initWithFrame:CGRectMake(0, _thirdImage.bounds.size.height - 30, _thirdImage.bounds.size.width, 30)];
        thirdView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
        [_thirdImage addSubview:thirdView];

        _thirdImageLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _thirdImage.bounds.size.height - 20, 100, 15)];
        _thirdImageLabel.textColor = COLOR_GRAY_DEFAULT_255;
        _thirdImageLabel.font = [UIFont systemFontOfSize:12];
        [_thirdImage addSubview:_thirdImageLabel];

        UIView* separatorView = [[UIView alloc] init];
        separatorView.frame = CGRectMake(0, _thirdImage.frame.origin.y + _thirdImage.frame.size.height + 10, SCREEN_WIDTH, 10);
        separatorView.backgroundColor = COLOR_RED_DEFAULT_BackGround;
        [self addSubview:separatorView];
    }
    return self;
}

- (void)bindTopic:(DataModel*)model
{
    _interactionArry = [[NSMutableArray alloc] initWithCapacity:0];
    [_interactionArry addObjectsFromArray:((IndexModel*)model.data).interaction];

    [_firstImage setImageURL:[AppImageUtil getImageURL:((TopicModel*)_interactionArry[0]).iconUrl Size:_firstImage.frame.size]];

    _firstImageLabel.text = ((TopicModel*)_interactionArry[0]).topic;

    [_secondImage setImageURL:[AppImageUtil getImageURL:((TopicModel*)_interactionArry[1]).iconUrl Size:_secondImage.frame.size]];
    _secondImageLabel.text = ((TopicModel*)_interactionArry[1]).topic;

    [_thirdImage setImageURL:[AppImageUtil getImageURL:((TopicModel*)_interactionArry[2]).iconUrl Size:_thirdImage.frame.size]];

    _thirdImageLabel.text = ((TopicModel*)_interactionArry[2]).topic;
}

#pragma mark
#pragma mark-- buttonAction

- (void)onBtnMore:(UIButton*)sender
{
    NSDictionary* dic = [NSDictionary
        dictionaryWithObjectsAndKeys:messageListner, ACTION_Controller_Name, nil];
    [messageListner RouteMessage:ACTION_SHOW_MORE_INTERACTION
                     withContext:dic];
}

@end
