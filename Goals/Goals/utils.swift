//
//  utils.swift
//  Goal
//
//  Created by celeglow on 2021/7/8.
//

import Foundation
import SwiftUI

func dateConvertor(_ date: Date, includeYear flag: Bool) -> String {
    let dateFormatter = DateFormatter()
    if(flag){dateFormatter.dateFormat = "YYYY-MM-dd"}
    else {dateFormatter.dateFormat = "MM-dd"}
    return dateFormatter.string(from: date)
}

let ColorList: [Color] = [.white, .black, .red, .orange, .yellow, .green, .blue, .purple, .pink]

let ColorName: [String] = ["white", "black", "red", "orange", "yellow", "green", "blue", "purple", "pink"]
