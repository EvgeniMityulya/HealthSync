//
//  MealDetailView.swift
//  HealthSync
//
//  Created by Евгений Митюля on 10/17/24.
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
        Dish(name: "Quinoa & Avocado", rating: 3, imageName: "meal1")
    ]
    
    @State private var selectedIndex = 0
    @StateObject var youTubePlayer: YouTubePlayer = "https://youtube.com/watch?v=psL_5RIBqnY"
    init() {
        
        //        let appearance = UINavigationBarAppearance()
        //        appearance.configureWithOpaqueBackground()
        //        appearance.backgroundColor = UIColor(white: 0, alpha: 0)
        //        appearance.shadowColor = .clear
        //        UINavigationBar.appearance().standardAppearance = appearance
        //        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
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
                                                            
                                //                            HStack {
                                //                                ForEach(1...5, id: \.self) { star in
                                //                                    Image(systemName: star <= dishes[index].rating ? "star.fill" : "star")
                                //                                        .foregroundColor(star <= dishes[index].rating ? .orange : .gray)
                                //                                }
                                //                                
                                //                                Text("\(dishes[index].rating)/5")
                                //                                    .font(.subheadline)
                                //                                    .foregroundColor(.gray)
                                //                            }
                                //                            .frame(height: 30)
                                //                            .padding(.vertical, 4)
                                //                            
                                //                            HStack(alignment: .center, spacing: 60) {
                                //                                Text("Easy level")
                                //                                    .foregroundStyle(.green1)
                                //                                
                                //                                Rectangle()
                                //                                    .frame(width: 1, height: 20)
                                //                                    .foregroundColor(.gray)
                                //                                
                                //                                HStack {
                                //                                    Image(systemName: "clock")
                                //                                    
                                //                                    Text("15 min")
                                //                                    
                                //                                }
                                //                            }
                                //                            .frame(height: 30)
                                //                            
                                //                            
                                //                            MealRecrangleInfoPFC()
                                //                                .frame(height: 100)
                                //                                .padding(.vertical, 20)
                                //                                .padding(.horizontal, 16)
                                //                            
                                //                            MealDescription()
                                //                            
                                //                            VStack(alignment: .leading) {
                                //                                
                                //                                Text("Cooking Tutorials")
                                //                                    .font(.lato(style: .bold, size: 25))
                                //                                
                                //                                YouTubePlayerView(self.youTubePlayer) { state in
                                //                                    switch state {
                                //                                    case .idle:
                                //                                        ProgressView()
                                //                                    case .ready:
                                //                                        EmptyView()
                                //                                    case .error(let error):
                                //                                        Text(verbatim: "YouTube player couldn't be loaded")
                                //                                    }
                                //                                }
                                //                                .frame(height: 200)
                                //                            }
                                //                            .padding(.horizontal, 20)
                                //                            .padding(.vertical, 14)
                            }
                            .padding(.top, 70)
                            .frame(maxHeight: .infinity)
                        }
                    }
                    .frame(maxHeight: .infinity)
                    .ignoresSafeArea()
                }
                .ignoresSafeArea()
//                .frame(maxHeight: .infinity)
//                                    .frame(height: 1300)
//                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            //            .navigationBarTitleDisplayMode(.inline)
//            .toolbar {
//                ToolbarItem(placement: .topBarLeading) {
//                    Button(action: {
//                        print("Back")
//                    }) {
//                        ZStack {
//                            Circle()
//                                .foregroundStyle(.white)
//                                .opacity(0.2)
//                                .overlay(
//                                    Circle()
//                                        .stroke(Color.white, lineWidth: 2)
//                                        .opacity(0.5)
//                                )
//                            Image(systemName: "chevron.left")
//                                .imageScale(.large)
//                                .bold()
//                                .foregroundColor(.white)
//                        }
//                        .frame(width: 45, height: 45)
//                    }
//                }
//                
//                ToolbarItem(placement: .principal) {
//                    Text("Details")
//                        .font(.title2)
//                        .foregroundStyle(.white)
//                        .bold()
//                }
//                
//                ToolbarItem(placement: .topBarTrailing) {
//                    Button(action: {
//                        print("Add meal")
//                    }) {
//                        ZStack {
//                            Circle()
//                                .foregroundStyle(.white)
//                                .opacity(0.2)
//                                .overlay(
//                                    Circle()
//                                        .stroke(Color.white, lineWidth: 2)
//                                        .opacity(0.5)
//                                )
//                            Image(systemName: "plus")
//                                .imageScale(.large)
//                                .bold()
//                                .foregroundColor(.white)
//                        }
//                        .frame(width: 45, height: 45)
//                    }
//                }
//            }
            .scrollIndicators(.hidden)
            .ignoresSafeArea()
        }
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

#Preview {
    MealDetailView()
}


