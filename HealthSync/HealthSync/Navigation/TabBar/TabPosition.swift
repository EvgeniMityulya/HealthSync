//
//  TabPosition.swift
//  HealthSync
//
//  Created by Евгений Митюля on 10/11/24.
//

import SwiftUI

/// `PositionKey` is a custom implementation of the `PreferenceKey` protocol in SwiftUI, designed to
/// facilitate the tracking and passing of view positions within a SwiftUI hierarchy. By utilizing this
/// structure, developers can easily retrieve the geometric frame of a view and make use of it in a
/// flexible manner, enhancing the interaction and layout capabilities of their applications.
///
/// ## Key Features:
/// - **Default Value**: The `defaultValue` is set to `.zero`, providing a base frame for the position
///   key, which can be useful for initializing layouts.
/// - **Reduce Functionality**: The `reduce` method allows for the aggregation of multiple frames into
///   a single value, enabling developers to handle position changes across multiple views efficiently.
///
/// The `viewPosition` extension method leverages `PositionKey` to provide a convenient way to capture
/// and respond to a view's geometry changes. This allows for more dynamic and responsive layouts that
/// can adapt to varying content sizes and positions, making `PositionKey` a valuable tool in any
/// SwiftUI developer's toolkit.
struct PositionKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

extension View {
    @ViewBuilder
    func viewPosition(completion: @escaping (CGRect) -> ()) -> some View {
        self
            .overlay {
                GeometryReader {
                    let rect = $0.frame(in: .global)
                    
                    Color.clear
                        .preference(key: PositionKey.self, value: rect)
                        .onPreferenceChange(PositionKey.self, perform: completion)
                }
            }
    }
}
