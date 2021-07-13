//
//  Storage.swift
//  Goal
//
//  Created by celeglow on 2021/7/9.
//

import Foundation
import SwiftUI

protocol ObjectSavable {
    func setObject<Object>(_ object: Object, forKey: String) throws where Object: Encodable
    func getObject<Object>(forKey: String, castTo type: Object.Type) throws -> Object where Object: Decodable
    
}

enum ObjectSavableError: String, LocalizedError {
    case UnableToEncode = "Unable to encode object into data"
    case noValue = "No data object found for the goven key"
    case unableToDecode = "Unable to decode object into given type"
    
    var errorDescription: String? {
        rawValue
    }
}

extension UserDefaults: ObjectSavable {
    func setObject<Object>(_ object: Object, forKey: String) throws where Object : Encodable {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object)
            set(data, forKey: forKey)
        }catch{
            throw ObjectSavableError.UnableToEncode
        }
    }
    
    func getObject<Object>(forKey: String, castTo type: Object.Type) throws -> Object where Object : Decodable {
        guard let data = data(forKey: forKey) else {throw ObjectSavableError.noValue}
        let decoder = JSONDecoder()
        do {
            let object = try decoder.decode(type, from: data)
            return object
        } catch {
            throw ObjectSavableError.unableToDecode
        }
    }
    
}

struct Task: Codable, Hashable{
    var title: String
    var tag: String
    var beginDate: Date
    var endDate: Date
    var done: Int
    var total: Int
    var color1: Int
    var color2: Int
    var i: Int
    var timeProgress: Double {
        return isHistory ? 1 : (Date().distance(to: beginDate) / endDate.distance(to: beginDate))
    }
    var taskProgress: Double {
        return Double(done) / Double(total)
    }
    var isComplete: Bool {
        return done == total
    }
    var isHistory: Bool {
        return Date() > endDate
    }
}

let emptyTask = Task(title: "Run", tag: "Urgent", beginDate: Date(), endDate: Date(timeIntervalSinceNow: 100000), done: 1, total: 12, color1: 1, color2: 2, i: 0)

func saveData(tasks: [Task]) {
    do {
        try UserDefaults.standard.setObject(tasks, forKey: "Goal")
        print("save success")
    } catch {
        print(error.localizedDescription)
    }
}

func loadData() -> [Task]{
    do {
        let tasks = try UserDefaults.standard.getObject(forKey: "Goal", castTo: [Task].self)
        print("load success")
        return tasks
    } catch {
        print(error.localizedDescription)
        return []
    }
}




