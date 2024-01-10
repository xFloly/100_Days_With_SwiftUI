//
//  DetailView.swift
//  Bookworm
//
//  Created by Student1 on 09/01/2024.
//

import SwiftUI
import SwiftData
struct DetailView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert=false
    let book:Book
    
    var body: some View {
        ScrollView{
            ZStack{
                Image(book.genre)
                    .resizable()
                    .scaledToFit()
                Text(book.genre.uppercased())
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundStyle(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(.capsule)
                    .offset(x:-5,y: -5)
                
            }
            Text(book.author)
                .font(.title)
                .foregroundStyle(.secondary)
            Text(book.review)
                .padding()
            RatingView(rating: .constant(book.rating))
                .font(.largeTitle)
            Text(book.date.formatted(.dateTime.day().month().year()))
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Delete book", isPresented: $showingDeleteAlert){
            Button("Delete", role:.destructive, action: deleteBook)
            Button("Cancel",role:.cancel){}
        }message: {
            Text("Are your sure?")
        }
        .toolbar{
            Button("Delete this book",systemImage: "trash"){
                showingDeleteAlert=true
            }
        }
    }
    func deleteBook(){
        modelContext.delete(book)
        dismiss()
    }
}

#Preview {
    do{
        let config=ModelConfiguration(isStoredInMemoryOnly: true)
        let container=try ModelContainer(for: Book.self, configurations: config)
        let example=Book(title: "test", author: "test author", genre: "Fantasy", review: "good fajna", rating: 4)
        return DetailView(book: example)
            .modelContainer(container)
    }
    catch{
        return Text("failed: \(error.localizedDescription)")
    }
}
