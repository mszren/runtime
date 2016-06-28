//
//  SelectTagsController.m
//  FamilysHelper
//
//  Created by Owen on 15/6/25.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "SelectTagsController.h"
#import "TagView.h"


@interface SelectTagsController ()<TagViewDelegate>

@end

@implementation SelectTagsController{
    TagModel *_tagModel;
}
@synthesize messageListner;

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self initView];
    // Do any additional setup after loading the view.
}

- (void)initView
{
    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc] initWithTitle:@"确认" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemAction:)];

    self.navigationItem.rightBarButtonItem = rightItem;
    [self.view setBackgroundColor:[UIColor whiteColor]];
    TagView* tagView = [[TagView alloc] initWithFrame:self.view.frame Tags:_tagsList];
    tagView.delegate = self;
    [self.view addSubview:tagView];
}

-(void)tagViewSelected:(TagModel *)tagModel{
    
    _tagModel = tagModel;
    
}

- (void)rightItemAction:(id)sender
{

    if (_blockTagModel) {
        
        _blockTagModel(_tagModel);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
