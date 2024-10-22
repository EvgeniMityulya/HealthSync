//
//  temp.swift
//  HealthSync
//
//  Created by Евгений Митюля on 10/18/24.
//

import SwiftUI
import YouTubePlayerKit

struct Dish: Identifiable {
    let id = UUID()
    let name: String
    let rating: Int
    let imageName: String
}

struct MealDetailView: View {
    let dishes = [
        Dish(name: "Maftoul & Mozarella", rating: 4, imageName: "meal1"),
        Dish(name: "Caesar Salad", rating: 5, imageName: "meal1"),
        Dish(name: "Quinoa & Avocado", rating: 3, imageName: "meal1"),
        Dish(name: "Quinoa & Avocado", rating: 3, imageName: "meal1"),
    ]
    
    let links = [
        "https://www.youtube.com/watch?v=2SEIqdmV-yM",
        "https://www.youtube.com/watch?v=2SEIqdmV-yM",
        "https://www.youtube.com/watch?v=2SEIqdmV-yM",
        "https://www.youtube.com/watch?v=2SEIqdmV-yM"
    ]
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "Green4")
        appearance.shadowColor = .clear
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    @StateObject var youTubePlayer: YouTubePlayer = "https://www.youtube.com/watch?v=2SEIqdmV-yM"
    
    @State private var selectedIndex = 0 {
        didSet {
            print(self)
        }
    }
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .top) {
                Rectangle()
                    .fill(LinearGradient(
                        gradient: Gradient(colors: [Color("Green1"), Color("Green2")]),
                        startPoint: .top,
                        endPoint: .bottom
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
                            
                            Text(dishes[index].name)
                                .font(.largeTitle)
                                .frame(height: 50)
                                .bold()
                            
                            HStack {
                                ForEach(1...5, id: \.self) { star in
                                    Image(systemName: star <= dishes[index].rating ? "star.fill" : "star")
                                        .foregroundColor(star <= dishes[index].rating ? .orange : .gray)
                                }
                                
                                Text("\(dishes[index].rating)/5")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            .frame(height: 30)
                            .padding(.vertical, 4)
                            
                            HStack(alignment: .center, spacing: 60) {
                                Text("Easy level")
                                    .foregroundStyle(.green1)
                                
                                Rectangle()
                                    .frame(width: 1, height: 20)
                                    .foregroundColor(.gray)
                                
                                HStack {
                                    Image(systemName: "clock")
                                    
                                    Text("15 min")
                                    
                                }
                            }
                            .frame(height: 30)
                            .padding(.vertical, 4)
                            
                            
                            MealRecrangleInfoPFC()
                                .frame(height: 100)
                                .padding(.vertical, 20)
                                .padding(.horizontal, 16)
                            
                            MealDescription()
                            
                            VStack(alignment: .leading) {
                                Text("Cooking Tutorials")
                                    .font(.lato(style: .bold, size: 25))
                                
                                YouTubePlayerView(self.youTubePlayer) { state in
                                    switch state {
                                    case .idle:
                                        ProgressView()
                                    case .ready:
                                        ProgressView()
                                    case .error(let error):
                                        Text(verbatim: "YouTube player couldn't be loaded")
                                    }
                                }
                                .frame(height: 200)
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 14)
                        }
                        .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }
            
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    print("Back")
                }) {
                    ZStack {
                        Circle()
                            .foregroundStyle(.white)
                            .opacity(0.2)
                            .overlay(
                                Circle()
                                    .stroke(Color.white, lineWidth: 2)
                                    .opacity(0.5)
                            )
                        Image(systemName: "chevron.left")
                            .imageScale(.large)
                            .bold()
                            .foregroundColor(.white)
                    }
                    .frame(width: 40, height: 40)
                    .padding(.bottom, 20)
                }
            }
            
            ToolbarItem(placement: .principal) {
                Text("1/30")
                    .font(.title2)
                    .foregroundStyle(.white)
                    .bold()
                    .padding(.bottom, 10)
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    print("Add meal")
                }) {
                    ZStack {
                        Circle()
                            .foregroundStyle(.white)
                            .opacity(0.2)
                            .overlay(
                                Circle()
                                    .stroke(Color.white, lineWidth: 2)
                                    .opacity(0.5)
                            )
                        Image(systemName: "heart")
                            .imageScale(.large)
                            .bold()
                            .foregroundColor(.white)
                    }
                    .frame(width: 40, height: 40)
                    .padding(.bottom, 20)
                    .padding(.trailing, -10)
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    print("Add meal")
                }) {
                    ZStack {
                        Circle()
                            .foregroundStyle(.white)
                            .opacity(0.2)
                            .overlay(
                                Circle()
                                    .stroke(Color.white, lineWidth: 2)
                                    .opacity(0.5)
                            )
                        Image(systemName: "plus")
                            .imageScale(.large)
                            .bold()
                            .foregroundColor(.white)
                    }
                    .frame(width: 40, height: 40)
                    .padding(.bottom, 20)
                }
            }
            
        }
        .navigationBarTitleDisplayMode(.inline)
        .scrollIndicators(.hidden)
    }
    
}

struct MealDetailInfoPFC: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(spacing: 8) {
            Text(title)
                .font(.headline)
                .foregroundStyle(.white)
            
            Text(value)
                .font(.title2)
                .foregroundStyle(.white)
                .bold()
        }
    }
}

struct MealRecrangleInfoPFC: View {
    var body: some View {
        ZStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 15)
                .fill(LinearGradient(
                    gradient: Gradient(colors: [Color("Green2"), Color("Green1")]),
                    startPoint: .bottom,
                    endPoint: .top
                ))
                .padding(.horizontal, 5)
            
            
            HStack(spacing: 35) {
                MealDetailInfoPFC(
                    title: "Protein",
                    value: "160 g"
                )
                
                MealDetailInfoPFC(
                    title: "Carbs",
                    value: "45 g"
                )
                
                MealDetailInfoPFC(
                    title: "Kcal",
                    value: "451"
                )
                
                MealDetailInfoPFC(
                    title: "Fat",
                    value: "54"
                )
            }
            .padding()
            
        }
        
    }
}

struct MealDescription: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 25) {
                Text("Description")
                    .font(.lato(style: .bold, size: 25))
                
                Text("Maftoul & Mozzarella is a delightful blend of tender maftoul grains and creamy mozzarella. The dish combines the nutty, fluffy texture of maftoul with the smooth, rich taste of fresh mozzarella, finished with a touch of olive oil and fresh herbs. Perfect as a light meal or side dish, offering a balanced and satisfying flavor.")
                    .font(.lato(style: .regular, size: 20))
            }
            .padding(20)
        }
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
    NavigationView {
        MealDetailView()
    }
}
