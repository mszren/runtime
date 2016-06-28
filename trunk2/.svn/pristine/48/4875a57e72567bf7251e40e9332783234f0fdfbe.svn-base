//
//  SQLServiceController.m
//  FamilyCircle
//
//  Created by chs_net on 13-10-9.
//  Copyright (c) 2013年 Ecpalm. All rights reserved.
//

#import "SQLServiceController.h"
#import "EGOCache.h"
#import "AudioCache.h"
#import "VideoCache.h"
#import "AVAudioRecorderService.h"
static SQLServiceController *_instance;
@implementation SQLServiceController
@synthesize globalHelper;
+(SQLServiceController *)getInstance
{
    if(!_instance)
    {
        _instance = [[SQLServiceController alloc]init];
        _instance.globalHelper = [LKDBHelper getUsingLKDBHelper];
    }
    return _instance;
}
-(void)creatTable
{
    [self creatDB];
}
-(void)deleteAllTable
{
    [globalHelper dropAllTable];
    [_instance creatDB];
    
}

-(BOOL)deleteFrome:(NSString *)tableName
{
  return  [globalHelper dropTableWithName:tableName];
    
}
-(void)parseFamilyList:(NSArray *)array
{
    for (NSDictionary *dic in array) {
        [self insertUserInfo:[User parseToDictionary:dic]];
    }
}
-(void)getFriendList:(Completion)completion
{
    
    __block BOOL flag = YES;
    [APISDK getFamilyListCallBack:^(id obj) {
        if ([obj isKindOfClass:[ServerSideError class]]) {
            flag =NO;
            
        }else if ([obj isKindOfClass:[NSDictionary class]])
        {
            if ([obj objectForKey:@"user"]) {
                [self parseFamilyList:[obj objectForKey:@"user"]];
            }
        }
        if (completion) {
            completion(flag);
        }
        
    }];
    
    
}
-(BOOL)creatDB
{
    //    [globalHelper dropAllTable];
    [globalHelper createTableWithModelClass:[User class] table:USERDB];
    [globalHelper createTableWithModelClass:[DJTChatInfo class] table:CHATLISTDB];
    return [globalHelper createTableWithModelClass:[DJTChatInfo class] table:CHATDB];
}

