//
//  ListView.swift
//  AnotherTodo
//
//  Created by Kuba Rejmann on 11/06/2024.
//

import SwiftUI
import SwiftData

struct ListView: View {
    @Query(filter: #Predicate<Todo> {!$0.isCompleted}, sort: [SortDescriptor(\Todo.updatedAt, order: .reverse)], animation: .snappy)
    var activeList: [Todo]
    
    @Environment(\.modelContext) private var context
    @Environment(\.colorScheme) private var scheme
    
    @State private var showAll: Bool = false
    @State private var themeSelect: Bool = false
    
    @AppStorage("userTheme") private var userTheme: Theme = .systemDefault
   
    
    var body: some View {
        List {
            Section(activeSectionTitle) {
                ForEach(activeList) {
                    TodoRow(todo: $0)
                }
            }
            
            CompletedListView(showAll: $showAll)
        }
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button(action: {
                    themeSelect = true
                }, label: {
                    Image(systemName: userTheme == .dark ? "moon.fill" : "sun.max.fill")
                        .foregroundColor(userTheme == .dark ? .moon : .sun)
                })
            }
            
            ToolbarItem(placement: .bottomBar) {
                Button(action: {
                    let todo = Todo(task: "", priority: Priority.low)
                    context.insert(todo)
                }, label: {
                    Image(systemName: "plus.circle.fill")
                        .fontWeight(.light)
                        .font(.system(size: 42))
                        .foregroundColor(.accentColor)
                })
            }
        }
        .preferredColorScheme(userTheme.colorScheme)
        .sheet(isPresented: $themeSelect, content: {
            ThemeSelect(scheme: scheme)
                .presentationDetents([.height(410)])
                .presentationBackground(.clear)
        })
    }
    
    var activeSectionTitle: String {
        let count = activeList.count
        return count == 0 ? "Active" : "Active (\(count))"
    }
}

#Preview {
    ContentView()
}
