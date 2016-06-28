//
//  HotActivityCell.m
//  FamilysHelper
//
//  Created by xujie on 15/7/15.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "HotActivityCell.h"
#import <CoreText/CoreText.h>
#import "UIImageView+AFNetworking.h"
#import "HotActivityModel.h"
#import "ActionConfig.h"
#import "ActivityModel.h"
@implementation HotActivityCell{
    HotActivityModel* hotActivityModel;
    NSMutableArray* _hotActivityArry;
    
    EGOImageView* _imageUrl;
    UILabel* _imageUrlLabel;
    UIImageView* _statusView1;
    
    EGOImageView* _imageUrl2;
    UILabel* _imageUrlLabel2;
    UIImageView* _statusView2;

    
    EGOImageView* _imageUrl3;
    UILabel* _imageUrlLabel3;
    UIImageView* _statusView3;

    
    EGOImageView* _imageUrl4;
    UILabel* _imageUrlLabel4;
    UIImageView* _statusView4;

 }
@synthesize messageListner;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel* topicLabel = [[UILabel alloc] initWithFrame:CGRectMake(22, 15, 100, 15)];
        topicLabel.text = @"热门活动";
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
        [moreButton addTarget:self action:@selector(onActivityAll:) forControlEvents:UIControlEventTouchUpInside];
        
        moreButton.titleEdgeInsets = UIEdgeInsetsMake(0, -moreButton.imageView.frame.size.width, 0, moreButton.imageView.frame.size.width);
        moreButton.imageEdgeInsets = UIEdgeInsetsMake(0, moreButton.titleLabel.frame.size.width + 15, 0, 0);
        [self addSubview:moreButton];
        NSInteger width = (SCREEN_WIDTH - 30) / 6;
        
        _imageUrl = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"pic_default_60x60"]];
        _imageUrl.frame = CGRectMake(10, 45, 3*width, 2*width);
        
        [self addSubview:_imageUrl];
        _imageUrl.userInteractionEnabled = YES;
        
        
        _statusView1=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width,width)];
        [_imageUrl addSubview:_statusView1];
        
        UIView* uiView = [[UIView alloc] initWithFrame:CGRectMake(0, _imageUrl.bounds.size.height - 30, _imageUrl.bounds.size.width, 30)];
        uiView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
        [_imageUrl addSubview:uiView];
        
        _imageUrlLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _imageUrl.bounds.size.height - 20, 100, 15)];
        _imageUrlLabel.textColor = COLOR_GRAY_DEFAULT_255;
        _imageUrlLabel.font = [UIFont systemFontOfSize:12];
        [_imageUrl addSubview:_imageUrlLabel];
        
        _imageUrl2 = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"pic_default_60x60"]];
        _imageUrl2.frame = CGRectMake(20 + _imageUrl.frame.size.width, 45, 3*width, 2*width);
        [self addSubview:_imageUrl2];
        _imageUrl2.userInteractionEnabled = YES;
        
        _statusView2=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, width)];
        [_imageUrl2 addSubview:_statusView2];

        UIView* uiView2 = [[UIView alloc] initWithFrame:CGRectMake(0, _imageUrl2.bounds.size.height - 30, _imageUrl2.bounds.size.width, 30)];
        uiView2.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
        [_imageUrl2 addSubview:uiView2];
        
        _imageUrlLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(10, _imageUrl2.bounds.size.height - 20, 100, 15)];
        _imageUrlLabel2.textColor = COLOR_GRAY_DEFAULT_255;
        _imageUrlLabel2.font = [UIFont systemFontOfSize:12];
        [_imageUrl2 addSubview:_imageUrlLabel2];
        
        _imageUrl3 = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"pic_default_60x60"]];
        _imageUrl3.frame = CGRectMake(10, 55 + 2*width, 3*width, 2*width);
        [self addSubview:_imageUrl3];
        _imageUrl3.userInteractionEnabled = YES;
        
        _statusView3=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, width)];
        [_imageUrl3 addSubview:_statusView3];

        UIView* uiView3 = [[UIView alloc] initWithFrame:CGRectMake(0, _imageUrl3.bounds.size.height - 30, _imageUrl3.bounds.size.width, 30)];
        uiView3.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
        [_imageUrl3 addSubview:uiView3];
        
        _imageUrlLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(10, _imageUrl3.bounds.size.height - 20, 100, 15)];
        _imageUrlLabel3.textColor = COLOR_GRAY_DEFAULT_255;
        _imageUrlLabel3.font = [UIFont systemFontOfSize:12];
        [_imageUrl3 addSubview:_imageUrlLabel3];
        
        
        _imageUrl4 = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"pic_default_60x60"]];
        _imageUrl4.frame = CGRectMake(20 + _imageUrl3.frame.size.width, 55 + 2*width, 3*width, 2*width);
        [self addSubview:_imageUrl4];
        _imageUrl4.userInteractionEnabled = YES;
        
        _statusView4=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, width)];
        [_imageUrl4 addSubview:_statusView4];

        UIView* uiView4 = [[UIView alloc] initWithFrame:CGRectMake(0, _imageUrl4.bounds.size.height - 30, _imageUrl4.bounds.size.width, 30)];
        uiView4.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
        [_imageUrl4 addSubview:uiView4];
        
        _imageUrlLabel4 = [[UILabel alloc] initWithFrame:CGRectMake(10, _imageUrl4.bounds.size.height - 20, 100, 15)];
        _imageUrlLabel4.textColor = COLOR_GRAY_DEFAULT_255;
        _imageUrlLabel4.font = [UIFont systemFontOfSize:12];
        [_imageUrl4 addSubview:_imageUrlLabel4];


        UIView* separatorView = [[UIView alloc] init];
        separatorView.frame = CGRectMake(0, _imageUrl4.frame.origin.y + _imageUrl4.frame.size.height + 10, SCREEN_WIDTH, 10);
        separatorView.backgroundColor = COLOR_RED_DEFAULT_BackGround;
        [self addSubview:separatorView];
    }
    return self;
}

