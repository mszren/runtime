//
//  UUMessageCell.h
//  UUChatDemoForTextVoicePicture
//
//  Created by shake on 14-8-27.
//  Copyright (c) 2014年 uyiuyao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UUMessageContentButton.h"
@class UUMessageFrame;
@class UUMessageCell;
@class MessageInfoModel;
@class RedPacketViewCell;


@protocol UUMessageCellDelegate <NSObject>
@optional
- (void)headImageDidClick:(UUMessageCell *)cell userId:(NSString *)userId;
- (void)cellContentDidClick:(UUMessageCell *)cell image:(UIImage *)contentImage;
- (void)messageState:(UUMessageCell *)cell withModel:(MessageInfoModel *) messageInfoModel;

- (void)inviteFriends:(BOOL) isAgree;
- (void)tapRedPacketAction:(MessageInfoModel *) aMessageInfoModel;
@end


@interface UUMessageCell : UITableViewCell

@property (nonatomic, retain)UILabel *labelTime;
@property (nonatomic, retain)UILabel *labelNum;
@property (nonatomic, retain)EGOImageButton*btnHeadImage;
@property (nonatomic, retain)UIButton *stateBtn;
@property (nonatomic, retain)UUMessageContentButton *btnContent;
@property (nonatomic, retain)UUMessageFrame *messageFrame;
@property (nonatomic, assign)id<UUMessageCellDelegate>delegate;
@property (nonatomic, assign)BOOL isFriend;

- (void) setMessageFrame:(UUMessageFrame *)messageFrame;

- (void) cancelAllBtnImageLoad;
- (void) loadHeadImg:(UUMessageFrame *) aUUMessageFrame;
@end

