import SwiftUI

struct ContentView: View {
    
    @State var tasks: [String] = []
    @State var newTask = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                
                // Input Field
                HStack {
                    TextField("Enter new task", text: $newTask)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button("Add") {
                        addTask()
                    }
                }
                .padding()
                
                // Task List
                List {
                    ForEach(tasks, id: \.self) { task in
                        Text(task)
                    }
                    .onDelete(perform: deleteTask)
                }
            }
            .navigationTitle("My Tasks")
        }
    }
    
    // Add Task
    func addTask() {
        if !newTask.isEmpty {
            tasks.append(newTask)
            newTask = ""
        }
    }
    
    // Delete Task
    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
}
