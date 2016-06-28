//
//  SelectTagsViewController.m
//  FamilysHelper
//
//  Created by 我 on 15/7/28.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "SelectTagsViewController.h"
#import "TribeService.h"

@interface SelectTagsViewController ()

@end
 
@implementation SelectTagsViewController{
    AOTagList *_tag;
    ASIHTTPRequest *_getTagsRequest;
    NSMutableArray *_attentionList;
    NSInteger _tagId;
    MBProgressHUD *_hud;
}

@synthesize messageListner;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self loadData];
}

-(void)initView{
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 80, 14, SCREEN_WIDTH - 160, 17)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"选择标签";
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textColor = COLOR_RED_DEFAULT_904;
    self.navigationItem.titleView = titleLabel ;
    
    UIBarButtonItem* rightButton = [[UIBarButtonItem alloc] initWithTitle:@"确认" style:UIBarButtonItemStylePlain target:self action:@selector(onBtnCertain:)];
    self.navigationItem.rightBarButtonItem = rightButton;
}

- (void)loadData
{
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    if (_getTagsRequest) {
        [_getTagsRequest cancel];
    }
    _getTagsRequest = [[TribeService shareInstance] getTagsInterByUserID:[CurrentAccount currentAccount].uid  OnSuccess:^(DataModel *dataModel) {
        
        if (dataModel.code==200) {
            NSDictionary *array=dataModel.data;
            [_attentionList removeAllObjects];
            _attentionList=[array objectForKey:@"myattentionList"];
            TagView* tagView = [[TagView alloc] initWithFrame:self.view.frame Tags:_attentionList];
            tagView.delegate = self;
            [self.view addSubview:tagView];

        }else{
            [ToastManager showToast:dataModel.error withTime:Toast_Hide_TIME];
            
        }
        _hud.hidden = YES;
    }];
}

-(void)tagViewSelected:(TagModel*)tagModel{
    
    _tagId = tagModel.tagsId;
    
}


-(void)onBtnCertain:(UIBarButtonItem *)sender{
    if (_tagsBlock) {
        _tagsBlock(_tagId);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
 

@end
