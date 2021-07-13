//
//  TaskView.swift
//  Goal
//
//  Created by celeglow on 2021/7/10.
//

import SwiftUI

struct TaskView: View {
    @ObservedObject var main: Main
    let task: Task
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: task.isHistory ? "clock.fill": "timer")
                Text(task.title).font(.system(size: 20, weight: .bold))
                Spacer()
                Image(systemName: "star")
                
            }
            Spacer()
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Begin: ").font(.subheadline).foregroundColor(.gray)
                    
                    Text("End: ").font(.subheadline).foregroundColor(.gray)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(dateConvertor(task.beginDate, includeYear: false)).font(.subheadline).foregroundColor(.gray)
                    Text(dateConvertor(task.endDate, includeYear: false)).font(.subheadline).foregroundColor(task.isHistory ? .gray : .orange)
                }
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Total: ").font(.subheadline).foregroundColor(.gray)
                    Text("Done: ").font(.subheadline).foregroundColor(.gray)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("\(task.total)").font(.subheadline).foregroundColor(.gray)
                    Text("\(task.done)").font(.subheadline).foregroundColor(.green)
                }
                
            }
        }
        .padding()
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView(main: Main(), task: Task(title: "", tag: "", beginDate: Date(), endDate: Date(), done: 0, total: 1, color1: 1, color2: 2, i: 0))
    }
}
