//
//  StaticsticsView.swift
//  CryptoTracker
//
//  Created by Apple on 23/10/25.
//

import SwiftUI

struct StaticsticsView: View {
    
    let stat: StaticsticsModel
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(stat.title)
                .font(.caption)
                .foregroundColor(Color.theme.secondaryTextColor)
            Text(stat.value)
                .font(.headline)
                .foregroundColor(Color.theme.accentColor)
            HStack {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(Angle(degrees: (stat.percentage ?? 0) >= 0 ? 0 : 180 ))
                Text(stat.percentage?.asPercentageString() ?? "")
                    .font(.caption)
                    .bold()
            }.foregroundColor((stat.percentage ?? 0) >= 0 ? Color.theme.greenColor : Color.theme.redColor )
                .opacity(stat.percentage == nil ? 0.0 : 1.0)
        }
    }
}

//#Preview {
//    StaticsticsView(stat: )
//}


struct StaticsticsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StaticsticsView(stat: dev.stat1VM)
                .previewLayout(.sizeThatFits)
            StaticsticsView(stat: dev.stat2VM)
                .previewLayout(.sizeThatFits)
            StaticsticsView(stat: dev.stat3VM)
                .previewLayout(.sizeThatFits)
        }
    }
}