#pragma mark ----插入数据
-(BOOL) insert :(DJTChatInfo*)insertList table:(NSString *)tableName
{
    globalHelper.tableName = tableName;
    return [globalHelper insertToDB:insertList];
    
}
#pragma mark --- 查询聊天消息多少未读数
-(int)searchChatListNumber
{
    globalHelper.tableName = CHATLISTDB;
   int num = [globalHelper sumCount:@"dontRendCount" where:Nil];
    return num;
}
#pragma mark -----查训最近的一条聊天CHATDB
-(NSMutableArray*)searchLastChat:(DJTChatInfo *)lastInfo
{
    globalHelper.tableName = CHATDB;
    NSMutableArray* array =[DJTChatInfo searchWithWhere:@{@"toReceiver":lastInfo.toReceiver?lastInfo.toReceiver:@""} orderBy:@"rowid desc" offset:0 count:1];
    
    //    [DJTChatInfo searchWithWhere:@{@"toReceiver":searchID?searchID:@""} orderBy:@"rowid desc" offset:start count:count];
    return array;
}
-(NSMutableArray*)searchInfo:(DJTChatInfo *)lastInfo
{
    globalHelper.tableName = CHATDB;
    NSMutableArray* array =[DJTChatInfo searchWithWhere:@{@"toReceiver":lastInfo.toReceiver?lastInfo.toReceiver:@"",@"stringTimeStep":lastInfo.stringTimeStep,@"type":lastInfo.type} orderBy:@"rowid asc" offset:0 count:1];
    
    //    [DJTChatInfo searchWithWhere:@{@"toReceiver":searchID?searchID:@""} orderBy:@"rowid desc" offset:start count:count];
    return array;

}
//SELECT * FROM [user] WHERE u_name LIKE '%三%' AND u_name LIKE '%猫%'
#pragma mark ---- 查询聊天记录
-(NSMutableArray*)searchRecordChat:(NSString *)lastInfo searchText:(NSString *)text
{
    globalHelper.tableName = CHATDB;
    
    NSString * str = [NSString stringWithFormat:@"toReceiver = '%@' AND type = 0 AND content LIKE '%%%@%%'",lastInfo,text];
    
    NSMutableArray* array =[DJTChatInfo searchWithWhere:str orderBy:@"rowid desc,timeStep desc" offset:0 count:MAXFLOAT];
    return array;
    
}
#pragma mark -----查询数据(根据CHATLISTDB 中的uID)CHATDB
-(NSMutableArray*)getallDateOfUIDInChatDB:(NSString *)searchID  :(int)start :(int)count
{
    globalHelper.tableName = CHATDB;
    NSMutableArray* array = [DJTChatInfo searchWithWhere:@{@"toReceiver":searchID?searchID:@""} orderBy:@"rowid desc,timeStep desc" offset:start count:count];
    return array;
}
-(NSMutableArray*)getPreviousChatRecordDB:(DJTChatInfo *)preInfo :(int)start :(int)count
{
      globalHelper.tableName = CHATDB;
     NSMutableArray*   array= [DJTChatInfo searchWithWhere:@{@"toReceiver":preInfo.toReceiver?preInfo.toReceiver:@"",@"rowid<":[NSNumber numberWithInt:preInfo.rowid-1]} orderBy:@"rowid desc,timeStep desc" offset:start count:count];
    return array;
}
#pragma mark -----查询定位数据(根据CHATLISTDB 中的uID)CHATDB
-(NSMutableArray*)getallDateOfInChatDB:(DJTChatInfo *)search  start:(int)start count:(int)count  isUpDrag:(BOOL)drag
{
    globalHelper.tableName = CHATDB;
    NSMutableArray* array;
    
    if (drag) {
        array= [DJTChatInfo searchWithWhere:@{@"toReceiver":search.toReceiver?search.toReceiver:@"",@"rowid<":[NSNumber numberWithInt:search.rowid-1]} orderBy:@"rowid desc,timeStep desc" offset:start count:count];
    }else
    {
        array= [DJTChatInfo searchWithWhere:@{@"toReceiver":search.toReceiver?search.toReceiver:@"",@"rowid<":[NSNumber numberWithInt:search.rowid-1]} orderBy:@"rowid desc,timeStep desc" offset:0 count:1];
        if (array.count>0) {
            DJTChatInfo * chat = [array objectAtIndex:0];
            if (chat.speaker==3) {
                NSMutableArray * arr =[DJTChatInfo searchWithWhere:@{@"toReceiver":search.toReceiver?search.toReceiver:@"",@"rowid>":[NSNumber numberWithInt:search.rowid]} orderBy:@"rowid asc,timeStep asc" offset:start count:MAXFLOAT];
                    [array addObjectsFromArray:arr];
            }else
            {
                  array= [DJTChatInfo searchWithWhere:@{@"toReceiver":search.toReceiver?search.toReceiver:@"",@"rowid>":[NSNumber numberWithInt:search.rowid]} orderBy:@"rowid asc,timeStep asc" offset:start count:MAXFLOAT];
            }
          
        }else
        {
              array= [DJTChatInfo searchWithWhere:@{@"toReceiver":search.toReceiver?search.toReceiver:@"",@"rowid>":[NSNumber numberWithInt:search.rowid]} orderBy:@"rowid asc,timeStep asc" offset:start count:MAXFLOAT];
        }

    }
  
    return array;
}
-(NSMutableArray*)getdownDateOfInChatDB:(DJTChatInfo *)search  start:(int)start count:(int)count
{
    globalHelper.tableName = CHATDB;
    NSMutableArray* array;
    array= [DJTChatInfo searchWithWhere:@{@"toReceiver":search.toReceiver?search.toReceiver:@"",@"rowid>":[NSNumber numberWithInt:search.rowid+1]} orderBy:@"rowid asc,timeStep asc" offset:start count:count];
    return array;
    

}
#pragma mark -----查询聊天列表的所有数据
-(NSMutableArray*)getallDataChatList
{
    globalHelper.tableName = CHATLISTDB;
    NSMutableArray* array = [DJTChatInfo searchWithWhere:Nil orderBy:@"topStep desc,timeStep desc" offset:0 count:MAXFLOAT];
    return array;
    
}
-(NSMutableArray*)getallDelXGJDataChatList
{
    globalHelper.tableName = CHATLISTDB;
    NSMutableArray* array = [DJTChatInfo searchWithWhere:[NSString stringWithFormat:@"photo_h <> 100"] orderBy:@"topStep desc,timeStep desc" offset:0 count:MAXFLOAT];
    return array;
    
}
#pragma mark ----置顶聊天列表的数据
-(BOOL) updataTop:(NSString*)toReceiver time:(int)time
{
    globalHelper.tableName = CHATLISTDB;
    
    return [DJTChatInfoList updateToDBWithSet:[NSString stringWithFormat:@"topStep = %d",time] where:@{@"toReceiver":toReceiver?toReceiver:@""}];
    
}
#pragma mark ----更新是否进行推送（单条聊天纪录）
-(BOOL) updataTokenPush:(NSString*)toReceiver isToken:(int)token  chat:(BOOL)isChat
{
    if (isChat) {
        globalHelper.tableName = USERDB;
        return [User updateToDBWithSet:[NSString stringWithFormat:@"isToken = %d",token] where:@{@"uid":toReceiver?toReceiver:@""}];
        
    }
      globalHelper.tableName = CHATLISTDB;
     return [DJTChatInfo updateToDBWithSet:[NSString stringWithFormat:@"isToken = %d",token] where:@{@"toReceiver":toReceiver?toReceiver:@""}];
}
//#pragma mark -----更新数据
//-(BOOL) update :(DJTChatInfo *)updateList tableName:(NSString *)tablename
//{
//    globalHelper.tableName = CHATLISTDB;
//    NSString * string = [NSString stringWithFormat:@"content=?,timeStep=?,name=?,type =?,receiverName=?,isFriend =?,speaker =?,audio_DontRead =?"];
//    NSArray * arry = [NSArray arrayWithObjects:updateList.content,[NSNumber numberWithDouble:updateList.timeStep],updateList.name,updateList.type,updateList.receiverName, [NSNumber numberWithInt:updateList.isFriend],[NSNumber numberWithInt:updateList.speaker],[NSNumber numberWithInt:updateList.audio_DontRead],nil];
//    
////    [DJTChatInfo updateToDBWithSet:(NSString *) where:<#(id)#>]
//    return [DJTChatInfo updateToDBWithSet:string setsValues:arry where:@{@"toReceiver":updateList.toReceiver?updateList.toReceiver:@""}];
//
////    return [globalHelper updateToDB:updateList where:@{@"toReceiver":updateList.toReceiver?updateList.toReceiver:@""}];
//    
//}
#pragma mark -----更新数据
-(BOOL) update :(DJTChatInfo *)updateList tableName:(NSString *)tablename
{
    globalHelper.tableName = CHATLISTDB;
    NSString * string = [NSString stringWithFormat:@"content=?,timeStep=?,name=?,type =?,receiverName=?,isFriend = ?,speaker =?,audio_DontRead =?"];
    NSArray * arry = [NSArray arrayWithObjects:updateList.content,[NSNumber numberWithDouble:updateList.timeStep],updateList.name,updateList.type,updateList.receiverName, [NSNumber numberWithInt:updateList.isFriend],[NSNumber numberWithInt:updateList.speaker],[NSNumber numberWithInt:updateList.audio_DontRead],nil];
    
    return [DJTChatInfo updateToDBWithSet:string setsValues:arry where:@{@"toReceiver":updateList.toReceiver?updateList.toReceiver:@""}];
    
    //    return [globalHelper updateToDB:updateList where:@{@"toReceiver":updateList.toReceiver?updateList.toReceiver:@""}];
    
}
-(BOOL) updategroupNameReal:(DJTChatInfo *)updateList;
{
    globalHelper.tableName =CHATLISTDB;
    NSString * string = [NSString stringWithFormat:@"groupName='%@'",updateList.groupName];
    return [DJTChatInfo updateToDBWithSet:string where:@{@"toReceiver":updateList.toReceiver?updateList.toReceiver:@""}];
}
-(BOOL) searchGroupName:(DJTChatInfo*)updateList
{
    globalHelper.tableName =CHATLISTDB;
    NSMutableArray *arry = [DJTChatInfo searchWithWhere:@{@"toReceiver":updateList.toReceiver?updateList.toReceiver:@""} orderBy:@"timeStep desc,rowid desc" offset:0 count:1];
    if (arry.count==0) {
        return NO;
    }else
    {
        DJTChatInfo * djc =[arry objectAtIndex:0];
        if (djc.groupName.length==0 ||djc.groupName==nil) {
            return NO;
        }else
        {
            return YES;
        }
    }
    
}
-(BOOL) updateGroupName:(DJTChatInfo *)updateList
{
    globalHelper.tableName =CHATLISTDB;
    NSString * string = [NSString stringWithFormat:@"receiverName='%@'",updateList.receiverName];
    return [DJTChatInfo updateToDBWithSet:string where:@{@"toReceiver":updateList.toReceiver?updateList.toReceiver:@""}];
}
-(BOOL) updateMarkName:(User *)user
{
    globalHelper.tableName =CHATLISTDB;
    NSString * string = [NSString stringWithFormat:@"name='%@',receiverName='%@'",user.nickname,[DJTUtility getUserMarkName:user]];
    return [DJTChatInfo updateToDBWithSet:string where:@{@"toReceiver":user.userName?user.userName:@""}];
}

