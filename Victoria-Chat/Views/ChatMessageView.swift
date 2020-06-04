//
//  ChatMessageView.swift
//  Victoria-Chat
//
//  Created by Oleg Lavronov on 6/4/20.
//  Copyright © 2020 Lundlay. All rights reserved.
//

import SwiftUI

struct ChatMessageView: View {
    
    let message: Message
    let isIncoming: Bool
    
    private var textView: some View {
        Text(message.body ?? "")
            .padding(10)
            .padding(.leading, isIncoming ? 10 : 0)
            .padding(.trailing, isIncoming ? 0 : 10)
            .background(
                BuubleShape(radius: 5, arrowSize: CGSize(width: 11, height: 18), left: isIncoming)
                    .foregroundColor(isIncoming ? .bubbleBackground : .bubbleBackground)
                    .shadow(color: .black, radius: 1, x: 1, y: 1)
            )
    }
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            if self.isIncoming {
                self.textView
                Spacer()
            } else {
                Spacer()
                self.textView
                
            }
        }
    }
}
