//
//  RedPacketViewCell.h
//  Common
//
//  Created by 曹亮 on 15/4/15.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//
@protocol RedPacketViewCellDelegate <NSObject>
@optional
- (void)tapRedPacket;
@end


@interface RedPacketViewCell : UIView{
    UILabel * _titleLab;
    
    UIImageView * _leftImg;
    UILabel * _descLab;
    
    UITapGestureRecognizer * _tap;
}
- (void) setRedPacketViewCellData:(NSString *) aStr;
@property(nonatomic,assign) id<RedPacketViewCellDelegate> delegate;

@end
