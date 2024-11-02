//
//  MealView.swift
//  HealthSync
//
//  Created by Евгений Митюля on 10/25/24.
//

import SwiftUI
import YouTubePlayerKit

struct MealView: View {
    let dish: Dish
    @Binding var isSelected: Bool
    @ObservedObject var youTubePlayer: YouTubePlayer = YouTubePlayer()
    
    init(dish: Dish, isSelected: Binding<Bool>) {
        self.dish = dish
        self.youTubePlayer = YouTubePlayer(
            source: .url(dish.link),
            configuration: .init(
                autoPlay: false
            )
        )
        
        self._isSelected = isSelected
    }
    
    var body: some View {
        GeometryReader { geometry in
            let scale = getScale(geometry: geometry)
            
            ScrollViewReader { scrollViewProxy in
                ScrollView(.vertical, showsIndicators: false) {
                    ZStack(alignment: .top) {
                        Rectangle()
                            .fill(LinearGradient(
                                gradient: Gradient(colors: [Color("Green1"), Color("Green2")]),
                                startPoint: .top,
                                endPoint: .bottom
                            ))
                            .id(0)
                            .frame(height: 270)
                            .padding(.top, -100)
                            .ignoresSafeArea()
                        
                        LazyVStack {
                            Image(dish.imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 400)
                                .shadow(color: .white, radius: 20, x: 0, y: -5)
                                .scaleEffect(scale)
                                .animation(.easeInOut(duration: 0.4), value: scale)
                            
                            Text(dish.name)
                                .font(.largeTitle)
                                .frame(height: 50)
                                .bold()
                            
                            HStack {
                                ForEach(1...5, id: \.self) { star in
                                    Image(systemName: star <= dish.rating ? "star.fill" : "star")
                                        .foregroundColor(star <= dish.rating ? .orange : .gray)
                                }
                                
                                Text("\(dish.rating)/5")
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
                    }
                }
                .onChange(of: isSelected) {
                    print(isSelected)
                    youTubePlayer.stop()
                    withAnimation {
                        scrollViewProxy.scrollTo(0, anchor: .top)
                    }
                }
                .refreshable {
                    print("Hello World")
                }
            }
            
            
        }
    }
    
    private func getScale(geometry: GeometryProxy) -> CGFloat {
        let xMin = geometry.frame(in: .global).minX
        let screenWidth = UIScreen.main.bounds.width
        let center = screenWidth / 2
        let distanceFromCenter = abs(center - xMin - (geometry.size.width / 2))
        let scale = 1 + (1 - min(distanceFromCenter / center, 1)) * 0.2
        return max(0.8, scale)
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

//#Preview {
//    MealView(dish: Dish.init(name: "Maftoul & Mozzarella", rating: 4, imageName: "meal1", link: "https://www.youtube.com/watch?v=2SEIqdmV-yM"))
//}
