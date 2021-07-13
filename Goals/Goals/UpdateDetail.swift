//
//  UpdateDetail.swift
//  Goal
//
//  Created by celeglow on 2021/7/8.
//

import SwiftUI

struct UpdateDetail: View {
    @ObservedObject var main: Main
    
    var index: Int
    
    @State var zoomOut = false
    @State var viewState = CGSize.zero
    @State var bottomState = CGSize.zero
    
    @State var modify = false;
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Text(main.tasks[index].title).font(.system(size: 40, weight: .bold))
                HStack {
                    VStack {
                        RingView(percent: CGFloat(Int(main.tasks[index].timeProgress * 100)), show: .constant(true))
                        Spacer()
                        Text("Time").font(.title)
                    }.frame(width: 100, height: 180, alignment: .center)
                    Spacer()
                    VStack {
                        RingView(percent: CGFloat(Int(main.tasks[index].taskProgress * 100)), show: .constant(true))
                        Spacer()
                        Text("Task").font(.title)
                    }.frame(width: 100, height: 180, alignment: .center)
                }.frame(width: 300, height: 300, alignment: .center)
                VStack(spacing: 15) {
                    Button(action: {
                        editingMode = true
                        editingIndex = index
                       

                        self.main.taskTitle = main.tasks[index].title
                        self.main.taskTag = main.tasks[index].tag
                        self.main.taskBeginDate = main.tasks[index].beginDate
                        self.main.taskEndDate = main.tasks[index].endDate
                        self.main.taskDone = main.tasks[index].done
                        self.main.taskTotal = main.tasks[index].total
                        self.main.taskColor1 = main.tasks[index].color1
                        self.main.taskColor2 = main.tasks[index].color2
                    }, label: {
                        Text("Details").font(.title).foregroundColor(Color.white.opacity(0.8))
                    })
                    RowView(description: "Tag:", answer: main.tasks[index].tag, Icon: "exclamationmark.triangle")
                        RowView(description: "beginDate:", answer: dateConvertor(main.tasks[index].beginDate, includeYear: true), Icon: "clock")
                        RowView(description: "EndDate:", answer: dateConvertor(main.tasks[index].endDate, includeYear: true), Icon: "alarm")
                        RowView(description: "Done:", answer: "\(main.tasks[index].done)", Icon: "arrow.up")
                        RowView(description: "Total:", answer: "\(main.tasks[index].total)", Icon: "arrow.up.to.line")
                        
                    }
                    .frame(height: 360)
                .background(LinearGradient(gradient: Gradient(colors: [ColorList[main.tasks[index].color1].opacity(0.7), ColorList[main.tasks[index].color2].opacity(0.7)]), startPoint: .leading, endPoint: .trailing))
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                        .padding(.horizontal, 100)
                        .padding(.bottom, 20)
                        .offset(y: zoomOut ? 50: 0)
                        .offset(viewState)
                        .shadow(color: Color.black, radius: 20, x: 0, y: 20)
                    .scaleEffect(self.zoomOut ? 1.25 : 1)
                    .onTapGesture {
                        self.zoomOut.toggle()
                        if(zoomOut && main.tasks[index].done + 1 <= main.tasks[index].total){main.tasks[index].done = main.tasks[index].done + 1}
                    }
                .animation(.spring(response: 0.6, dampingFraction: 0.5, blendDuration: 1))
                .gesture(
                    DragGesture().onChanged{ value in
                        self.viewState = value.translation
                    }
                    .onEnded{ value in
                        self.viewState = .zero
                    }
                )
            }

        }
        
    }
}

struct UpdateDetail_Previews: PreviewProvider {
    static var previews: some View {
        UpdateDetail(main: Main(), index: 0)
    }
}

struct RowView: View {
    var description: String
    var answer: String
    var Icon: String
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: Icon)
            Text(description)
            Text(answer).frame(maxWidth: .infinity, alignment: .trailing)
        }.frame(width: 300, alignment: .leading).padding(.horizontal)
    }
}

