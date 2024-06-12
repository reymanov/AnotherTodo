//
//  ContentView.swift
//  AnotherTodo
//
//  Created by Kuba Rejmann on 11/06/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ListView()
                .navigationTitle("Another Todo")
        }
    }
}

#Preview {
    ContentView()
}
