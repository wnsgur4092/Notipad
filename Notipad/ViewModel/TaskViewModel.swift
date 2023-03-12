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
import UserNotifications

class TaskViewModel : ObservableObject {
    //MARK: - PROPERTIES
    let realm = try? Realm()
    let notificationCenter = UNUserNotificationCenter.current()
    
    @Published var tasks : [Task] = []
    @Published var task : Task = Task()
    
    @Published var taskName : String = ""
    @Published var taskDate : Date = Date()
    
    
    var subscription = Set<AnyCancellable>()
    
    init(){
        print("-----> \(Realm.Configuration.defaultConfiguration.fileURL!)")
        
        $taskName.sink { taskName in
            self.updateTaskName(taskName: taskName)
        }.store(in: &subscription)
        
        $taskDate.sink { taskDate in
            self.updateTaskDate(date: taskDate)
        }.store(in: &subscription)
    }
    
    //MARK: - FUNCTION
    //Combine
    func updateTaskName(taskName : String) {
        self.task.taskName = taskName
    }
    
    func updateTaskDate(date: Date){
        self.task.date = date
    }
    
    //Save Data in Realm
    func saveTask() {
        do {
            try realm?.write {
                realm?.add(task)
            }
        } catch {
            print("\(error)")
        }
        
        task = Task()
        
        eraseForm()
    }
    
    //Delete Data in Realm
    
    
    //Send Notification
    func sendNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Notipad"
        content.body = taskName
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        notificationCenter.add(request) { error in
            if let error = error {
                print("Error Notification : \(error.localizedDescription)")
            }
        }
    }
    
    
    //initialise
    func eraseForm() {
        taskName = ""
        task = Task() // 새로운 빈 Task로 재설정
    }
}
