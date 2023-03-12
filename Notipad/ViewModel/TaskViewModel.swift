//
//  TaskViewModel.swift
//  Notipad
//
//  Created by JunHyuk Lim on 12/3/2023.
//

import Foundation
import SwiftUI
import Combine
import RealmSwift

class TaskViewModel : ObservableObject {
    //MARK: - PROPERTIES
    let realm = try? Realm()
    
    @Published var tasks : [Task] = []
    @Published var task : Task = Task()
    @Published var taskName : String = ""
    
    
    var subscription = Set<AnyCancellable>()
    
    init(){
        print("-----> \(Realm.Configuration.defaultConfiguration.fileURL!)")
        
        $taskName.sink { taskName in
            self.updateTaskName(taskName: taskName)
        }.store(in: &subscription)

        
    }
    
    //MARK: - FUNCTION
    //Combine
    func updateTaskName(taskName : String) {
        self.task.taskName = taskName
    }
    
    func updateDate(date: Date){
        self.task.date = date
    }
    
    
    func saveTask() {
        do{
            try realm?.write{
                realm?.add(tasks)
            }
        }
        catch {
            print("\(error)")
        }
        
        eraseForm()
    }
    
    
    
    func eraseForm() {
        taskName = ""
    }
    
}
