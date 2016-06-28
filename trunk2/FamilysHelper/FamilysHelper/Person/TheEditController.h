//
//  TheEditController.h
//  FamilysHelper
//
//  Created by zhouwengang on 15/6/11.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TheEditController : BaseViewController
@property (weak, nonatomic) IBOutlet UITextView *edittext;
@property (weak, nonatomic) IBOutlet UILabel *_promptLabel;
@property(nonatomic, strong) NSString *flag;
@property(nonatomic, strong) NSString *oldText;

@end
