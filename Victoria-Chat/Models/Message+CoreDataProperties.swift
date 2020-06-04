//
//  Message+CoreDataProperties.swift
//  Victoria-Chat
//
//  Created by Oleg Lavronov on 6/4/20.
//  Copyright © 2020 Lundlay. All rights reserved.
//
//

import Foundation
import CoreData


extension Message {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Message> {
        return NSFetchRequest<Message>(entityName: "Message")
    }

    @NSManaged public var body: String?
    @NSManaged public var date: Date?
    @NSManaged public var messageID: String?
    @NSManaged public var user: Bool

}


extension Message {
    
    struct Properties: Codable {

        enum CodingKeys: String, CodingKey {
            case body = "line"
            case user
        }
        
        var body: String?
        var user: Bool? = false

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encodeIfPresent(body, forKey: .body)
            try container.encodeIfPresent(user, forKey: .user)
        }
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            body = try container.decodeIfPresent(String.self, forKey: .body)
            user = try container.decode(Bool.self, forKey: .user)
        }

    }
    
    static func decode(json: String?) -> [Message.Properties] {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        var messages: [Message.Properties] = []
        
        if let json = json,
            let data = json.data(using: .utf8) {
            do {
                messages = try decoder.decode([Message.Properties].self, from: data)
            } catch {
                debugPrint("\(error)")
            }
        }
        return messages
    }

}
