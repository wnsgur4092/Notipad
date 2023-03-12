//
//  Task.swift
//  Notipad
//
//  Created by JunHyuk Lim on 12/3/2023.
//

import Foundation
import SwiftUI
import RealmSwift
import Realm

class Task : Object, Identifiable, Codable{
    
    @Persisted var id : UUID = UUID()
    @Persisted var taskName : String = ""
    @Persisted var date : Date = Date()
}

