//
//  DishDetailView.swift
//  HealthSync
//
//  Created by Евгений Митюля on 10/18/24.
//

import SwiftUI
import YouTubePlayerKit

struct DishDetailView: View {
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
    @StateObject var youTubePlayer: YouTubePlayer = "https://youtube.com/watch?v=psL_5RIBqnY"
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                Rectangle()
                    .fill(LinearGradient(
                        gradient: Gradient(colors: [Color("Green1"), Color("Green2")]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
                    .frame(height: 270)
                    .ignoresSafeArea()
                
                TabView(selection: $selectedIndex) {
                    ForEach(dishes.indices, id: \.self) { index in
                        ScrollView {
                            ZStack(alignment: .top) {
                                VStack {
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
                                                EmptyView()
                                            case .error(let error):
                                                Text(verbatim: "YouTube player couldn't be loaded")
                                            }
                                        }
                                        .frame(height: 200)
                                    }
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 14)
                                }
                                .padding(.top, 70)
                            }
                        }
                        .ignoresSafeArea()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .scrollIndicators(.hidden)
                .background(.green0)
                .ignoresSafeArea(.all)
                .onChange(of: selectedIndex) { newIndex in
                    print("Текущий индекс: \(newIndex)")
                }
            }
        }
    }
}

#Preview {
    DishDetailView()
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
