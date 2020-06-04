//
//  View.swift
//  Victoria-Chat
//
//  Created by Oleg Lavronov on 6/4/20.
//  Copyright © 2020 Lundlay. All rights reserved.
//

import SwiftUI

extension View {
    
    func endEditing(_ force: Bool) {
        UIApplication.shared.windows.forEach { $0.endEditing(force)}
    }
    
}

