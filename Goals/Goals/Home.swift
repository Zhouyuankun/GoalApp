//
//  Home.swift
//  Goal
//
//  Created by celeglow on 2021/7/10.
//

import SwiftUI

var editingMode: Bool = false
var creatingMode: Bool = false
var editingIndex: Int = 0


var exampletasks: [Task] = [
    Task(title: "Run", tag: "Urgent", beginDate: Date(), endDate: Date(timeIntervalSinceNow: 100000), done: 1, total: 12, color1: 1, color2: 2, i: 0)
]


class Main: ObservableObject {
    @Published var tasks: [Task] = []
    //@Published var detailsShowing: Bool = false
    
    @Published var taskTitle: String = ""
    @Published var taskTag: String = ""
    @Published var taskBeginDate: Date = Date()
    @Published var taskEndDate: Date = Date()
    @Published var taskDone: Int = 0
    @Published var taskTotal: Int = 0
    @Published var taskColor1: Int = 1
    @Published var taskColor2: Int = 2

    
    func sort() {
        self.tasks.sort(by: { $0.endDate.timeIntervalSince1970 < $1.endDate.timeIntervalSince1970 })
        for i in 0 ..< self.tasks.count {
            self.tasks[i].i = i
        }
    }
}

struct Home: View {
    @ObservedObject var main: Main
    
    @State var bottomState = CGSize.zero
    var body: some View {
        ZStack {
            NavigationView {
                List {
                    ForEach(main.tasks, id: \.self) { task in
                        NavigationLink(
                            destination: UpdateDetail(main: main, index: task.i),
                            label: {
                                VStack {
                                    if task.i == 0 ||  dateConvertor(self.main.tasks[task.i].endDate, includeYear: false) != dateConvertor(self.main.tasks[task.i - 1].endDate, includeYear: false){
                                        HStack {
                                            Spacer().frame(width: 30)
                                            Text(dateConvertor(self.main.tasks[task.i].endDate, includeYear: false))
                                            Spacer()
                                        }
                                    }
                                    
                                    TaskView(main: self.main, task: task)
                                        
                                    
                                    Spacer().frame(height: 20)
                                }
                            })
                        
                    }
                    .onDelete(perform: { indexSet in
                        main.tasks.remove(at: indexSet.first!)
                        main.sort()
                        saveData(tasks: main.tasks)
                        
                    })
                    Spacer().frame(height: 150)
                }
                .edgesIgnoringSafeArea(.bottom)
                .navigationTitle(Text("Goal"))
                .toolbar(content: {
                    Button(action: {
                        editingMode = true
                        creatingMode = true

                        self.main.taskTitle = ""
                        self.main.taskTag = ""
                        self.main.taskBeginDate = Date()
                        self.main.taskEndDate = Date()
                        self.main.taskDone = 0
                        self.main.taskTotal = 1
                        self.main.taskColor1 = 1
                        self.main.taskColor2 = 2
                    }
                    , label: {
                        Image(systemName: "plus.circle.fill")
                    })
                })
                .onAppear {
                    //load
                    let data = loadData()
                    if data.count != 0 {
                        self.main.tasks = data
                        self.main.sort()
                    } else {
                        self.main.tasks = exampletasks
                        self.main.sort()
                    }
                    
                }
                
                
            
            }
                .blur(radius: editingMode ? 10 : 0)
                .animation(.spring())
            
//            Button(action: {
//                editingMode = true
//                creatingMode = true
//
//                self.main.taskTitle = ""
//                self.main.taskTag = ""
//                self.main.taskBeginDate = Date()
//                self.main.taskEndDate = Date()
//                self.main.taskDone = 0
//                self.main.taskTotal = 1
//                self.main.taskColor1 = 1
//                self.main.taskColor2 = 2
//
//            }) {
//                btnAdd()
//            }
//            .offset(x: UIScreen.main.bounds.width/2 - 60, y: UIScreen.main.bounds.height/2 - 80)
//            .animation(.spring())
            
            EditDetails(main: main)
                .padding(.top, 8)
                .padding(.horizontal, 70)
                .frame(width: 420)
                .background(BlurView(style: .systemThinMaterial))
                .cornerRadius(50)
                .shadow(radius: 20)
                    .offset(x: 0, y: editingMode ? 120 : 1000)
                    .offset(y: bottomState.height)
                    .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8))
                    
                    .gesture(
                        DragGesture().onChanged { value in
                            if value.translation.height > 0
                            {self.bottomState = value.translation}
                        }
                        .onEnded { value in
                            if self.bottomState.height > 50 {
                                self.bottomState = CGSize.zero
                                editingMode = false
                                creatingMode = false
                            }
                        }
                    )
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home(main: Main())
    }
}

struct btnAdd: View {
    var size: CGFloat = 65.0
    var body: some View {
        ZStack {
            Group {
                Circle()
                    .fill(Color.blue)
            }.frame(width: self.size, height: self.size)
            .shadow(color: Color.gray, radius: 10)
            Group {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: size, height: size)
                    .foregroundColor(Color.white)
            }
        }
    }
}
