//
//  BookWormApp.swift
//  BookWorm
//
//  Created by Student1 on 09/01/2024.
//

import SwiftData
import SwiftUI

@main
struct BookWormApp: App {
    var body: some Scene {
        WindowGroup{
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
