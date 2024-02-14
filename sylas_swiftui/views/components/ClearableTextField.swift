//
//  ClearableTextField.swift
//  sylas_swiftui
//
//  Created by Victor Rivera on 2/10/24.
//

import SwiftUI

struct ClearableTextField: View {
    @Binding var text: String
    var placeholder: String
        
    var body: some View {
        HStack {
            TextField(placeholder, text: $text)
                .padding(.leading, 10)
                .foregroundColor(.black)
            
            if !text.isEmpty {
                Button(action: { text = "" }) {
                    Image(systemName: "multiply.circle.fill")
                        .foregroundColor(.gray)
                        .padding(.trailing, 10)
                }
            }
        }
        .padding() // Adjust padding as needed
//        .background(Color(red: 0.2, green: 0.2, blue: 0.2))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray, lineWidth: 1)
        )
        //        .animation(.default, value: text.isEmpty) // Add smooth transition
        //        .fixedSize(horizontal: false, vertical: true)  Prevent resizing
    }
}

struct ClearableTextField_Previews: PreviewProvider {
    static var previews: some View {
        ClearableTextField(text: .constant("Madrid"), placeholder: "Enter text here")
            .padding()
    }
}
