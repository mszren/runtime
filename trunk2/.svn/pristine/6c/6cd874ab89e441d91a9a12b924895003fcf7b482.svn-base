//
//  MessageInfoModel.h
//  Common
//
//  Created by 曹亮 on 15/3/30.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//




@class User;
@interface MessageInfoModel : NSObject <NSCoding>{
    
}
@property (nonatomic) int                 msgId;//id
@property (nonatomic) CHAT_TYPE           chatType;//消息类型
@property (nonatomic) CHAT_INFO_TYPE      chatInfoType;//消息详细类型
@property (nonatomic) CHAT_STATE          state;//状态

@property (nonatomic,strong) User *   toUser;//发送用户

@property (nonatomic,strong) NSString *   time; //时间
@property (nonatomic,strong) NSString *   content; //内容
@property (nonatomic,assign) NSUInteger   isSend; //发送者

@property (nonatomic,strong) NSString *   groupFace; //时间
@property (nonatomic,strong) NSString *   groupNickName; //内容


@property (nonatomic,strong) NSString *   file_url; //文件url
@property (nonatomic,strong) NSString *   file_ext; //文件格式

@property (nonatomic,strong) NSString *   voiceLength; //文件长度




@property (nonatomic) IS_FRIEND           isFriend;//是否是好友

@property (nonatomic,strong) NSString *   subjectStr;//红包link
/*
 imgUrl 头像url
 */
@property (nonatomic,strong) NSString *   imgUrl;  //url
@property (nonatomic) int                 dontRendCount; //未读消息
/*
 speaker
 0 自己
 1 对方
 3 时间戳
 */
@property (nonatomic) int                 speaker; //谁发的
@property (nonatomic,strong) NSString *   receiverName;//接受人的名字
@property (nonatomic,strong) NSString *   toReceiver; //接受的人的JID

/*
 type  0 nml:消息
 1 fil:图片
 2 fil:语音
 3 nml:地图
 4 fil:视频
 5 alb：家相册评论消息
 6 bfd:邀请成为好友
 7 jin:邀请加入大家庭 (相册)
 8 new: 新闻消息
 9 sys: 系统消息(邀请加入群聊/同意加入大家庭/退出你创建的大家庭/拒绝加入你创建的大家庭/你同意加入xxx创建的大家庭/xxx评论了你的某条家相册消息)
 
 60 //时间戳
 */
@property (nonatomic,strong) NSString *   temp_id;//邀请好友的消息的ID 同意 需要传递
@property (nonatomic,strong) NSString *   comment; //备注消息 cell 的宽高
@property (nonatomic) float               photo_w; //宽 //有值说明在播放音频 没有则不播放
@property (nonatomic) float               photo_h; //高 //小管家 =100
@property (nonatomic) int                 audio_l; //语音长度

//视频的 Url
@property (nonatomic,strong) NSString *   videoUrl; //视频url
@property (nonatomic,strong) NSString *   groupBg;//群聊天背景
@property (nonatomic,strong) NSString *   groupName;//群名称
@property (nonatomic) int                 topStep; //置顶时间撮
@property (nonatomic,strong) NSString *   newsJson; //新闻消息的Json
//音频
@property (nonatomic) int audio_DontRead; //音频是否未读
@property (nonatomic) int isToken;//是否接受通知



- (id)initWithMessageContent:(NSString *)contentStr withType:(CHAT_INFO_TYPE) chatInfoType withToUser:(User *) toUser;
- (id)initWithXMPPMessageJsonStr:(NSString *) jsonStr;




+ (MessageInfoModel *)JsonParse:(NSDictionary *)dic;

- (NSString *) toSendSubjectJsonStr;


+ (CHAT_INFO_TYPE) parseToChatInfoType:(NSString *) aStr;
+ (NSString *) parseToChatInfoTypeStr:(CHAT_INFO_TYPE ) chatInfoType;
@end