- (void)bindActivity:(DataModel*)model
{
    _hotActivityArry= [[NSMutableArray alloc] initWithCapacity:0];
    if(!model){
        return;
    }
    NSArray *dataArray=model.data;
    if(dataArray.count>0){
        for (id data in dataArray) {
            [_hotActivityArry addObject:[HotActivityModel JsonParse:data]];
        }
        if(((HotActivityModel*)_hotActivityArry[0]).activityImage){
            [_imageUrl setImageURL:[AppImageUtil getImageURL:((HotActivityModel*)_hotActivityArry[0]).activityImage Size:_imageUrl.frame.size]];
        }
       _imageUrlLabel.text =((HotActivityModel*)_hotActivityArry[0]).activityTitle;
        [self isStatus:((HotActivityModel*)_hotActivityArry[0]).activityStatus uiImageView:_statusView1];
        _imageUrl.tag=[((HotActivityModel*)_hotActivityArry[0]).activityId integerValue];
        UITapGestureRecognizer* tapHit1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onSenderActivity:)];
        [_imageUrl addGestureRecognizer:tapHit1];

        if(_hotActivityArry[1]){
            if(((HotActivityModel*)_hotActivityArry[1]).activityImage){
                [_imageUrl2 setImageURL:[AppImageUtil getImageURL:((HotActivityModel*)_hotActivityArry[1]).activityImage Size:_imageUrl2.frame.size]];
            }
            _imageUrlLabel2.text =((HotActivityModel*)_hotActivityArry[1]).activityTitle;
            [self isStatus:((HotActivityModel*)_hotActivityArry[1]).activityStatus uiImageView:_statusView2];
            _imageUrl2.tag=[((HotActivityModel*)_hotActivityArry[1]).activityId integerValue];
            UITapGestureRecognizer* tapHit2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onSenderActivity:)];
            [_imageUrl2 addGestureRecognizer:tapHit2];
        }

        if(_hotActivityArry[2]){
            if(((HotActivityModel*)_hotActivityArry[2]).activityImage){
                [_imageUrl3 setImageURL:[AppImageUtil getImageURL:((HotActivityModel*)_hotActivityArry[2]).activityImage Size:_imageUrl3.frame.size]];
            }
            _imageUrlLabel3.text =((HotActivityModel*)_hotActivityArry[2]).activityTitle;
            [self isStatus:((HotActivityModel*)_hotActivityArry[2]).activityStatus uiImageView:_statusView3];
            _imageUrl3.tag=[((HotActivityModel*)_hotActivityArry[2]).activityId integerValue];
            UITapGestureRecognizer* tapHit3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onSenderActivity:)];
            [_imageUrl3 addGestureRecognizer:tapHit3];
        }
        
        if(_hotActivityArry[3]){
            if(((HotActivityModel*)_hotActivityArry[3]).activityImage){
                [_imageUrl4 setImageURL:[AppImageUtil getImageURL:((HotActivityModel*)_hotActivityArry[3]).activityImage Size:_imageUrl4.frame.size]];
            }
            _imageUrlLabel4.text =((HotActivityModel*)_hotActivityArry[3]).activityTitle;
            [self isStatus:((HotActivityModel*)_hotActivityArry[3]).activityStatus uiImageView:_statusView4];
            _imageUrl4.tag=[((HotActivityModel*)_hotActivityArry[3]).activityId integerValue];
            UITapGestureRecognizer* tapHit4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onSenderActivity:)];
            [_imageUrl4 addGestureRecognizer:tapHit4];

        }
    }
   
}
-(void)isStatus:(NSString*)status uiImageView:(UIImageView*)statusView{
    if ([@"0" isEqualToString:status]) {
        [statusView setImage:[UIImage imageNamed:@"ic_wks_hdz"]];
    }
    else if ([@"1" isEqualToString:status]) {
        
        [statusView setImage:[UIImage imageNamed:@"ic_jxz_hdz"]];
        
    }
    else if ([@"2" isEqualToString:status]){
        
        [statusView setImage:[UIImage imageNamed:@"ic_yjs_hdz"]];
        
    }
}

#pragma mark
#pragma mark-- buttonAction
- (void)onActivityAll:(UIButton*)sender
{
    NSDictionary* dic = [NSDictionary
                         dictionaryWithObjectsAndKeys:messageListner, ACTION_Controller_Name, nil];
    [messageListner RouteMessage:ACTION_SHOW_MORE_ACTIVITY
                     withContext:dic];
}


- (void)onSenderActivity:(id)sender
{
        UITapGestureRecognizer *tap = (UITapGestureRecognizer*)sender;
        UIView *tapView =tap.view;
    ActivityModel *activitymodel =[ActivityModel alloc];
    activitymodel.activityId=tapView.tag;
    NSDictionary* dic = @{ ACTION_Controller_Name : messageListner, ACTION_Controller_Data : activitymodel};
    [messageListner RouteMessage:ACTION_SHOW_BANGBANG_ACTIVITYDETAIL
                     withContext:dic];
    activitymodel=nil;
}


@end
