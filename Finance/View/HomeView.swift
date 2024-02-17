//
//  HomeView.swift
//  Finance
//
//  Created by Elme delos Santos on 2/17/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Home")
                
                Spacer()
                
                MenuView()
            }
            .navigationTitle("Home")
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    HomeView()
}
