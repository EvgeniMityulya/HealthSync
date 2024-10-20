//
//  temp.swift
//  HealthSync
//
//  Created by Евгений Митюля on 10/18/24.
//

import SwiftUI
import YouTubePlayerKit

struct Temp: View {
    let dishes = [
        Dish(name: "Maftoul & Mozarella", rating: 4, imageName: "meal1"),
        Dish(name: "Caesar Salad", rating: 5, imageName: "meal1"),
        Dish(name: "Quinoa & Avocado", rating: 3, imageName: "meal1"),
        Dish(name: "Quinoa & Avocado", rating: 3, imageName: "meal1"),
    ]
    
    init() {
        
        //        let appearance = UINavigationBarAppearance()
        //        appearance.configureWithOpaqueBackground()
        //        appearance.backgroundColor = UIColor(white: 0, alpha: 0)
        //        appearance.shadowColor = .clear
        //        UINavigationBar.appearance().standardAppearance = appearance
        //        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    @State private var selectedIndex = 0 {
        didSet {
            print(self)
        }
    }
    
    @State private var tabViewHeight: CGFloat = .zero
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .top) {
                Rectangle()
                    .fill(LinearGradient(
                        gradient: Gradient(colors: [Color("Green1"), Color("Green2")]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
                    .frame(height: 270)
                    .padding(.top, -100)
                    .ignoresSafeArea()
                
                HeightPreservingTabView(selection: $selectedIndex) {
                    ForEach(dishes.indices, id: \.self) { index in
                        LazyVStack(spacing: 0) {
                            Image(dishes[index].imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 400)
                                .shadow(color: .white, radius: 20, x: 0, y: -5)
                                .scaleEffect(selectedIndex == index ? 1.15 : 0.8)
                                .animation(.easeInOut(duration: 0.4), value: selectedIndex)
                                .border(.red)
                            
                            ForEach(0..<5, id: \.self) { _ in
                                Text(dishes[index].name)
                                    .font(.largeTitle)
                                    .frame(height: 50)
                                    .bold()
                            }
                        }
                        .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }
        }
        .scrollIndicators(.hidden)
    }
    
}

struct HeightPreservingTabView<SelectionValue: Hashable, Content: View>: View {
    var selection: Binding<SelectionValue>?
    @ViewBuilder var content: () -> Content
    
    @State private var minHeight: CGFloat = 1
    
    var body: some View {
        TabView(selection: selection) {
            content()
                .background {
                    GeometryReader { geometry in
                        Color.clear.preference(
                            key: TabViewMinHeightPreference.self,
                            value: geometry.frame(in: .local).height
                        )
                    }
                }
        }
        .frame(minHeight: minHeight)
        .onPreferenceChange(TabViewMinHeightPreference.self) { minHeight in
            self.minHeight = minHeight
        }
    }
}

private struct TabViewMinHeightPreference: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}

#Preview {
    Temp()
}
