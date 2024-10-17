//
//  MealDetailView.swift
//  HealthSync
//
//  Created by Евгений Митюля on 10/17/24.
//

import SwiftUI

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
    
    init() {
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(white: 0, alpha: 0)
        appearance.shadowColor = .clear
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                ZStack(alignment: .top) {
                    GeometryReader { geometry in
                        Rectangle()
                            .fill(LinearGradient(
                                gradient: Gradient(colors: [Color("Green1"), Color("Green2")]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ))
                            .frame(height: 270)
                            .ignoresSafeArea()
                    }
                    
                    VStack {
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
                                        .padding(.top, -30)
                                    
                                    
                                    
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
                                    .frame(height: 100)
                                    .padding(.vertical, 20)
                                    .padding(.horizontal, 10)
                                    
                                    HStack {
                                        VStack(alignment: .leading, spacing: 25) {
                                            Text("Description")
                                                .font(.lato(style: .bold, size: 25))
                                            
                                            Text("Maftoul has been enjoyed for centuries in Middle 1 Eastern!")
                                                .font(.lato(style: .bold, size: 22))
                                            
                                            Text("Maftoul & Mozzarella is a delightful blend of tender maftoul grains and creamy mozzarella. The dish combines the nutty, fluffy texture of maftoul with the smooth, rich taste of fresh mozzarella, finished with a touch of olive oil and fresh herbs. Perfect as a light meal or side dish, offering a balanced and satisfying flavor.")
                                                .font(.lato(style: .regular, size: 20))
                                        }
                                        .padding(20)
                                        
                                    }
                                    
                                    Spacer()
                                    
                                }
                                .padding(.top, 50)
                                .frame(maxWidth: .infinity)
                            }
                        }
                        .frame(height: 1300)
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    }
                    .padding(.top, 20)
                }
                
            }
            .navigationBarTitleDisplayMode(.inline)
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
                        .frame(width: 45, height: 45)
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    Text("Details")
                        .font(.title2)
                        .foregroundStyle(.white)
                        .bold()
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
                        .frame(width: 45, height: 45)
                    }
                }
            }
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

#Preview {
    MealDetailView()
}


