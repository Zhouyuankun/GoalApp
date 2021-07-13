//
//  EditDetails.swift
//  Goal
//
//  Created by celeglow on 2021/7/10.
//

import SwiftUI

struct EditDetails: View {
    @ObservedObject var main: Main
    @State var confirmCancel: Bool = false
    @State var sliderEdit = false
    
    var body: some View {
        //Bottom CardView
        VStack(spacing: 20) {
            Rectangle()
                .frame(width: 40, height: 5)
                .cornerRadius(3)
                .opacity(0.1)
            
            if creatingMode {
                HStack {
                    Button(action: {
                        creatingMode = false
                        editingMode = false
                    }, label: {
                        Text("Cancel")
                    })
                    Spacer()
                    Button(action: {
                        
                        let newTask = Task(title: self.main.taskTitle, tag: self.main.taskTag, beginDate: self.main.taskBeginDate, endDate: self.main.taskEndDate, done: main.taskDone, total: main.taskTotal, color1: main.taskColor1, color2: main.taskColor2, i: self.main.tasks.count)
                       
                        self.main.tasks.append(newTask)
                        self.main.sort()
                        
                        //do save
                        saveData(tasks: self.main.tasks)
                        
                        creatingMode = false
                        editingMode = false
                    }, label: {
                        Text("Add")
                    }).disabled(main.taskTitle == "")
                }
            } else {
                HStack {
                    Button(action: {
                        editingMode = false
                    }, label: {
                        Text("Cancel")
                    })
                    Spacer()
                    Button(action: {
                        self.main.tasks[editingIndex].title = self.main.taskTitle
                        self.main.tasks[editingIndex].tag = self.main.taskTag
                        self.main.tasks[editingIndex].beginDate = self.main.taskBeginDate
                        self.main.tasks[editingIndex].endDate = self.main.taskEndDate
                        self.main.tasks[editingIndex].done = self.main.taskDone
                        self.main.tasks[editingIndex].total = self.main.taskTotal
                        self.main.tasks[editingIndex].color1 = self.main.taskColor1
                        self.main.tasks[editingIndex].color2 = self.main.taskColor2
                        
                        //let home sort
                        
                        //do save
                        saveData(tasks: self.main.tasks)
                        
                        editingMode = false
                    }, label: {
                        Text("Apply")
                    })
                }
                
            }
            
//            HStack {
//                if creatingMode {
//                    Button(action: {self.confirmCancel = false}, label: {
//                        Text("Edit")
//                    })
//                    Button(action: {
//                            self.confirmCancel = false
//                            self.main.detailsShowing = false
//                    }, label: {
//                        Text("GiveUp")
//                    })
//                } else {
//                    Button(action: {
//                        if(!editingMode && self.main.taskTitle == "") {
//                            self.main.detailsShowing = false
//                        } else {
//                            self.confirmCancel = true
//                        }
//                    }, label: {
//                        Text("Cancel")
//                    })
//                }
//                Spacer()
//                if !confirmCancel {
//                    Button(action: {
//                        if !editingMode {
//                            self.main.tasks[editingIndex].title = self.main.taskTitle
//                            self.main.tasks[editingIndex].tag = self.main.taskTag
//                            self.main.tasks[editingIndex].beginDate = self.main.taskBeginDate
//                            self.main.tasks[editingIndex].endDate = self.main.taskEndDate
//                            self.main.tasks[editingIndex].done = self.main.taskDone
//                            self.main.tasks[editingIndex].total = self.main.taskTotal
//                        } else {
//                            let newTask = Task(title: self.main.taskTitle, tag: self.main.taskTag, beginDate: self.main.taskBeginDate, endDate: self.main.taskEndDate, done: self.main.taskDone, total: self.main.taskTotal, color1: 1, color2: 2, i: self.main.tasks.count)
//                            self.main.tasks.append(newTask)
//                        }
//                        self.main.sort()
//
//                        //do save
//                        saveData(tasks: self.main.tasks)
//
//                        self.confirmCancel = false
//                        self.main.detailsShowing = false
//
//                    }, label: {
//                        Text(editingMode ? "Apply" : "Add")
//                    }).disabled(main.taskTitle == "")
//                }
//            }
            HStack {
                Text("Task Title: ")
                Spacer()
                TextField("", text: $main.taskTitle).textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            DatePicker(selection: $main.taskBeginDate, displayedComponents: .date, label: {Text("Begin")})
            
            
            DatePicker(selection: $main.taskEndDate, displayedComponents: .date, label: { Text("End") })
            
//                ColorPicker("For Color1", selection: $task.color1)
//
//                ColorPicker("For Color2", selection: $task.color2)
            
            Stepper(value: $main.taskColor1,in: 0...8,step: 1) {
                Text("Color1: ")
                Spacer()
                Text(ColorName[main.taskColor1])

            }
            
            Stepper(value: $main.taskColor2,in: 0...8,step: 1) {
                Text("Color2: ")
                Spacer()
                Text(ColorName[main.taskColor2])

            }
            
            
            Stepper(value: $main.taskTotal,in: 1...100,step: 1) {
                        Text("Total: ")
                        Spacer()
                Text("\(main.taskTotal)")    //
            }
            
            Stepper(value: $main.taskDone,in: 0...100,step: 1) {
                        Text("Done: ")
                        Spacer()
                Text("\(main.taskDone)")    //
            }
            
            
            
            
            Picker("Tag", selection: $main.taskTag) {
                Text("important").tag("important")
                Text("normal").tag("normal")
                Text("urgent").tag("urgent")
                Text("longterm").tag("longterm")
            }
            
            
            
            
        }.padding()
        
    }
}

struct EditDetails_Previews: PreviewProvider {
    static var previews: some View {
        EditDetails(main: Main())
    }
}
