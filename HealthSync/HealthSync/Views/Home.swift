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
                
                Text("Services")
                    .tag(Tab.services)
                
                Text("Partners")
                    .tag(Tab.partners)
                
                Text("Activity")
                    .tag(Tab.activity)
            }
            .toolbar(.hidden, for: .tabBar)
            
            CustomTabBar()
        }
    }
    
    @ViewBuilder
    func CustomTabBar(_ tint: Color = Color("Blue"), _ inactiveTint: Color = .blue) -> some View {
        HStack(alignment: .bottom, spacing: 0) {
            ForEach(Tab.allCases, id: \.rawValue) {
                TabItem(
                    tint: tint,
                    inactiveTint: inactiveTint,
                    tab: $0,
                    animation: animation,
                    currentTab: $currentTab,
                    position: $tabShapePosition
                )
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
        .background {
            TabShape(midpoint: tabShapePosition.x)
                .fill(.white)
                .ignoresSafeArea()
                .shadow(color: tint.opacity(0.2), radius: 5, x: 0, y: -5)
                .blur(radius: 2)
                .padding(.top, 25)
        }
        .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7), value: currentTab)
    }
}

struct TabItem: View {
    var tint: Color
    var inactiveTint: Color
    var tab: Tab
    var animation: Namespace.ID
    
    @Binding var currentTab: Tab
    @Binding var position: CGPoint
    
    @State private var tabPosition: CGPoint = .zero
    
    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: tab.systemImage)
                .font(.title2)
                .foregroundStyle(currentTab == tab ? .white : inactiveTint)
                .frame(width: currentTab == tab ? 58 : 35, height: currentTab == tab ? 58 : 35)
                .background {
                    if currentTab == tab {
                        Circle()
                            .fill(tint.gradient)
                            .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                    }
                }
            
            Text(tab.rawValue)
                .font(.caption)
                .foregroundStyle(currentTab == tab ? tint : .gray)
        }
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
        .viewPosition(completion: { rect in
            tabPosition.x = rect.midX
            
            if currentTab == tab {
                position.x = rect.midX
            }
            
        })
        .onTapGesture {
            currentTab = tab
            
            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7,blendDuration: 0.7)) {
                position.x = tabPosition.x
            }
        }
    }
}

#Preview {
    ContentView()
}
