//
//  CompletedListView.swift
//  AnotherTodo
//
//  Created by Kuba Rejmann on 11/06/2024.
//

import SwiftUI
import SwiftData

struct CompletedListView: View {
    @Binding var showAll: Bool
    @Query private var completedList: [Todo]
    
    init(showAll: Binding<Bool>) {
        let predicate = #Predicate<Todo> { $0.isCompleted }
        let sort = [SortDescriptor(\Todo.updatedAt, order: .reverse)]
        
        var descriptor = FetchDescriptor(predicate: predicate, sortBy: sort)
        
        if !showAll.wrappedValue {
            descriptor.fetchLimit = 15
        }
        
        _completedList = Query(descriptor, animation: .snappy)
        _showAll = showAll
    }
    
    var body: some View {
        Section {
            ForEach(completedList) {
                TodoRow(todo: $0)
            }
        } header: {
            HStack {
                Text("Completed")
                
                Spacer()
                
                if showAll && !completedList.isEmpty {
                    Button("Show Recents") {
                        showAll = false
                    }
                }
            }.font(.caption)
        } footer: {
            if completedList.count == 15 && !showAll && !completedList.isEmpty {
                HStack {
                    Text("Showing Recent 15 Tasks")
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    Button("Show All") {
                        showAll = true
                    }
                }
                .font(.caption)
            }
        }
    }
}

#Preview {
    ContentView()
}
