//
//  ContentView.swift
//  HealthSync
//
//  Created by Евгений Митюля on 10/9/24.
//

import SwiftUI

struct ContentView: View {
    @State private var currentTab: Tab = .home
    @State private var tabShapePosition: CGPoint = .zero
    @Namespace private var animation
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $currentTab) {
                Home()
                    .tag(Tab.home)
                
                Social()
                    .tag(Tab.social)
                
                Tracker()
                    .tag(Tab.tracker)
                
                Calculator()
                    .tag(Tab.calculator)
                
                Profile()
                    .tag(Tab.profile)
            }
            .toolbar(.hidden, for: .tabBar)
            
            CustomTabBar(
                currentTab: $currentTab,
                tabShapePosition: $tabShapePosition,
                animation: animation
            )
        }
    }
}


#Preview {
    ContentView()
}