-(BOOL) updataChatListContent:(NSString *)updateList
{
      globalHelper.tableName =CHATLISTDB;
      NSString * string = [NSString stringWithFormat:@"content='',type =0"];
     return [DJTChatInfo updateToDBWithSet:string where:@{@"toReceiver":updateList?updateList:@""}];
    
}
//#pragma mark -----更新接受到的数据
//-(BOOL) updateReceive:(DJTChatInfo *)updateList tableName:(NSString *)tablename
//{
//    globalHelper.tableName =tablename;
//  
//    NSString * string = [NSString stringWithFormat:@"content=?,timeStep=?,name=?,type =?,receiverName=?,isFriend = ?,speaker =?,audio_DontRead =?"];
//    NSArray * arry = [NSArray arrayWithObjects:updateList.content,[NSNumber numberWithDouble:updateList.timeStep],updateList.name,updateList.type,updateList.receiverName,[NSNumber numberWithInt:updateList.isFriend],[NSNumber numberWithInt:updateList.speaker],[NSNumber numberWithInt:updateList.audio_DontRead],nil];
//    
//    return [DJTChatInfo updateToDBWithSet:string setsValues:arry where:@{@"toReceiver":updateList.toReceiver?updateList.toReceiver:@""}];
//    
//}
#pragma mark -----更新接受到的数据
-(BOOL) updateReceive:(DJTChatInfo *)updateList tableName:(NSString *)tablename
{
    globalHelper.tableName =tablename;
    if (updateList.chatTyp==CHATTYPE_GROUP) {
        if (updateList.receiverName && updateList.receiverName.length>0) {
            NSString * string = [NSString stringWithFormat:@"content=?,timeStep=?,name=?,type =?,receiverName=?,isFriend = ?,speaker =?,audio_DontRead =?,state=?,stringTimeStep=?"];
            NSArray * arry = [NSArray arrayWithObjects:updateList.content,[NSNumber numberWithDouble:updateList.timeStep],updateList.name,updateList.type,updateList.receiverName,[NSNumber numberWithInt:updateList.isFriend],[NSNumber numberWithInt:updateList.speaker],[NSNumber numberWithInt:updateList.audio_DontRead],[NSNumber numberWithInt:updateList.state],updateList.stringTimeStep,nil];
            
            return [DJTChatInfo updateToDBWithSet:string setsValues:arry where:@{@"toReceiver":updateList.toReceiver?updateList.toReceiver:@""}];
        }else
        {
            NSString * string = [NSString stringWithFormat:@"content=?,timeStep=?,name=?,type =?,isFriend = ?,speaker =?,audio_DontRead =?,state=?,stringTimeStep=?"];
            NSArray * arry = [NSArray arrayWithObjects:updateList.content,[NSNumber numberWithDouble:updateList.timeStep],updateList.name,updateList.type,[NSNumber numberWithInt:updateList.isFriend],[NSNumber numberWithInt:updateList.speaker],[NSNumber numberWithInt:updateList.audio_DontRead],[NSNumber numberWithInt:updateList.state],updateList.stringTimeStep,nil];
            
            return [DJTChatInfo updateToDBWithSet:string setsValues:arry where:@{@"toReceiver":updateList.toReceiver?updateList.toReceiver:@""}];
        }
       
    }else
    {
        NSString * string = [NSString stringWithFormat:@"content=?,timeStep=?,name=?,type =?,receiverName=?,isFriend = ?,speaker =?,audio_DontRead =?,state=?,stringTimeStep=?"];
        NSArray * arry = [NSArray arrayWithObjects:updateList.content,[NSNumber numberWithDouble:updateList.timeStep],updateList.name,updateList.type,updateList.receiverName,[NSNumber numberWithInt:updateList.isFriend],[NSNumber numberWithInt:updateList.speaker],[NSNumber numberWithInt:updateList.audio_DontRead],[NSNumber numberWithInt:updateList.state],updateList.stringTimeStep,nil];
        
        return [DJTChatInfo updateToDBWithSet:string setsValues:arry where:@{@"toReceiver":updateList.toReceiver?updateList.toReceiver:@""}];
    }
    return NO;
    
}

