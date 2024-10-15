//
//  ContentView.swift
//  HealthSync
//
//  Created by Евгений Митюля on 10/9/24.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        Home()
            .preferredColorScheme(.light)
    }
}


#Preview {
    ContentView()
}
