
import SwiftUI
import SwiftData


struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort:[
        SortDescriptor(\Book.rating, order: .reverse),
        SortDescriptor(\Book.title),
        SortDescriptor(\Book.author)
    ]) var books: [Book]
    @State private var showingAddScreen=false
    @State private var remeberMe=false
    var body: some View {
        NavigationStack{
            List{
                ForEach(books){
                    book in
                    NavigationLink(value:book){
                        HStack{
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            VStack(alignment: .leading){
                                Text(book.title)
                                    .font(.headline)
                                //challenge 2
                                    .foregroundStyle((book.rating==1) ? .red : .black)
                                
                                Text(book.author)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }.onDelete(perform:deleteBooks)
            }
                .navigationTitle("Bookwarm")
                .navigationDestination(for: Book.self){
                    book in
                    DetailView(book: book)
                }
                .toolbar{
                    ToolbarItem(placement: .topBarLeading){
                        EditButton()
                    }
                    ToolbarItem(placement:.topBarTrailing){
                        Button("Add Book",systemImage: "plus"){
                            showingAddScreen.toggle()
                        }
                    }
                }
                .sheet(isPresented: $showingAddScreen, content: {
                    AddBookView()
                })
        }
    }
    func deleteBooks(at offsets:IndexSet){
        for offset in offsets{
            let book = books[offset]
            modelContext.delete(book)
        }
    }
}

#Preview {
    ContentView()
}
