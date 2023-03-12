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
    @StateObject var taskViewModel : TaskViewModel = TaskViewModel()
    
    @State var isFocusing : Bool = false
    
    //MARK: - BODY
    var body: some View {

            VStack{
                title
                
                Spacer()
                
                textfield
                
                Spacer()
            }
            .padding(.horizontal,32)
            .padding(.vertical, 20)
    }
    
    //MARK: - COMPONENTS
    fileprivate var title : some View {
        HStack{
            Text("NOTIPAD")
                .font(.system(size: 48).bold())
            
            Spacer()
            
            Button {
                print("List Tapped")
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
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
