//
//  TheEditController.m
//  FamilysHelper
//
//  Created by zhouwengang on 15/6/11.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "TheEditController.h"
#import "UserInfoViewController.h"
@interface TheEditController ()<UITextViewDelegate>

@end

@implementation TheEditController

- (void)viewDidLoad {
    [super viewDidLoad];
    _edittext.delegate = self;
    _edittext.text=_oldText;
    [self setWhiteNavBg];
    [self initializeWhiteBackgroudView:@"编辑资料"];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemAction:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    self.view.backgroundColor = COLOR_VIEW_BG;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)rightItemAction:(id) sender
{
    NSMutableDictionary *nsMutableDictionary =[NSMutableDictionary dictionary];

    [nsMutableDictionary setObject:_edittext.text forKey:@"editText"];
    [nsMutableDictionary setObject:_flag forKey:@"flag"];

    [self.navigationController popViewControllerAnimated:YES];
    [self RouteMessage:NOTIFICATION_PERSON_NOTICE withContext:@{ NOTIFICATION_DATA : nsMutableDictionary }];

}



- (BOOL)textView:(UITextView*)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    if ([text isEqualToString:@"\n"]) {
        
        __promptLabel.text = [NSString stringWithFormat:@"还可以输入%u个字", 80 - _edittext.text.length];
        [_edittext resignFirstResponder];
        return NO;
    }
    
    return YES;
}

@end
