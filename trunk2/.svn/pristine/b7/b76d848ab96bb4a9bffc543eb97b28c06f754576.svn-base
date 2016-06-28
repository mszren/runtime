//
//  XMPPChatRoom.m
//  FamilysHelper
//
//  Created by 曹亮 on 14/11/19.
//  Copyright (c) 2014年 FamilyTree. All rights reserved.
//

#import "XMPPChatRoom.h"

#pragma mark - DRRRChatRoomMember
@implementation XMPPChatRoomMember

-(NSString*)description{
    return [NSString stringWithFormat:@"<0x%lx %@ chatRoomJid=%@,chatRoomMembername=%@,chatRoomMemberJid=%@,affiliation=%@, role=%@, show=%@, status=%@, nick=%@ >",(unsigned long)self,[self class],self.chatRoomJid,self.chatRoomMembername,self.chatRoomMemberJid,self.affiliation,self.role,self.show,self.status,self.nick];
}
-(id)initWithPresence:(XMPPPresence *)presence{
    self=[super init];
    if (self){
        
        if (presence.childCount>0){
            /*进入房间时获取的其他成员列表
             <presence xmlns="jabber:client" id="GixiF-41" to="adow@222.191.249.155/drrr" from="test@conference.222.191.249.155/bdow">
             <x xmlns="http://jabber.org/protocol/muc#user">
             <item jid="bdow@222.191.249.155/Spark 2.6.3" affiliation="member" role="participant"/>
             </x>
             </presence>
             */
            /*退出房间时收到状态
             <presence xmlns="jabber:client" from="test@conference.222.191.249.155/adow" to="adow@222.191.249.155/drrr" type="unavailable">
             <x xmlns="http://jabber.org/protocol/muc#user">
             <item jid="adow@222.191.249.155/drrr" affiliation="owner" role="none"/></x>
             </presence>
             
             */
            for (NSXMLElement* element in presence.children) {
                if ([element.name isEqualToString:@"x"] && [element.xmlns isEqualToString:@"http://jabber.org/protocol/muc#user"]){
                    XMPPJID* jidFrom=[presence from];
                    NSString* chatRoomJid=[jidFrom bare];
                    NSString* chatRoomMemberName=[jidFrom resource];
                    NSXMLElement* element_item=element.children[0];
                    NSString* chatRoomMemberJid=[[XMPPJID jidWithString:element_item.attributesAsDictionary[@"jid"]] bare];
                    NSString* affiliation=element_item.attributesAsDictionary[@"affiliation"];
                    NSString* role=element_item.attributesAsDictionary[@"role"];
                    NSString* nick=element_item.attributesAsDictionary[@"nick"];
                    NSString* status=[presence status];
                    NSString* show=[presence show];
                    self.chatRoomJid=chatRoomJid;
                    self.chatRoomMembername=chatRoomMemberName;
                    self.chatRoomMemberJid=chatRoomMemberJid;
                    self.affiliation=affiliation;
                    self.role=role;
                    self.status=status;
                    self.show=show;
                    self.nick=nick;
                    break;
                }
            }
            
        }
    }
    return self;
}
@end
#pragma mark - DRRRChatRoomInfoField
@implementation XMPPChatRoomInfoField
-(id)initWithVar:(NSString *)var label:(NSString *)label value:(NSString *)value{
    self=[super init];
    if (self){
        self.var=var;
        self.label=label;
        self.value=value;
    }
    return self;
}
-(NSString*)description{
    return [NSString stringWithFormat:@"<0x%lx %@ var=%@, label=%@, value=%@>",(unsigned long)self,[self class],self.var,self.label,self.value];
}
@end
#pragma mark - DRRRChatRoomInfo
@implementation XMPPChatRoomInfo
-(id)init{
    self=[super init];
    if (self){
        _features=[[NSMutableArray alloc]init];
        _fields=[[NSMutableDictionary alloc]init];
    }
    return self;
}

