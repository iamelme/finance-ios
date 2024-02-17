//
//  ProfileHeaderView.swift
//  Finance
//
//  Created by Elme delos Santos on 1/28/24.
//

import SwiftUI

struct ProfileHeaderView: View {
    let firstName: String
    let lastName: String
    
    var body: some View {
        HStack {
            Text(firstName)
            Text(lastName)
        }
    }
}

#Preview {
    ProfileHeaderView(firstName: "", lastName: "")
}
