//
//  TaskDetailView.swift
//  HelloFirebase
//
//  Created by Don McKenzie on 11/6/21.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift


struct TaskDetailView: View {

    let db: Firestore = Firestore.firestore()
    let task: Task
    @State private var title: String = ""
        
    private func updateTask() {
        db.collection("tasks")
            .document(task.id!)
            .updateData([
                "title": title
            ]) {error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print("Update succesful")
                }
            }
    }
    
    var body: some View {
        VStack {
            TextField(task.title, text: $title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button("Update") {
                updateTask()
//                let task = Task(title: title)
//                saveTask(task: task)
            }
        }.padding()
    }
}

struct TaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetailView(task: Task(id: "1234", title: "Preview task"))
    }
}
