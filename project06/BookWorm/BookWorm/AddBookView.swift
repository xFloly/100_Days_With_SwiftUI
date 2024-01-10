//
//  AddBookView.swift
//  BookWorm
//
//  Created by Student1 on 09/01/2024.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.modelContext) var modelContext
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Fantasy"
    @State private var review = ""
    
    let genres = ["Fantasy","Horror","Kids"]
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    TextField("Name of the book", text: $title)
                }
            }
        }
    }
}

#Preview {
    AddBookView()
}
