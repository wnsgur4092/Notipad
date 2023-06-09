//
//  HomeView.swift
//  Notipad
//
//  Created by JunHyuk Lim on 11/3/2023.
//

import SwiftUI
import UserNotifications

struct HomeView: View {
    //MARK: - PROPERTIES
    @EnvironmentObject var taskViewModel : TaskViewModel 
    
    @State var isFocusing : Bool = false
    @State var historyViewPresented : Bool = false
    
    //MARK: - BODY
    var body: some View {
        NavigationStack{
            VStack{
                title
                
                Spacer()
                
                textfield
                
                requesetButton
                
                Spacer()
            }
            .padding(.horizontal,32)
            .padding(.vertical, 20)
        }
        .fullScreenCover(isPresented: $historyViewPresented) {
            HistoryView()
                .environmentObject(TaskViewModel())
        }

    }
    
    //MARK: - COMPONENTS
    fileprivate var title : some View {
        HStack{
            Text("NOTIPAD")
                .font(.system(size: 48).bold())
            
            Spacer()
            
            Button {
                print("List Tapped")
                self.historyViewPresented = true
            } label: {
                Image(systemName: "list.bullet")
            }

        }
    }
    
    fileprivate var textfield : some View{
        ZStack{
            HStack{
                TextField("Enter ", text: $taskViewModel.taskName)
                
                Button {
                    taskViewModel.sendNotification(date: Date(), type: "time", timeInterval: 0.2, title: "Notipad", body: taskViewModel.taskName)
                    
                    taskViewModel.saveTask()

                } label: {
                    Image(systemName: "paperplane.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 1)
        )
    }
    
    fileprivate var requesetButton : some View{
        Button {
            taskViewModel.askPermission()
        } label: {
            Text("Not working?")
        }

    }
    
}

//MARK: - PREVIEW
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
