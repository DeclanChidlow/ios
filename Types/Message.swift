//
//  Message.swift
//  Revolt
//
//  Created by Zomatree on 21/04/2023.
//

import Foundation

public struct Interactions: Codable, Equatable {
    public var reactions: [String]?
    public var restrict_reactions: Bool?
}

public struct Masquerade: Codable, Equatable {
    public var name: String?
    public var avatar: String?
    public var colour: String?
}

public struct TextSystemMessageContent: Codable, Equatable {
    public var content: String
}

public struct UserAddedSystemContent: Codable, Equatable {
    public var id: String
    public var by: String
}

public struct UserRemovedSystemContent: Codable, Equatable {
    public var id: String
    public var by: String
}

public struct UserJoinedSystemContent: Codable, Equatable {
    public var id: String
}

public struct UserLeftSystemContent: Codable, Equatable {
    public var id: String
}

public struct UserKickedSystemContent: Codable, Equatable {
    public var id: String
}

public struct UserBannedSystemContent: Codable, Equatable {
    public var id: String
}

public struct ChannelRenamedSystemContent: Codable, Equatable {
    public var name: String
    public var by: String
}

public struct ChannelDescriptionChangedSystemContent: Codable, Equatable {
    public var by: String
}

public struct ChannelIconChangedSystemContent: Codable, Equatable {
    public var by: String
}

public struct ChannelOwnershipChangedSystemContent: Codable, Equatable {
    public var from: String
    public var to: String
}

public enum SystemMessageContent: Equatable {
    case text(TextSystemMessageContent)
    case user_added(UserAddedSystemContent)
    case user_removed(UserRemovedSystemContent)
    case user_joined(UserJoinedSystemContent)
    case user_left(UserLeftSystemContent)
    case user_kicked(UserKickedSystemContent)
    case user_banned(UserBannedSystemContent)
    case channel_renamed(ChannelRenamedSystemContent)
    case channel_description_changed(ChannelDescriptionChangedSystemContent)
    case channel_icon_changed(ChannelIconChangedSystemContent)
    case channel_ownership_changed(ChannelOwnershipChangedSystemContent)
}

extension SystemMessageContent: Decodable {
    enum CodingKeys: String, CodingKey { case type }
    enum Tag: String, Decodable { case text, user_added, user_remove, user_joined, user_left, user_kicked, user_banned, channel_renamed, channel_description_changed, channel_icon_changed, channel_ownership_changed }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let singleValueContainer = try decoder.singleValueContainer()
        
        switch try container.decode(Tag.self, forKey: .type) {
            case .text:
                self = .text(try singleValueContainer.decode(TextSystemMessageContent.self))
            case .user_added:
                self = .user_added(try singleValueContainer.decode(UserAddedSystemContent.self))
            case .user_remove:
                self = .user_removed(try singleValueContainer.decode(UserRemovedSystemContent.self))
            case .user_joined:
                self = .user_joined(try singleValueContainer.decode(UserJoinedSystemContent.self))
            case .user_left:
                self = .user_left(try singleValueContainer.decode(UserLeftSystemContent.self))
            case .user_kicked:
                self = .user_kicked(try singleValueContainer.decode(UserKickedSystemContent.self))
            case .user_banned:
                self = .user_banned(try singleValueContainer.decode(UserBannedSystemContent.self))
            case .channel_renamed:
                self = .channel_renamed(try singleValueContainer.decode(ChannelRenamedSystemContent.self))
            case .channel_description_changed:
                self = .channel_description_changed(try singleValueContainer.decode(ChannelDescriptionChangedSystemContent.self))
            case .channel_icon_changed:
                self = .channel_icon_changed(try singleValueContainer.decode(ChannelIconChangedSystemContent.self))
            case .channel_ownership_changed:
                self = .channel_ownership_changed(try singleValueContainer.decode(ChannelOwnershipChangedSystemContent.self))
        }
    }
}

public struct Message: Identifiable, Decodable, Equatable {
    public init(id: String, content: String? = nil, author: String, channel: String, system: SystemMessageContent? = nil, attachments: [File]? = nil, mentions: [String]? = nil, replies: [String]? = nil, edited: String? = nil, masquerade: Masquerade? = nil, interactions: Interactions? = nil, reactions: [String : [String]]? = nil) {
        self.id = id
        self.content = content
        self.author = author
        self.channel = channel
        self.system = system
        self.attachments = attachments
        self.mentions = mentions
        self.replies = replies
        self.edited = edited
        self.masquerade = masquerade
        self.interactions = interactions
        self.reactions = reactions
    }
    
    public var id: String
    
    public var content: String?
    public var author: String
    public var channel: String
    public var system: SystemMessageContent?
    public var attachments: [File]?
    public var mentions: [String]?
    public var replies: [String]?
    public var edited: String?
    public var masquerade: Masquerade?
    public var interactions: Interactions?
    public var reactions: [String: [String]]?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case content, author, channel, system, attachments, mentions, replies, edited, masquerade, interactions, reactions
    }
}
