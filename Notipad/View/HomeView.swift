//
//  HomeView.swift
//  Notipad
//
//  Created by JunHyuk Lim on 11/3/2023.
//

import SwiftUI

struct HomeView: View {
    //MARK: - PROPERTIES
    @State var text : String = ""
    @State var isFocusing : Bool = false
    
    //MARK: - BODY
    var body: some View {

            VStack{
                title
                
                Divider()
                
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
        }
    }
    
    fileprivate var textfield : some View{
        ZStack{
            HStack{
                TextField("Enter ", text: $text)
                
                Button {
                    print("Tapped")
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
