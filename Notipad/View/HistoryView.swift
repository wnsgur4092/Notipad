//
//  HistoryView.swift
//  Notipad
//
//  Created by JunHyuk Lim on 12/3/2023.
//

import SwiftUI

struct HistoryView: View {
    //MARK: - PROPERTEIS
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var taskViewModel : TaskViewModel
    
    @State private var isSelected = false
    @State private var selectedTasks: [Task] = []
    
    //MARK: - BODY
    var body: some View {
        NavigationView{
            List {
                ForEach(taskViewModel.tasks, id: \.id) { task in
                    HStack{
                        if isSelected {
                            Image(systemName: selectedTasks.contains(task) ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(Color.blue)
                                .onTapGesture {
                                    if selectedTasks.contains(task) {
                                        selectedTasks.removeAll { $0 == task }
                                    } else {
                                        selectedTasks.append(task)
                                    }
                                }
                        }
                        Text(task.taskName)
                        Spacer()
                        Button {
                            print("Resend Tapped")
                            //TODO: Resend 버튼이 눌렸을 때 실행될 코드를 추가
                        } label: {
                            Image(systemName: "paperplane.circle.fill")
                        }
                    }
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        let taskToDelete = taskViewModel.tasks[index]
                        taskViewModel.deleteTask(task: taskToDelete)
                    }
                }
            }
            .navigationBarTitle("History")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: backButton, trailing: EditButton())
        }
    }
    
    //MARK: - COMPONENTS
    
    fileprivate var deleteButton : some View {
        HStack{
            Spacer()
            
            Button {
                print("Deleted Button Tapped")
                for task in selectedTasks {
                    taskViewModel.deleteTask(task: task)
                }
                selectedTasks.removeAll()
                isSelected = false
            } label: {
                Image(systemName: "trash.fill")
                    .renderingMode(.original)
            }
        }
    }
    
    fileprivate var backButton : some View {
        Button {
            print("Back button tapped")
            presentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "xmark")
        }
    }
}

//MARK: - BODY
struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
            .environmentObject(TaskViewModel())
    }
}
