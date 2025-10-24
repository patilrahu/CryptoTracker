//
//  XMarkButton.swift
//  CryptoTracker
//
//  Created by Apple on 24/10/25.
//

import SwiftUI

struct XMarkButton: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        Button(action: {
            dismiss()
        }, label: {
            Image(systemName: "xmark")
                .font(.headline)
        })
    }
}

#Preview {
    XMarkButton()
}