#pragma mark ------更新Comment
-(BOOL)updateComment:(DJTChatInfo*)Comment datetimp:(int)datetimp userid:(NSString *)toUser
{
    globalHelper.tableName =CHATDB;
    
// NSString * string = [NSString stringWithFormat:@"comment='%@'",Comment.comment];
    return [globalHelper updateToDB:Comment where:nil];
    //[DJTChatInfo updateToDBWithSet:string where:[NSString stringWithFormat:@"toReceiver = '%@' and timeStep =%d and type =%d",toUser,Comment.timeStep,2]];
    /*
    [DJTChatInfo updateToDBWithSet:[NSString stringWithFormat:@"comment = '%@'",Comment.comment] where:@{@"toReceiver":toUser,@"timeStep":[NSNumber numberWithInt:datetimp],@"type":[NSNumber numberWithInt:2]}];
     */
}
#pragma mark ------更新状态
-(BOOL)updateStatus:(int)state datetimp:(NSString *)datetimp userid:(NSString *)toUser  tableName:(NSString*)tableName;
{
    globalHelper.tableName = tableName;
    return [DJTChatInfo updateToDBWithSet:[NSString stringWithFormat:@"state = %d",state] where:@{@"toReceiver":toUser,@"stringTimeStep":datetimp}];
    
}
-(BOOL)updateStatus:(int)state time:(NSString *)time userid:(NSString *)toUser  tableName:(NSString*)tableName;
{
    globalHelper.tableName = tableName;
    return [DJTChatInfo updateToDBWithSet:[NSString stringWithFormat:@"state = %d",state] where:@{@"toReceiver":toUser,@"time":time}];
}
-(NSMutableArray*)searchMessageID:(NSString *)searchID  userid:(NSString *)toUser tableName:(NSString *)tablename
{
    globalHelper.tableName = tablename;
    
    NSMutableArray* array = [DJTChatInfo searchWithWhere:@{@"time":searchID?searchID:@"",@"speaker":[NSNumber numberWithInt:0],@"toReceiver":toUser} orderBy:@"rowid desc,timeStep desc" offset:0 count:1];
    return array;
}
#pragma mark ------更新视频URL
-(BOOL)updateVideoUrl:(NSString *)url datetimp:(int)datetimp userid:(NSString *)toUser
{
    globalHelper.tableName = CHATDB;
    return [DJTChatInfo updateToDBWithSet:[NSString stringWithFormat:@"videoUrl = '%@'",url] where:@{@"toReceiver":toUser,@"timeStep":[NSNumber numberWithDouble:datetimp]}];
    

}
#pragma mark -----删除聊天列表的数据
-(BOOL) deleteChatListDB:(DJTChatInfo *)deleteList key:(NSString *)key
{
    if (deleteList) {
        [self deleteAllChats:deleteList.toReceiver thorougt:YES];
    }
    
    globalHelper.tableName = CHATLISTDB;
    if (deleteList && !key) {
        return    [globalHelper deleteToDB:deleteList];
    }else
    {
        return     [globalHelper deleteWithClass:[DJTChatInfo class] where:@{@"toReceiver":key?key:@""}];
    }
    
}
#pragma mark  ----删除一个人所有消息
- (BOOL)deleteAllChats:(NSString *)toUser thorougt:(bool)isThorough
{
    globalHelper.tableName = CHATDB;
    NSMutableArray *array  =[self getChatMassgeListOfReceiver:toUser];
    for (DJTChatInfo *info in array) {
        if ([info.type intValue]==M_PHOTO_M || [info.type intValue]==M_AUDIO ||[info.type intValue]==M_VIDEO) {
            [self deleteImage:info.speaker key:info.content type:[info.type intValue]];
        }
    }
    return [globalHelper deleteWithClass:[DJTChatInfo class] where:@{@"toReceiver":toUser}];
    
}
#pragma mark  ----获取一个人所有的聊天列表
-(NSMutableArray *)getChatMassgeListOfReceiver:(NSString *)toReceiver
{
    globalHelper.tableName = CHATDB;
    return  [DJTChatInfo searchWithWhere:@{@"toReceiver":toReceiver?toReceiver:@""} orderBy:@"timeStep desc,rowid desc" offset:0 count:MAXFLOAT];
    
    
}
#pragma mark  ----删除一条消息
- (BOOL)deleteOne:(DJTChatInfo *)message tableName:(NSString *) tableName thorougt:(bool)isThorough
{
    globalHelper.tableName  = tableName;
    if ([message.type intValue]==M_PHOTO_M || [message.type intValue]==M_AUDIO ||[message.type intValue]==M_VIDEO) {
        [self deleteImage:message.speaker key:message.content type:[message.type intValue]];
    }
    if (message.rowid==0) {
        DJTChatInfo *info =[[DJTChatInfo searchWithWhere:@{@"toReceiver":message.toReceiver?message.toReceiver:@"",@"stringTimeStep":message.stringTimeStep,@"speaker":[NSNumber numberWithInt:0]} orderBy:@"rowid asc" offset:0 count:1] objectAtIndex:0];
        
        
//        [globalHelper searchSingle:[message class] where:@{@"toReceiver":message.toReceiver?message.toReceiver:@"",@"timeStep":[NSNumber numberWithDouble:message.timeStep],@"stringTimeStep":message.stringTimeStep,@"speaker":[NSNumber numberWithInt:0]} orderBy:Nil];
        return [DJTChatInfo deleteToDB:info];
    }
    
    return [DJTChatInfo deleteToDB:message];
    
}
- (BOOL)deleteMessageTime:(DJTChatInfo *)timeInfo
{
    globalHelper.tableName = CHATDB;
    if (timeInfo.rowid==0) {
        DJTChatInfo *info = [globalHelper searchSingle:[timeInfo class] where:@{@"toReceiver":timeInfo.toReceiver?timeInfo.toReceiver:@"",@"timeStep":[NSNumber numberWithDouble:timeInfo.timeStep],@"speaker":[NSNumber numberWithInt:3]} orderBy:Nil];
        
        return [DJTChatInfo deleteToDB:info];
    }
    return [DJTChatInfo deleteToDB:timeInfo];
}


