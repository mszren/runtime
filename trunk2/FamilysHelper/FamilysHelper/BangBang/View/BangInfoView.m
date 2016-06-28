//
//  BangInfoView.m
//  FamilysHelper
//
//  Created by Owen on 15/6/6.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "BangInfoView.h"
#import "TribeModel.h"
#import <CoreText/CoreText.h>
#import "TagModel.h"
#import "TribeService.h"

@interface BangInfoView () {
    EGOImageView* _ivLogo;
    UILabel* _lblTitle;
    UILabel* _lblAttentionNum;
    TribeModel* _model;
    UIButton* _btnAttention;
}
@end

@implementation BangInfoView

- (id)init
{
    self = [super init];
    if (self) {

        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 85);
        self.backgroundColor = [UIColor whiteColor];
        _ivLogo = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"pic_default_60x60"]];
        _ivLogo.frame = CGRectMake(10, 15, 55, 55);
        _ivLogo.layer.cornerRadius = 3.0;
        _ivLogo.clipsToBounds = YES;

        [self addSubview:_ivLogo];

        _lblTitle = [[UILabel alloc] init];

        [_lblTitle setFont:TableCellTitleFont];
        [_lblTitle setTextColor:TableCellTitleColor];
        [self addSubview:_lblTitle];

        _Attentionbut = [UIButton buttonWithType:UIButtonTypeCustom];

        [_Attentionbut setImage:[UIImage imageNamed:@"table_ic_gz"] forState:UIControlStateNormal];
        _Attentionbut.frame = CGRectMake(_lblTitle.frame.origin.x + _lblTitle.frame.size.width + 5, _lblTitle.frame.origin.y, _Attentionbut.frame.size.width, _Attentionbut.frame.size.height);

        [self addSubview:_Attentionbut];

        _lblAttentionNum = [[UILabel alloc] init];
        _lblAttentionNum.frame = CGRectMake(_Attentionbut.frame.origin.x + _Attentionbut.frame.size.width + 5, _Attentionbut.frame.origin.y, 50, 20);
        [_lblAttentionNum setFont:FONT_SIZE_14];
        [_lblAttentionNum setTextColor:TextColorRed];

        [self addSubview:_lblAttentionNum];

        _btnAttention = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _btnAttention.backgroundColor = HomeNavBarBgColor;
        _btnAttention.frame = CGRectMake(SCREEN_WIDTH - 70, 15, 60, 25);
        [_btnAttention.layer setCornerRadius:5];

        [_btnAttention addTarget:self action:@selector(attentionAction:) forControlEvents:UIControlEventTouchUpInside];

        [_btnAttention setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:_btnAttention];

        _btnqiandao = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _btnqiandao.backgroundColor = TabBarColor;
        _btnqiandao.frame = CGRectMake(SCREEN_WIDTH - 70, 45, 60, 25);
        [_btnqiandao.layer setCornerRadius:5];

        [_btnqiandao setTitle:@"签到" forState:UIControlStateNormal];
        [_btnqiandao setTitle:@"签到" forState:UIControlStateHighlighted];
        [_btnqiandao setTitleColor:TextColorRed forState:UIControlStateNormal];
        [self addSubview:_btnqiandao];

        UIView* separatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 84, SCREEN_WIDTH, 1)];
        [separatorView setBackgroundColor:AllTableViewColor];
        [self addSubview:separatorView];
    }
    return self;
}

