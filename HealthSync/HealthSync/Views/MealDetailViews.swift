//
//  MealDetailView2.swift
//  HealthSync
//
//  Created by Евгений Митюля on 10/24/24.
//

import SwiftUI

let dishes = [
    Dish(name: "Maftoul & Mozarella", rating: 4, imageName: "meal1", link: "https://www.youtube.com/watch?v=2SEIqdmV-yM"),
    Dish(name: "Caesar Salad", rating: 5, imageName: "meal1", link: "https://www.youtube.com/watch?v=2SEIqdmV-yM"),
    Dish(name: "Quinoa & Avocado", rating: 3, imageName: "meal1", link: "https://www.youtube.com/watch?v=2SEIqdmV-yM"),
    Dish(name: "Quinoa & Avocado", rating: 3, imageName: "meal1", link: "https://www.youtube.com/watch?v=2SEIqdmV-yM"),
]

struct MealDetailViews: View {
    @State private var selectedIndex: Int = 0 {
        didSet {
            print(self.selectedIndex)
        }
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 0) {
                ForEach(dishes.indices, id: \.self) { index in
                    MealView(
                        dish: dishes[index],
                        isSelected: Binding(
                            get: { self.selectedIndex == index },
                            set: { newValue in
                                if newValue {
                                    self.selectedIndex = index
                                }
                            }
                        )
                    )
                    .onAppear {
                        selectedIndex = index
                    }
                    .frame(width: UIScreen.main.bounds.width)
                }
            }
        }
        .scrollTargetBehavior(.paging)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    print("Back")
                }) {
                    Image(systemName: "chevron.left")
                        .imageScale(.large)
                        .bold()
                        .foregroundColor(.white)
                }
            }
            
            ToolbarItem(placement: .principal) {
                Text(dishes[selectedIndex].name)
                    .font(.title2)
                    .foregroundStyle(.white)
                    .bold()
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                HStack(spacing: 5) {
                    Button(action: {
                        print("Favourite meal")
                    }) {
                        Image(systemName: "bookmark")
                            .imageScale(.large)
                            .bold()
                            .foregroundColor(.white)
                    }
                    
                    Button(action: {
                        print("Add meal")
                    }) {
                        Image(systemName: "plus")
                            .imageScale(.large)
                            .bold()
                            .foregroundColor(.white)
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .background(.white)
    }
}


#Preview {
    NavigationView {
        MealDetailViews()
    }
}
