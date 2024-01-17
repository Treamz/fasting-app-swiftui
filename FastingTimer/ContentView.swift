//
//  ContentView.swift
//  FastingTimer
//
//  Created by Иван Чернокнижников on 17.01.2024.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var fastingManager = FastingManager()
    
    var title:String {
        switch fastingManager.fastingState {
        case .notStared:
            return "Let's get started!"
        case .fasting:
            return "You are now fasting"
        case .feeding:
            return "You are now feeding"
        }
    }
    var body: some View {
        ZStack {
            // Background
            Color(#colorLiteral(red: 0.08604868501, green: 0.003453195561, blue: 0.1562642455, alpha: 1))
                .ignoresSafeArea()
            
            content
        }
    }
    
    var content : some View {
        ZStack {
            // Mark title
            VStack(spacing: 40) {
                
                Text(title)
                    .font(.headline)
                    .foregroundColor(Color(.blue))
                Text(fastingManager.fastingPlan.rawValue)
                    .fontWeight(.semibold)
                    .padding(.horizontal,24)
                    .padding(.vertical,8)
                    .background(.thinMaterial)
                    .cornerRadius(20)
                Spacer()
                
            }
            .padding()
            
            // Mark Progress Ring
            VStack {
                ProgressRing()
                    .environmentObject(fastingManager)
                
                HStack(spacing: 60) {
                    VStack(spacing: 5) {
                        Text(fastingManager.fastingState == .notStared ? "Start" : "Started")
                            .opacity(0.7)
                        Text(fastingManager.startTime,format: .dateTime.weekday().hour().minute().second())
                            .fontWeight(.bold)
                    }
                    
                    VStack(spacing: 5) {
                        Text(fastingManager.fastingState == .notStared ? "End" : "Ends")
                            .opacity(0.7)
                        Text(fastingManager.endTime,format: .dateTime.weekday().hour().minute().second())
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    }
                    
                }
                
                Button {
                    fastingManager.toggleFastingState()
                } label: {
                    Text(fastingManager.fastingState == .fasting ? "End fasting" : "Start fasting")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding(.horizontal,24)
                        .padding(.vertical,8)
                        .background(.thinMaterial)
                        .cornerRadius(20)
                    
                }
            }
            .padding()
            .foregroundColor(.white)
        }
    }
}

#Preview {
    ContentView()
}
