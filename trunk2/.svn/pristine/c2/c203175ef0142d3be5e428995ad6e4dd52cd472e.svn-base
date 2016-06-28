//
//  interactionView.m
//  FamilysHelper
//
//  Created by zhouwengang on 15/6/12.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "HotInteractionCell.h"
#import "TopicModel.h"
#import "IndexModel.h"
#import "MoreInteractionViewController.h"


#import "UIImageView+AFNetworking.h"

@implementation HotInteractionCell{
    UIImageView *_firstImage;
    UIImageView *_secondImage;
    UIImageView *_thirdImage;
    UILabel *_firstImageLabel;
    UILabel *_secondImageLabel;
    UILabel *_thirdImageLabel;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIView *interactionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH , 262)];
        interactionView.backgroundColor = [UIColor whiteColor];
        [self addSubview:interactionView];
        
        UILabel *topicLabel = [[UILabel alloc]initWithFrame:CGRectMake(22, 15, 100, 15)];
        topicLabel.text = @"热门互动";
        topicLabel.textColor = COLOR_GRAY_DEFAULT_30;
        topicLabel.font = [UIFont systemFontOfSize:13];
        [interactionView addSubview:topicLabel];
        
        UILabel *backgroundLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 2, 15)];
        backgroundLabel.backgroundColor = [UIColor orangeColor];
        [interactionView addSubview:backgroundLabel];
        
        UILabel *moreLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 62, 15, 40, 15)];
        moreLabel.text = @"更多";
        moreLabel.textAlignment = NSTextAlignmentRight;
        moreLabel.textColor = COLOR_GRAY_DEFAULT_185;
        moreLabel.font = [UIFont systemFontOfSize:13];
        [interactionView addSubview:moreLabel];
        
        UIImageView *distanceImage=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 17 , 17, 7,11)];
        distanceImage.image=[UIImage imageNamed:@"ic_arrow"];
        distanceImage.tag = 203;
        distanceImage.userInteractionEnabled = YES;
        [interactionView addSubview:distanceImage];
        
        _firstImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 45, 180, 205)];
        [interactionView addSubview:_firstImage];
        _firstImage.tag = 200;
        
        
        UIView *firstView = [[UIView alloc]initWithFrame:CGRectMake(0, _firstImage.bounds.size.height-30, _firstImage.bounds.size.width, 30)];
        firstView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
        [_firstImage addSubview:firstView];
        
        _firstImageLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, _firstImage.bounds.size.height - 25, 180, 15)];
        _firstImageLabel.textColor = COLOR_GRAY_DEFAULT_255;
        _firstImageLabel.font = [UIFont systemFontOfSize:12];
        _firstImage.userInteractionEnabled = YES;
        [_firstImage addSubview:_firstImageLabel];
        
        _secondImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 10 - 99, 45, 99, 99 )];
        [interactionView addSubview:_secondImage];
        _secondImage.tag = 201;
        _secondImage.userInteractionEnabled = YES;
    
        UIView *secondView = [[UIView alloc]initWithFrame:CGRectMake(0, _secondImage.bounds.size.height -30, _secondImage.bounds.size.width, 50)];
        secondView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
        [_secondImage addSubview:secondView];
        
        _secondImageLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, _secondImage.bounds.size.height - 20, 100, 15)];
        _secondImageLabel.textColor = COLOR_GRAY_DEFAULT_255;
        _secondImageLabel.font = [UIFont systemFontOfSize:12];
        [_secondImage addSubview:_secondImageLabel];
        
        _thirdImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 109,55 + _firstImage.bounds.size.height - 99, 99, 99)];
        [interactionView addSubview:_thirdImage];
        _thirdImage.tag = 202;
        _thirdImage.userInteractionEnabled = YES;
        
        UIView *thirdView = [[UIView alloc]initWithFrame:CGRectMake(0, _thirdImage.bounds.size.height -50 , _thirdImage.bounds.size.width, 50)];
        thirdView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
        [_thirdImage addSubview:thirdView];
        
        _thirdImageLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, _thirdImage.bounds.size.height - 20, 100, 15)];
        _thirdImageLabel.textColor = COLOR_GRAY_DEFAULT_255;
        _thirdImageLabel.font = [UIFont systemFontOfSize:12];
        [_thirdImage addSubview:_thirdImageLabel];
        
        UITapGestureRecognizer *tapImage = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTapImage:)];
        UITapGestureRecognizer *tapImage2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTapImage:)];
        UITapGestureRecognizer *tapImage3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTapImage:)];
        UITapGestureRecognizer *tapImage4 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTapImage:)];
        [_firstImage addGestureRecognizer:tapImage];
        [_secondImage addGestureRecognizer:tapImage2];
        [_thirdImage addGestureRecognizer:tapImage3];
        [distanceImage addGestureRecognizer:tapImage4];
    
    }
    return self;
}

-(void)bindTopic:(DataModel *)model{
    NSMutableArray *interactionArry = [[NSMutableArray alloc]initWithCapacity:0];
    [interactionArry addObjectsFromArray:((IndexModel *)model.data).interaction];
    [_firstImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_SERVER,((TopicModel *)interactionArry[0]).iconUrl]] placeholderImage:[UIImage imageNamed:@"presonHeadDefault"]];
    _firstImageLabel.text = ((TopicModel *)interactionArry[0]).topic;
    
    [_secondImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_SERVER,((TopicModel *)interactionArry[1]).iconUrl]] placeholderImage:[UIImage imageNamed:@"presonHeadDefault"]];
    _secondImageLabel.text = ((TopicModel *)interactionArry[1]).topic;
    
    [_thirdImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_SERVER,((TopicModel *)interactionArry[2]).iconUrl]] placeholderImage:[UIImage imageNamed:@"presonHeadDefault"]];
    _thirdImageLabel.text = ((TopicModel *)interactionArry[2]).topic;
    
    
    
}

-(void)onTapImage:(UITapGestureRecognizer *)sender{
 
    switch (sender.view.tag) {
        case 200:
            
            break;
        case 201:
            
            break;
        case 202:
            
            break;
            
            
        default:{
            MoreInteractionViewController *moreVc = [[MoreInteractionViewController alloc]init];
            [self.window.rootViewController presentViewController:moreVc animated:NO completion:nil];
        }
            
            
            
            break;
    }
    
 
    
    
}

@end
