//
//  Dish.swift
//  HealthSync
//
//  Created by Евгений Митюля on 10/25/24.
//

import SwiftUI

struct Dish: Identifiable {
    let id = UUID()
    let name: String
    let rating: Int
    let imageName: String
    let link: String
}
