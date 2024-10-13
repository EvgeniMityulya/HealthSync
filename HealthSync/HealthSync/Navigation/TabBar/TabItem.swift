//
//  TabItem.swift
//  HealthSync
//
//  Created by Евгений Митюля on 10/14/24.
//

import SwiftUI

/// `TabItem` is a SwiftUI `View` representing an individual item within a custom tab bar, designed to
/// provide an engaging and interactive user interface for navigating between different app sections.
/// Each tab item displays an icon and a label, dynamically reflecting its active or inactive state
/// based on user interaction.
///
/// ## Key Features:
/// - **Visual Feedback**: The appearance of the tab item changes based on its selection state,
///   utilizing different colors and sizes for active and inactive tabs, enhancing user experience.
/// - **Animation Support**: It supports smooth animations using the `matchedGeometryEffect`, providing
///   an appealing transition effect when switching between tabs.
/// - **Responsive Design**: The layout automatically adjusts to accommodate different screen sizes,
///   ensuring a consistent look across devices.
///
/// The `TabItem` view is essential for creating a custom tab bar that prioritizes usability and
/// aesthetics, making it a crucial component in enhancing the overall navigation experience within
/// SwiftUI applications.
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
