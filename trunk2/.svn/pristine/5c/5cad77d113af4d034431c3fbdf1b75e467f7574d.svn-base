//
//  AddressBookCell.h
//  qeebuConference
//
//  Created by caoliang on 13-9-24.
//  Copyright (c) 2013年 caoliang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class User;
@class EGOImageView;

@protocol AddressBookCellDelegate <NSObject>
- (void) showChatChatContact:(User *) aUser;
@end

@interface AddressBookCell : UITableViewCell<MessageRoutable>{
    EGOImageView * headImg;
    UILabel * nameLab;
    User * currentUser;
}
@property(nonatomic,assign) id <AddressBookCellDelegate> addressBookCellDelegate;
- (void) setCellDefault;
- (void) setCellData:(User *) aUser;

- (void) cancelAllBtnImageLoad;
- (void) loadHeadImg:(User *)userModel;

@end
