//
//  SearchBarView.swift
//  CryptoTracker
//
//  Created by Apple on 23/10/25.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(
                    searchText.isEmpty ?
                    Color.theme.secondaryTextColor : Color.theme.accentColor)
            TextField("Search By Name or Symbol", text: $searchText)
                .foregroundColor(Color.theme.accentColor)
                .disableAutocorrection(true)
                .overlay (
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .foregroundColor(Color.theme.accentColor)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            searchText = ""
                            UIApplication.shared.endEditing()
                        }
                    ,alignment: .trailing
                )
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.backgroundColor)
                .shadow(
                    color: Color.theme.accentColor.opacity(0.15),
                    radius: 10,x: 0,y: 0)
        ).padding()
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SearchBarView(searchText: .constant("")).preferredColorScheme(.dark)
            SearchBarView(searchText: .constant("")).preferredColorScheme(.light)
        }
    }
}
