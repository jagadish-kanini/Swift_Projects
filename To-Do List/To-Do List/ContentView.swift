import SwiftUI

struct ContentView: View {
    
    @State var tasks: [String] = []
    @State var newTask = ""
    @State var editingIndex: Int? = nil
    @State var editingText = ""
    
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
                    ForEach(tasks.indices, id: \.self) { index in
                        HStack {
                            Text(tasks[index])
                            Spacer()
                            Button {
                                editingIndex = index
                                editingText = tasks[index]
                            } label: {
                                Image(systemName: "pencil")
                                    .foregroundColor(.blue)
                            }
                            .buttonStyle(.borderless)
                            
                            Button {
                                tasks.remove(at: index)
                            } label: {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }
                            .buttonStyle(.borderless)
                        }
                    }
                    .onDelete(perform: deleteTask)
                }
            }
            .navigationTitle("My Tasks")
            .sheet(isPresented: Binding(
                get: { editingIndex != nil },
                set: { if !$0 { editingIndex = nil } }
            )) {
                NavigationStack {
                    VStack(spacing: 20) {
                        TextField("Edit task", text: $editingText)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        Spacer()
                    }
                    .navigationTitle("Edit Task")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") { editingIndex = nil }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Save") {
                                if let index = editingIndex, !editingText.isEmpty {
                                    tasks[index] = editingText
                                }
                                editingIndex = nil
                            }
                        }
                    }
                }
                .presentationDetents([.fraction(0.3)])
            }
        }
    }
    
    func addTask() {
        if !newTask.isEmpty {
            tasks.append(newTask)
            newTask = ""
        }
    }
    
    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
}