-(void)deleteImage:(int)speaker key:(NSString*)content type:(int)type
{
    if (type==M_PHOTO_M)
    {
        if (speaker==0)
        {
            [[SaveImageToLocal currentCache] removeCacheForKey:content];
            [[SaveImageToLocal currentCache] removeCacheForKey:[NSString stringWithFormat:@"%@_l",content]];
        }
        else
        {
            if ([[EGOCache currentCache] hasCacheForKey:content]) {
                [[EGOCache currentCache] removeCacheForKey:content];
            }
        }
    }
    else if(type ==M_AUDIO)
    {
        if (speaker==0)
        {
            [AVAudioRecorderService deleteFileAtPath:content];
            
        }
        else
        {
            [[AudioCache currentCache] removeCacheForKey:content];
        }
        
        
    }else if(type ==M_VIDEO)
    {
        if (speaker==0)
        {
            [[VideoCache currentCache]removeCacheForKey:content];
            
        }
        else
        {
            [[AudioCache currentCache] removeCacheForKey:content];
        }
    }
    
}


#pragma mark -----
#pragma mark ------查看未读数量
-(int)selectDontRendCount:(NSString *)receiver
{
    globalHelper.tableName=CHATLISTDB;
    
    NSMutableArray *array = [DJTChatInfo searchWithWhere:@{@"toReceiver":receiver?receiver:@""} orderBy:Nil offset:0 count:1];
    if (array.count>0) {
        DJTChatInfo *djt =[array objectAtIndex:0];
        return djt.dontRendCount;
    }
    return 0;
    
}

