//
//  CustomTabBar.swift
//  HealthSync
//
//  Created by Евгений Митюля on 10/14/24.
//

import SwiftUI

/// `CustomTabBar` is a SwiftUI view that implements a custom tab bar for navigating between different sections
/// of the application. It enhances user experience with visually appealing animations and a dynamic shape that
/// highlights the active tab.
///
/// ## Key Features:
/// - **Dynamic Tabs**: The tab bar iterates through all available tabs defined in the `Tab` enum, allowing for
///   easy customization and expansion of the navigation options.
/// - **Active Tab Highlighting**: The `tabShapePosition` binding tracks the position of the active tab, enabling
///   the `TabShape` to provide a visual cue above the selected tab, making it stand out.
/// - **Customizable Colors**: The `tint` and `inactiveTint` properties allow for customization of the tab colors,
///   ensuring that the tab bar aligns with the app's overall design theme.
/// - **Smooth Animations**: The `animation` modifier applies an interactive spring animation when switching
///   between tabs, enhancing the fluidity of user interactions.
///
/// The `CustomTabBar` is ideal for applications that prioritize a modern and engaging user interface, providing
/// a seamless navigation experience through its visually distinct tabs.
struct CustomTabBar: View {
    @Binding var currentTab: Tab
    @Binding var tabShapePosition: CGPoint
    var tint: Color = Color("Blue")
    var inactiveTint: Color = .blue
    var animation: Namespace.ID
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            ForEach(Tab.allCases, id: \.rawValue) { tab in
                TabItem(
                    tint: tint,
                    inactiveTint: inactiveTint,
                    tab: tab,
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
