//
//  Friend.swift
//  Birthdays
//
//  Created by Nil Silva on 10/10/2025.
//

import Foundation
import SwiftData

@Model
class Friend {
    
    var name: String
    var birthday: Date
    
    init(name: String, birthday: Date){
        
        self.name = name
        self.birthday = birthday
        
    }
    
    var happyBirthday: Bool {
        
        let calendar = Calendar.current
        let today = Date()

        let todayComponents = calendar.dateComponents([.day, .month], from: today)
        let birthdayComponents = calendar.dateComponents([.day, .month], from: birthday)

        return todayComponents.day == birthdayComponents.day && todayComponents.month == birthdayComponents.month
        
    }
}
