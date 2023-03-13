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

class TaskViewModel : NSObject, ObservableObject, UNUserNotificationCenterDelegate {
    //MARK: - PROPERTIES
    let realm = try? Realm()
    let notificationCenter = UNUserNotificationCenter.current()
    
    @Published var tasks : [Task] = []
    @Published var task : Task = Task()
    
    @Published var taskName : String = ""
    @Published var taskDate : Date = Date()
    
    
    var subscription = Set<AnyCancellable>()
    
    
    override init(){
        super.init()
        self.fetchTask()
   
        print("-----> \(Realm.Configuration.defaultConfiguration.fileURL!)")
        
        $taskName.sink { taskName in
            self.updateTaskName(taskName: taskName)
        }.store(in: &subscription)
        
        $taskDate.sink { taskDate in
            self.updateTaskDate(date: taskDate)
        }.store(in: &subscription)
        
        UNUserNotificationCenter.current().delegate = self
  
    }
    
    //MARK: - FUNCTION
    //Combine
    func updateTaskName(taskName : String) {
        self.task.taskName = taskName
    }
    
    func updateTaskDate(date: Date){
        self.task.date = date
    }
    
    
    //MARK: - REALM
    func fetchTask() {
        guard let realm = realm else { return }
        let results = realm.objects(Task.self).sorted(byKeyPath: "date", ascending: false)
        tasks = Array(results)
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
//    func deleteTask(){
//        func deleteTask(at offsets: IndexSet) {
//            guard let realm = realm else { return }
//            do {
//                try realm.write {
//                    // Delete the selected tasks from the realm database
//                    realm.delete(offsets.map { self.tasks[$0] })
//                }
//            } catch {
//                print("Error deleting tasks: \(error)")
//            }
//        }
//    }
    func deleteTask(task: Task) {
        guard let realm = realm else { return }
        do {
            try realm.write {
                realm.delete(task)
            }
        } catch {
            print("Error deleting task: \(error)")
        }
        
        fetchTask()
    }
    
    
    
    
    //initialise
    func eraseForm() {
        taskName = ""
        task = Task() // 새로운 빈 Task로 재설정
    }
    
    func askPermission(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound]) { success, error in
            if success {
                print("Access granted")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func sendNotification(date: Date, type: String, timeInterval: Double = 10, title: String, body: String){
        var trigger : UNNotificationTrigger?
        
        if type == "date"{
            let dateComponents = Calendar.current.dateComponents([.day,.month,.year,.hour,.minute], from: date)
            trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        } else if type == "time" {
            trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        }
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = taskName 
        content.sound = UNNotificationSound.default
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }



    

    
    // 포그라운드에서 알림을 표시하는 함수
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound, .badge, .list]) // 알림 센터에 유지되도록 .list 옵션 추가
    }

    
}
