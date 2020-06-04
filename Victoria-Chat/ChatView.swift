//
//  ContentView.swift
//  Victoria-Chat
//
//  Created by Oleg Lavronov on 6/3/20.
//  Copyright © 2020 Lundlay. All rights reserved.
//

import CoreData
import SwiftUI

// MARK:  Main conversation view

struct ChatView: View {
    
    @Environment(\.managedObjectContext) var context
    @ObservedObject private var keyboard = KeyboardResponder()
    
    // States
    @State var typingMessage: String = ""
    @State private var tableView: UITableView?
    
    init() {
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().tableFooterView = UIView()
        UITableView.appearance().backgroundColor = UIColor.viewBackground
        UITableViewCell.appearance().backgroundColor = UIColor.viewBackground
    }
    
    @FetchRequest(
        entity: Message.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Message.date, ascending: true)
        ]
    ) var messages: FetchedResults<Message>
    
    var body: some View {
        
        NavigationView {
            VStack {
                List(self.messages, id: \.self) { message in
                    ChatMessageView(message: message, isIncoming: message.user)
                }
                HStack {
                    TextField("Please, enter message...", text: self.$typingMessage)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(minHeight: CGFloat(30))
                    Button(action: self.actionSendMessage) {
                        Image(systemName: "paperplane.fill")
                    }
                }.frame(minHeight: CGFloat(50)).padding()
            }.navigationBarTitle(Text("Dialogue"), displayMode: .inline)
                .navigationBarItems(trailing:
                    Button(action: actionRefresh) {
                        Image(systemName: "arrow.clockwise")
                    }
            )
                .padding(.bottom, keyboard.height)
                .edgesIgnoringSafeArea(keyboard.height == 0.0 ? .leading: .bottom)
        }.onTapGesture {
            self.endEditing(true)
        }
        
    }
    
    
    // MARK:  Actions
    
    func actionSendMessage() {
        let message = Message(context: self.context)
        message.messageID = UUID().uuidString
        message.date = Date()
        message.body = typingMessage
        
        try? context.save()
        
        let say = self.typingMessage
        let reversed = String(self.typingMessage.reversed())
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let message = Message(context: self.context)
            message.messageID = UUID().uuidString
            message.date = Date()
            message.body = reversed
            message.user = false
            try? self.context.save()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                Speak.say(message: say)
            }
        }
        
        typingMessage = ""
    }
    
    func actionRefresh() {
        
        Message.decode(json: Mockup.messages).forEach {
            let message = Message(context: self.context)
            message.messageID = UUID().uuidString
            message.date = Date()
            message.body = $0.body
            message.user = $0.user ?? false
        }
        
        messages.forEach {
            context.delete($0)
        }
        try? context.save()

        // TODO: Update FetchRequest from CoreData background context
//        if let persistentContainer = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer {
//            let context = persistentContainer.newBackgroundContext()
//            context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
//            context.automaticallyMergesChangesFromParent = true
//
//            context.perform {
//
//                var objectIDArray:[NSManagedObjectID] = []
//
//                let fetchRequest:NSFetchRequest<NSFetchRequestResult> = Message.fetchRequest()
//                let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
//                batchDeleteRequest.resultType = .resultTypeObjectIDs
//
//                let result = try? context.execute(batchDeleteRequest) as? NSBatchDeleteResult
//
//                if let result = result?.result as? [NSManagedObjectID] {
//                    objectIDArray += result
//                }
//
//                try? context.save()
//                let changes = [NSDeletedObjectsKey : objectIDArray]
//                NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: [context])
//            }
//        }
        
    }
    
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}

