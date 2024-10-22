//
//  Tab.swift
//  HealthSync
//
//  Created by Евгений Митюля on 10/10/24.
//

/// `Tab` is an enumeration that defines the different tabs available in a custom tab bar within a SwiftUI application.
/// Each case corresponds to a specific section of the app, represented by a string raw value and associated icon.
///
/// ## Key Features:
/// - **Tab Cases**: The enum includes cases for `home`, `services`, `partners`, and `activity`, each representing
///   a distinct feature of the application.
/// - **System Image**: Each tab is associated with a system image, providing a visual representation that enhances
///   user navigation and experience. The `systemImage` computed property returns the appropriate SF Symbol
///   based on the current tab.
/// - **Indexing**: The `index` property allows for easy retrieval of the tab's position in the list, facilitating
///   management of tab selection and animations in the tab bar.
///
/// The `Tab` enum serves as a centralized definition of the application’s navigation structure, enabling
/// consistency and ease of use throughout the app.
enum Tab: String, CaseIterable {
    case home = "Home"
    case activity = "Social"
    case services = "Tracker"
    case partners = "Calculator"
    case profile = "Profile"
    
    var systemImage: String {
        switch self {
        case .home: return "house"
        case .activity: return "person.3.fill"
        case .services: return "figure.run"
        case .partners: return "fork.knife"
        case .profile: return "person.fill"
        }
    }
    
    var index: Int {
        return Tab.allCases.firstIndex(of: self) ?? 0
    }
}