- (void)bindTribe:(TribeModel*)model
{

    _model = model;

    if (![_model.shopLogo isEqualToString:@""]) {
        [_ivLogo setImageURL:[AppImageUtil getImageURL:_model.shopLogo Size:_ivLogo.frame.size]];
    }

    CGSize size = [model.shopName sizeWithFont:_lblTitle.font constrainedToSize:CGSizeMake(MAXFLOAT, _lblTitle.frame.size.height)];
    NSInteger w = _btnqiandao.frame.origin.x - 120;
    if (size.width > w) {
        _lblTitle.numberOfLines = 2;
        [_lblTitle setFrame:CGRectMake(_ivLogo.frame.origin.x + _ivLogo.frame.size.width + 10, 20, w, 40)];
    }
    else {
        [_lblTitle setFrame:CGRectMake(_ivLogo.frame.origin.x + _ivLogo.frame.size.width + 10, 20, size.width, 20)];
    }

    [_Attentionbut setFrame:CGRectMake(_lblTitle.frame.origin.x + _lblTitle.frame.size.width, _lblTitle.frame.origin.y, 30, 20)];
    [_lblAttentionNum setFrame:CGRectMake(_Attentionbut.frame.origin.x + _Attentionbut.frame.size.width, _Attentionbut.frame.origin.y, 30, 20)];

    [_lblTitle setText:model.shopName];

    [_lblAttentionNum setText:[NSString stringWithFormat:@"%ld", (long)model.attentionNum]];
 
    if (model.tagsList && model.tagsList.count > 0) {
        NSInteger _xPosition = 70;
        NSInteger _yPosition = 50;
        NSInteger _tagWidth = 40;
        for (TagModel* tag in model.tagsList) {

            UILabel* temp = [[UILabel alloc] init];
            [temp setFont:FONT_SIZE_12];
            NSString* strTagName = [NSString stringWithFormat:@"#%@#", tag.tagsName];
            CGRect labelRect = [strTagName boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 20) options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)attributes:[NSDictionary dictionaryWithObject:FONT_SIZE_12 forKey:NSFontAttributeName] context:nil];

            temp.frame = CGRectMake(_xPosition + 5, _yPosition, labelRect.size.width + 5, 20);
            temp.text = strTagName;
            [temp setTextColor:[self getColor:tag.tagsColor]];
            [self addSubview:temp];
            _xPosition += labelRect.size.width + 5;
        }
    }

    if (model.isattention == 1) {

        [_btnAttention setTitle:@"-关注" forState:UIControlStateNormal];

        [_btnAttention setTitle:@"-关注" forState:UIControlStateHighlighted];
    }
    else if (model.isattention == 0) {
        [_btnAttention setTitle:@"+关注" forState:UIControlStateNormal];
        [_btnAttention setTitle:@"+关注" forState:UIControlStateHighlighted];
    }

    _btnAttention.tag = model.isattention;
}

HEXColor_Method

    - (void)attentionAction : (id)sender
{

    UIButton* _btnTemp = (UIButton*)sender;
    if (_btnTemp.tag == 0) {
        [[TribeService shareInstance] addUserAttentionTribe:[CurrentAccount currentAccount].uid
                                                    tribeId:_model.shopId
                                                  OnSuccess:^(DataModel* dataModel) {
                                                      if (dataModel.code == 202) {
                                                          _btnTemp.tag = 1;
                                                          _model.isattention = 1;
                                                          _model.attentionNum = _model.attentionNum + 1;
                                                          [_lblAttentionNum setText:[NSString stringWithFormat:@"%ld", (long)_model.attentionNum]];
                                                          [_btnAttention setTitle:@"-关注" forState:UIControlStateNormal];
                                                          [_btnAttention setTitle:@"-关注" forState:UIControlStateHighlighted];
                                                          [ToastManager showToast:@"围观成功" withTime:Toast_Hide_TIME];
                                                          [[NSNotificationCenter defaultCenter] postNotificationName:@"MyHelpRefreshData" object:self];
                                                      }
                                                  }];
    }
    else {
        [[TribeService shareInstance] removeUserAttentionTribe:[CurrentAccount currentAccount].uid
                                                       tribeId:_model.shopId
                                                     OnSuccess:^(DataModel* dataModel) {
                                                         if (dataModel.code == 203) {
                                                             _btnTemp.tag = 0;
                                                             _model.isattention = 0;
                                                             _model.attentionNum = _model.attentionNum - 1;
                                                             [_lblAttentionNum setText:[NSString stringWithFormat:@"%ld", (long)_model.attentionNum]];
                                                             [_btnAttention setTitle:@"+关注" forState:UIControlStateNormal];
                                                             [_btnAttention setTitle:@"+关注" forState:UIControlStateHighlighted];
                                                             [ToastManager showToast:@"取消围观成功" withTime:Toast_Hide_TIME];
                                                             [[NSNotificationCenter defaultCenter] postNotificationName:@"MyHelpRefreshData" object:self];
                                                         }
                                                     }];
    }
}

@end
