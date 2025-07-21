//
//  PinView.swift
//  MapApp
//
//  Created by Adrian Mazek on 21/07/2025.
//

import SwiftUI

struct PinView: View {
    var body: some View {
        VStack {
            Image(systemName: "map.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .font(.headline)
                .foregroundColor(.white)
                .padding(6)
                .background(.accent)
                .clipShape(RoundedRectangle(cornerRadius: 36))
            
            Image(systemName: "triangle.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(.accent)
                .frame(width: 10, height: 10)
                .rotationEffect(Angle(degrees: 180))
                .font(.headline)
                .offset(y: -3)
                .padding(.bottom,45)
        }
    }
}

#Preview {
    PinView()
}
