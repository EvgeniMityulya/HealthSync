//
//  Home.swift
//  HealthSync
//
//  Created by Евгений Митюля on 10/24/24.
//

import SwiftUI

struct Home: View {
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                Button {
                } label: {
                    Image(systemName: "chevron.left")
                }
                
                Spacer()
                
                HStack(spacing: 10) {
                    Button {
                    } label: {
                        Image(systemName: "heart")
                    }
                    
                    Button {
                    } label: {
                        Image(systemName: "ellipsis.message")
                    }
                }
            }
            .font(.title2)
            .overlay {
                Text("Posts")
                    .font(.title3.bold())
            }
            .foregroundStyle(.black)
            .padding(15)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    Home()
}