#pragma mark ------更新未读变已读
-(BOOL)updateDontRend:(NSString *)receiver
{
    if ([self selectDontRendCount:receiver]>0) {
        globalHelper.tableName = CHATLISTDB;
        return  [DJTChatInfo updateToDBWithSet:@"dontRendCount = 0" where:@{@"toReceiver":receiver?receiver:@""}];
    }
    return YES;
    
}

#pragma mark ------更新未读数量
-(BOOL)updateDontRendCount:(NSString *)receiver
{
    globalHelper.tableName = CHATLISTDB;
    return [DJTChatInfo updateToDBWithSet:@"dontRendCount = dontRendCount+1" where:@{@"toReceiver":receiver?receiver:@""}];
}


#pragma mark ----更新一个人的好友关系
-(BOOL) updateFriend:(DJTChatInfo*)updateList table:(NSString*)tableName
{
    globalHelper.tableName = tableName;
    NSString * string = [NSString stringWithFormat:@"isFriend=%d",updateList.isFriend];
    return [DJTChatInfo updateToDBWithSet:string where:@{@"toReceiver":updateList.toReceiver?updateList.toReceiver:@""}];
    
}
-(BOOL) updateLoseFriend:(DJTChatInfo *)updateList table:(NSString *)tableName
{
    globalHelper.tableName = tableName;
    NSString * string = [NSString stringWithFormat:@"isFriend=%d,temp_id ='%@'",updateList.isFriend,updateList.temp_id];
    return [DJTChatInfo updateToDBWithSet:string where:@{@"toReceiver":updateList.toReceiver?updateList.toReceiver:@"",@"stringTimeStep":updateList.stringTimeStep?updateList.stringTimeStep:@""}];
}
#pragma mark ----更新音频是读取状态
-(BOOL) updateAudioRend:(DJTChatInfo *)updateList table:(NSString *)tableName
{
    globalHelper.tableName = tableName;
    
    return  [DJTChatInfo updateToDBWithSet:@"audio_DontRead = 0" where:@{@"toReceiver":updateList.toReceiver?updateList.toReceiver:@"",@"stringTimeStep":updateList.stringTimeStep?updateList.stringTimeStep:@""}];
}
-(BOOL) updateAudioRendCus:(DJTChatInfo *)updateList table:(NSString *)tableName
{
    globalHelper.tableName = tableName;
    
    return  [DJTChatInfo updateToDBWithSet:@"audio_DontRead = 0" where:@{@"toReceiver":updateList.toReceiver?updateList.toReceiver:@""}];
}
#pragma mark ----更新添加相册关系
-(BOOL) updateAlbum:(DJTChatInfo*)updateList table:(NSString*)tableName
{
      globalHelper.tableName = tableName;
       NSString * string = [NSString stringWithFormat:@"isFriend=%d,temp_id ='%@'",updateList.isFriend,updateList.temp_id];
        return [DJTChatInfo updateToDBWithSet:string where:@{@"toReceiver":updateList.toReceiver?updateList.toReceiver:@"",@"stringTimeStep":updateList.stringTimeStep?updateList.stringTimeStep:@""}];

}
#pragma mark ----更新一个群组的好友关系
-(BOOL) updateGroup:(NSString*)roomName
{
     globalHelper.tableName = CHATLISTDB;
    return [DJTChatInfo updateToDBWithSet:[NSString stringWithFormat:@"isFriend = 1"] where:@{@"toReceiver":roomName?roomName:@""}];
}
-(BOOL) updateGroupFriend:(NSString*)roomName;
{
    globalHelper.tableName = CHATLISTDB;
    return [DJTChatInfo updateToDBWithSet:[NSString stringWithFormat:@"isFriend = 0"] where:@{@"toReceiver":roomName?roomName:@""}];
}





