//
//  XMPPIQAddition.m
//  FamilysHelper
//
//  Created by 曹亮 on 14/11/19.
//  Copyright (c) 2014年 FamilyTree. All rights reserved.
//


#import "XMPPIQAddition.h"
#import "xmpp.h"

@implementation XMPPIQ (addition)

-(BOOL)isRosterQuery{
    if (self.childCount>0){
        for (NSXMLElement* element in self.children) {
            if ([element.name isEqualToString:@"query"] && [element.xmlns isEqualToString:@"jabber:iq:roster"]){
                return YES;
            }
        }
    }
    return NO;
}
-(BOOL)isChatRoomItems{
    if (self.childCount>0){
        for (NSXMLElement* element in self.children) {
            if ([element.name isEqualToString:@"query"] &&
                [element.xmlns isEqualToString:@"http://jabber.org/protocol/disco#items"]){
                return YES;
            }
        }
    }
    return NO;
}
-(BOOL)isChatRoomInfo{
    if (self.childCount>0){
        for (NSXMLElement* element in self.children) {
            if ([element.name isEqualToString:@"query"] &&
                [element.xmlns isEqualToString:@"http://jabber.org/protocol/disco#info"]){
                BOOL has_identity=NO;
                BOOL has_feature=NO;
                for (NSXMLElement* element_item in element.children) {
                    if ([element_item.name isEqualToString:@"identity"]){
                        has_identity=YES;
                    }
                    if ([element_item.name isEqualToString:@"feature"]){
                        has_feature=YES;
                    }
                }
                return has_identity && has_feature;
            }
        }
    }
    return NO;
}
@end

@implementation XMPPPresence (addition)
-(BOOL)isChatRoomPresence{
    if (self.childCount>0){
        for (NSXMLElement* element in self.children) {
            if ([element.name isEqualToString:@"x"] &&
                [element.xmlns isEqualToString:@"http://jabber.org/protocol/muc#user"])
                return YES;
        }
    }
    return NO;
}
@end

@implementation XMPPMessage (addition)

-(BOOL)isChatRoomInvite{
    if (self.childCount>0){
        for (NSXMLElement* element in self.children) {
            if ([element.name isEqualToString:@"x"] && [element.xmlns isEqualToString:@"http://jabber.org/protocol/muc#user"]){
                for (NSXMLElement* element_a in element.children) {
                    if ([element_a.name isEqualToString:@"invite"]){
                        return YES;
                    }
                }
            }
        }
    }
    return NO;
}

@end

