//
//  Home.swift
//  HealthSync
//
//  Created by Евгений Митюля on 10/10/24.
//

import SwiftUI

struct Home: View {
    @State private var currentTab: Tab = .home
    @State private var tabShapePosition: CGPoint = .zero
    @Namespace private var animation
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $currentTab) {
                Text("Home")
                    .tag(Tab.home)
                
                
                Text("Activity")
                    .tag(Tab.activity)
                
                Text("Services")
                    .tag(Tab.services)
                
                Text("Partners")
                    .tag(Tab.partners) 
                
                Text("Account")
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
