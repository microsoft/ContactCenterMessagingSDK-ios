//
//  AgentHiddenMessageHandler.h
//  ContactCenterMessagingSDK
//
//  Created by Microsoft on 08/12/22.
//  Copyright © 2024 Microsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AgentHiddenMessageHandler : NSObject {
    NSMutableSet *agentExcludedMessageList;
}

-(void) addHiddenMessage:(NSString *)strObject;
-(void) clearHiddenMessages;
-(void) removeHiddenMessage:(NSString *)strObject;
- (NSMutableArray *)getMessages ;
-(void) setHiddenMessages:(NSMutableSet *)array;
+ (instancetype)sharedObject;
@end
