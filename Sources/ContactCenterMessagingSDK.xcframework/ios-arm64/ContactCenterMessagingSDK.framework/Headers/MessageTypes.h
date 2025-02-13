//
//  MessageTypes.h
//  IOS MVP
//
//  Created by Microsoft on 9/26/17.
//  Copyright © 2024 Microsoft. All rights reserved.
//

typedef enum{
    TYPE_CHATLINE,
    TYPE_STATECHANGE,
    TYPE_CHATAUTHORIZED,
    TYPE_AUTOMATION_REQUEST,
    TYPE_MEMBER_CONNECTED,
    TYPE_COMMAND,
    TYPE_MEMBER_LOST,
    TYPE_AUTOMATION_CHAT,
    TYPE_CHAT_COMMUNICATION_SYSTEM,
    TYPE_CHAT_FILE_UPLOAD,
    TYPE_CHAT_WEBCALL
}MessageType;

#define MessageTypeArr  @"chatLine",  \
                        @"stateChange",   \
                        @"chat.authorized",   \
                        @"chat.automaton_request",  \
                        @"chatroom.member_connected",  \
                        @"command",  \
                        @"chatroom.member_lost",  \
                        @"chat.communication",  \
                        @"chat.communication_system",  \
                        @"chat.fileUpload",  \
                        @"chat.webCall",  \
                        nil

