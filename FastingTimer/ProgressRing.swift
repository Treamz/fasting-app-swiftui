//
//  ProgressRing.swift
//  FastingTimer
//
//  Created by Иван Чернокнижников on 17.01.2024.
//

import SwiftUI

struct ProgressRing: View {
    @EnvironmentObject var fastingManager: FastingManager
    
    let timer = Timer
        .publish(every: 1, on: .main, in: .common)
        .autoconnect()
    var body: some View {
        let spectrum = Gradient(colors: [
                   .red, .yellow, .green, .blue, .purple, .red
               ])
        ZStack {
            // Mark Placeholder Ring
            
            Circle()
                .stroke(lineWidth: 20)
                .foregroundColor(.gray)
                .opacity(0.1)
            
            // Mark colored ring
            
            Circle()
                .trim(from: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/,to:min(fastingManager.progress,  1.0))
                .stroke(AngularGradient(gradient:spectrum, center:/*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/),style:StrokeStyle(lineWidth: 15.0,lineCap: .round,lineJoin: .round))
                .rotationEffect(Angle(degrees: 270))
                .animation(.easeInOut(duration: 1.0), value: fastingManager.progress)
            
            VStack(spacing: 30) {
                if fastingManager.fastingState == .notStared {
                    VStack(spacing: 5) {
                        Text("Upcoming fast")
                            .opacity(0.7)
                        Text("\(fastingManager.fastingPlan.fastingPeriod.formatted()) Houres")
                            .font(.title)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    }
                
                } else {
                    // Marked elapsed time

                    VStack(spacing: 5) {
                        Text("Elapsed time (\(fastingManager.progress.formatted(.percent)))")
                            .opacity(0.7)
                        Text(fastingManager.startTime,style: .timer)
                            .font(.title)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    }
                    .padding(.top)
                    
                    VStack(spacing: 5) {
                        if(!fastingManager.elapsed) {
                            Text("Remaining time (\((1 - fastingManager.progress).formatted(.percent)))")
                                .opacity(0.7)
                        } else {
                            Text("Extra time")
                                .opacity(0.7)
                        }
                      
                        Text(fastingManager.endTime,style: .timer)
                            .font(.title2)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    }
                }
               
                
            }
        }
        .frame(width: 250, height: 250)
        .padding()
        .onReceive(timer) { _ in
            fastingManager.track()
        }
    }
}

#Preview {
    ProgressRing()
        .environmentObject(FastingManager())
}
