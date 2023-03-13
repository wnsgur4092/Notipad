//
//  OnBoardingView.swift
//  Notipad
//
//  Created by JunHyuk Lim on 13/3/2023.
//

import SwiftUI
import UserNotifications

struct OnBoardingView: View {
    //MARK: - PROPERTEIS
    @AppStorage("isOnboarding") var isOnboarding : Bool?
    
    @State var isOn : Bool = false
    

    
    //MARK: - BODY
    var body: some View {
        VStack{
            lottieAnimationView
            
            onBoardingText
            
            toggleButton
            
            Spacer()
            
            nextButton


        }
        .padding(.horizontal,32)
    }
    
    //MARK: - COMPONENTS
    fileprivate var lottieAnimationView : some View {
        LottieView(filename: "notification")
            .frame(maxWidth: 300, maxHeight: 300)
    }
    
    fileprivate var onBoardingText : some View {
        VStack(alignment:.leading, spacing: 32){
            Text("Notes can slip your mind")
                .font(.system(size: 28, weight: .bold))
            
            Text("But, I will remember with reminder")
                .font(.system(size: 28, weight: .bold))
                .opacity(0.6)
            
        }
    }
    
    fileprivate var toggleButton: some View {
        Toggle(isOn: $isOn) {
            Text("Allow Notifications")
        }
        .onChange(of: isOn) { newValue in
            if newValue {
                // Request push notification permission
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
                    if let error = error {
                        print(error.localizedDescription)
                    }
                    if granted {
                        print("Notification permission granted")
                    } else {
                        DispatchQueue.main.async {
                            // Set isOn back to false if permission is not granted
                            self.isOn = false
                            
                            // Show alert message to guide user to settings
                            let alertController = UIAlertController(title: "Notification Permission Required", message: "To enable notifications, please go to Settings > Notifications > Notipad and turn on Allow Notifications.", preferredStyle: .alert)
                            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            UIApplication.shared.windows.first?.rootViewController?.present(alertController, animated: true, completion: nil)
                        }
                        print("Notification permission denied")
                    }
                }
            }
        }
        .toggleStyle(SwitchToggleStyle(tint: Color.blue))
    }

    
    fileprivate var nextButton : some View {
        Button {
            print("Next Button tapped")
            isOnboarding = false
        } label: {
            HStack(alignment: .center, spacing: 20){
                Text("Get Started")
                Image(systemName: "chevron.right")
            }
            .font(.system(size: 16))
        }
        .buttonStyle(DisableButtonStyle())
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}
