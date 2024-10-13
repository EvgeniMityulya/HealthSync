//
//  TabShape.swift
//  HealthSync
//
//  Created by Евгений Митюля on 10/11/24.
//

import SwiftUI

/// `TabShape` is a custom `Shape` for SwiftUI that adds a unique visual curve to a tab bar, creating an engaging
/// effect that highlights the selected tab. The shape dynamically adjusts based on the `midpoint`, allowing for
/// smooth animations and transitions as the active tab changes.
///
/// ## Key Features:
/// - **Customizable Curve**: This shape features a gentle curve that creates a dip above the active tab,
///   making it appear as though the selected tab is highlighted or elevated.
/// - **Dynamic Midpoint**: The `midpoint` property controls the center of the curve, allowing the shape to
///   adjust seamlessly to changes, providing a visually smooth experience as users switch between tabs.
/// - **Animated Transitions**: Thanks to the `animatableData` property, the curve transitions smoothly
///   when the active tab shifts, adding a touch of polish to the tab bar’s interaction.
///
/// `TabShape` is ideal for creating custom tab bars where user experience is a priority, offering a modern
/// and fluid visual effect that can help your app stand out in terms of design and usability.
struct TabShape: Shape {
    var midpoint: CGFloat
    
    var animatableData: CGFloat {
        get { midpoint }
        set { midpoint = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.addRect(rect)
        
        let start = CGPoint(x: midpoint - 60, y: 0)
        let peak = CGPoint(x: midpoint, y: -25)
        let end = CGPoint(x: midpoint + 60, y: 0)
        
        let control1 = CGPoint(x: midpoint - 25, y: 0)
        let control2 = CGPoint(x: midpoint - 25, y: -25)
        let control3 = CGPoint(x: midpoint + 25, y: -25)
        let control4 = CGPoint(x: midpoint + 25, y: 0)
        
        path.move(to: start)
        path.addCurve(to: peak, control1: control1, control2: control2)
        path.addCurve(to: end, control1: control3, control2: control4)
        return path
    }
    
}