#pragma mark -
#pragma mark -----查询用户列表
-(NSMutableArray*)getallDataUserList
{
    globalHelper.tableName = USERDB;
    NSMutableArray* array = [User searchWithWhere:Nil orderBy:nil offset:0 count:MAXFLOAT];
    return array;
}

#pragma mark 查找用户信息
- (User *)getUserCommentName:(NSString *)tempUserName
{
    globalHelper.tableName = USERDB;
    NSMutableArray *array  =[User searchWithWhere:@{@"userName":tempUserName ? tempUserName:@""} orderBy:Nil offset:0 count:1];
    if (array.count>0) {
        return [array objectAtIndex:0];
    }
    return nil;
}
#pragma mark 查找用户信息ID
- (User *)getUserUid:(NSString *)tempUserUid
{
    globalHelper.tableName = USERDB;
    NSMutableArray *array  =[User searchWithWhere:@{@"uid":tempUserUid ? tempUserUid:@""} orderBy:Nil offset:0 count:1];
    if (array.count>0) {
        return [array objectAtIndex:0];
    }
    return nil;
}
#pragma mark 查找用户信息ID -userName
- (User *)getUserUserName:(NSString *)userName
{
    globalHelper.tableName = USERDB;
    NSMutableArray *array  =[User searchWithWhere:@{@"userName":userName ? userName:@""} orderBy:Nil offset:0 count:1];
    if (array.count>0) {
        return [array objectAtIndex:0];
    }
    return nil;

}
#pragma mark 添加一条用户信息
- (BOOL)insertUserInfo:(User *)tempUserInfo
{
    globalHelper.tableName = USERDB;
    if ([self isHaveUser:tempUserInfo.uid]) {
        return [self updataUserInfo:tempUserInfo];
        
    }else
    {
        return [globalHelper insertToDB:tempUserInfo];
    }
    return NO;
}

