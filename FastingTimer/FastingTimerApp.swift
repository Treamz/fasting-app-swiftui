//
//  FastingTimerApp.swift
//  FastingTimer
//
//  Created by Иван Чернокнижников on 17.01.2024.
//

import SwiftUI

@main
struct FastingTimerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(FastingManager())
        }
    }
}
