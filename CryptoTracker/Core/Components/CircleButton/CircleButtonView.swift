//
//  CircleButtonView.swift
//  CryptoTracker
//
//  Created by Apple on 20/10/25.
//

import SwiftUI

struct CircleButtonView: View {
    let iconName: String
    var body: some View {
        Image(systemName: iconName)
            .font(.headline)
            .foregroundColor(Color.theme.accentColor)
            .frame(width: 50,height: 50)
            .background(Circle().foregroundColor(Color.theme.backgroundColor)
            ).shadow(color: Color.theme.accentColor.opacity(0.2), radius: 10,x: 0, y: 0)
            .padding()
            
    }
}

struct CircleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CircleButtonView(iconName: "info").previewLayout(.sizeThatFits)
            CircleButtonView(iconName: "plus").previewLayout(.sizeThatFits).colorScheme(.dark)
        }
    }
}