#pragma mark -
#pragma mark 查找是否有此用户
- (BOOL)isHaveUser:(NSString *)userid
{
    globalHelper.tableName = USERDB;
    NSMutableArray* array = [User searchWithWhere:@{@"uid":userid?userid:@""} orderBy:Nil offset:0 count:1];
    if (array.count>0) {
        return YES;
    }
    return NO;
}
#pragma marl 修改用户的聊天背景
- (BOOL)updataUserImageBackground:(User *)user imageStr:(NSString *)imgS
{
    globalHelper.tableName = USERDB;
    NSString * string = [NSString stringWithFormat:@"imageBgString='%@'",imgS];
    return   [globalHelper updateToDB:[user class] set:string where:@{@"uid":user.uid?user.uid:@""}];
}
#pragma marl 修改群的聊天背景
- (BOOL)updataGroupImageBackground:(DJTChatInfo *)user imageStr:(NSString *)imgS
{
    globalHelper.tableName = CHATLISTDB;
    NSString * string = [NSString stringWithFormat:@"groupBg='%@'",imgS];
    return  [globalHelper updateToDB:[user class] set:string where:@{@"toReceiver":user.toReceiver?user.toReceiver:@""}];
}
#pragma mark -
#pragma mark 更新用户信息
- (BOOL)updataUserInfo:(User *)tempUserInfo
{
    globalHelper.tableName = USERDB;
    
    NSString * string = [NSString stringWithFormat:@"uid='%@',userName = '%@',nickname = '%@',markName = '%@',face = '%@',status = %d,isSign = '%@',telNumber = '%@',userNum = '%@',smallFace ='%@'",tempUserInfo.uid,tempUserInfo.userName,tempUserInfo.nickname,tempUserInfo.markName,tempUserInfo.face,tempUserInfo.status,tempUserInfo.isSign,tempUserInfo.telNumber,tempUserInfo.userNum?tempUserInfo.userNum:@"",tempUserInfo.smallFace];
    
    return  [globalHelper updateToDB:[tempUserInfo class] set:string where:@{@"uid":tempUserInfo.uid?tempUserInfo.uid:@""}];
    
}

#pragma mark -
#pragma mark 删掉这个用户
-(BOOL)deleteUserOtherInfo:(NSString *)userid username:(NSString *)username
{
    return [self deleteUserOtherInfo:userid username:username isDelRecord:YES];
}
-(BOOL)deleteUserOtherInfo:(NSString *)userid username:(NSString *)username isDelRecord:(BOOL)flag
{
    if (flag) {
        globalHelper.tableName = CHATLISTDB;
        [DJTChatInfo deleteWithWhere:@{@"toReceiver":username?username:@""}];
        [self deleteAllChats:username thorougt:YES];
    }
    globalHelper.tableName = USERDB;
    return [globalHelper deleteWithClass:[User class] where:@{@"uid":userid?userid:@""}];
    

}

@end