-(NSArray*)features{
    return _features;
}
-(NSDictionary*)fields{
    return _fields;
}
-(id)initWithIq:(XMPPIQ *)iq{
    self=[super init];
    if (self){
        _features=[[NSMutableArray alloc]init];
        _fields=[[NSMutableDictionary alloc]init];
        NSXMLElement* element_query=iq.childElement;
        if ([element_query.xmlns isEqualToString:@"http://jabber.org/protocol/disco#info"]){
            for (NSXMLElement* element in element_query.children) {
                if ([element.name isEqualToString:@"identity"]){
                    self.category=element.attributesAsDictionary[@"category"];
                    self.name=element.attributesAsDictionary[@"name"];
                    self.type=element.attributesAsDictionary[@"type"];
                }
                else if ([element.name isEqualToString:@"feature"]){
                    NSString* value=element.attributesAsDictionary[@"var"];
                    [_features addObject:value];
                }
                else if ([element.name isEqualToString:@"x"]){
                    for (NSXMLElement* element_field in element.children) {
                        NSString* var=element_field.attributesAsDictionary[@"var"];
                        NSString* label=element_field.attributesAsDictionary[@"label"];
                        NSXMLElement* element_value=element_field.children[0];
                        NSString* value=element_value.stringValue;
                        XMPPChatRoomInfoField* field=[[XMPPChatRoomInfoField alloc]initWithVar:var label:label value:value];
                        _fields[var]=field;
                    }
                }
            }
        }
    }
    return self;
}
-(NSString*)description{
    return [NSString stringWithFormat:@"<0x%lx %@ category=%@, name=%@, type=%@,public=%d, membersonly=%d, password=%d, description=%@,subject=%@,occupants=%d,creationdate=%@,\nfeatures=%@,\nfields=%@>",(unsigned long)self,[self class],self.category,self.name,self.type,self.public,self.membersOnly,self.needPassword,self.roomDescription,self.subject,self.occupants,self.creationdate,self.features,self.fields];
}
-(BOOL)checkFeature:(NSString*)featureStr{
    for (NSString* feature in _features) {
        if ([feature isEqualToString:featureStr]){
            return YES;
        }
    }
    return NO;
}
-(BOOL)public{
    return [self checkFeature:@"muc_public"];
}
-(BOOL)needPassword{
    return [self checkFeature:@"muc_passwordprotected"];
}
-(BOOL)membersOnly{
    return [self checkFeature:@"muc_membersonly"];
}
-(NSString*)roomDescription{
    return ((XMPPChatRoomInfoField*)_fields[@"muc#roominfo_description"]).value;
}
-(NSString*)subject{
    return ((XMPPChatRoomInfoField*)_fields[@"muc#roominfo_subject"]).value;
}
-(int)occupants{
    return [((XMPPChatRoomInfoField*)_fields[@"muc#roominfo_occupants"]).value intValue];
}
-(NSString*)creationdate{
    return ((XMPPChatRoomInfoField*)_fields[@"x-muc#roominfo_creationdate"]).value;
}
@end
#pragma mark - DRRRChatRoom
@implementation XMPPChatRoom
-(NSString*)description{
    return [NSString stringWithFormat:@"<0x%lx %@ chatRoomJid=%@,name=%@, memberList=%@>",(unsigned long)self,[self class],self.chatRoomJid,self.name,self.memberList];
}
-(NSDictionary*)memberList{
    return _memberList;
}
-(id)initWithChatRoomJid:(NSString *)chatRoomJid{
    self=[super init];
    if (self){
        self.chatRoomJid=chatRoomJid;
        _memberList=[[NSMutableDictionary alloc]init];
    }
    return self;
}
-(void)updateChatRoomMember:(XMPPChatRoomMember *)chatRoomMember{
    if (![self.chatRoomJid isEqualToString:chatRoomMember.chatRoomJid]){
        NSLog(@"chat room not matched");
        return;
    }
    ///role none的时候从成员中删除
    if ([chatRoomMember.role isEqualToString:@"none"]){
        [_memberList removeObjectForKey:chatRoomMember.chatRoomMemberJid];
    }
    else{
        ///新的成员
        if (!_memberList[chatRoomMember.chatRoomMemberJid]){
            _memberList[chatRoomMember.chatRoomMemberJid]=chatRoomMember;
        }
        ///现有成员修改信息，只是复制数据
        else{
            XMPPChatRoomMember* member=_memberList[chatRoomMember.chatRoomMemberJid];
            ///改名了
            if (chatRoomMember.nick){
                member.chatRoomMembername=chatRoomMember.nick;
            }
            if (chatRoomMember.affiliation){
                member.affiliation=chatRoomMember.affiliation;
            }
            if (chatRoomMember.role){
                member.role=chatRoomMember.role;
            }
            if (chatRoomMember.show){
                member.show=chatRoomMember.show;
            }
            if (chatRoomMember.status){
                member.status=chatRoomMember.status;
            }
        }
    }
}
- (XMPPChatRoomMember*)chatRoomMember:(NSString *)chatRoomMemberJid{
    return _memberList[chatRoomMemberJid];
}
@end
