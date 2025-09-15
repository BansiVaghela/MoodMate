//
//  HeaderView.swift
//  MoodMate
//
//  Created by Bansi Vaghela on 13/07/25.
//

import SwiftUI

struct HeaderView: View {
    let headerData: HeaderData

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(headerData.title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color(hex: headerData.titleColor ?? "") ?? .blue)
                .frame(maxWidth: .infinity, alignment: .center)

            Text(headerData.subtitle)
                .font(.title3)
                .foregroundColor(Color(hex: headerData.subtitleColor ?? "") ?? .blue)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding()
    }
}

#Preview {
    HeaderView(headerData: HeaderData(
        title: "Preview Title",
        subtitle: "This is a subtitle from mock JSON",
        titleColor: "#FF5733",
        subtitleColor: "#FF5733"
    ))
}
