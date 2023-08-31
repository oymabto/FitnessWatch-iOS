//
//  AboutView.swift
//  test
//
//  Created by Devin Oxman on 2023-08-20.
//

import SwiftUI

struct AboutView: View {
    @State private var navigateToContactUs = false
    
    private var gradient: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.1), Color.purple.opacity(0.1)]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    
    var body: some View {
        ZStack {
            Image("fitnesswatchapp")
                            .resizable()
//                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .edgesIgnoringSafeArea(.all)
                .opacity(0.2)
            VStack() {
                GeometryReader { geometry in
                    ScrollView {
                        VStack(spacing: 20) {
                            
                            Image("Logo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 200, height: 200)
                                .padding(.top, 50)
                            
                            Text("History")
                                .font(.title)
                                .fontWeight(.bold)
                            Text("Our health is an important part of our lives, but sometimes it's difficult to keep up with it. With FitnessWatch you get motivation through progress, as we save and display all your health and fitness data for a healthier, happier, and more motivated you.")
                                .multilineTextAlignment(.center)
                            Text("Mission")
                                .font(.title)
                                .fontWeight(.bold)
                            Text("Our story starts back in 2023, when during our Computer Science program at John Abbott College we decided to watch our fitness. Being able to develop mobile apps, we thought it would be fun and adventurous to design, build, and use a mobile app for fitness that allows us to save and track our progress.")
                                .multilineTextAlignment(.center)
                            Text("Credits")
                                .font(.title)
                                .fontWeight(.bold)
                            Text("Alireza Moussavi, Calvert Clarke-Wallace, Devin Oxman, Dongguo Wu, Harsha Karunanayake, Ian Howse, Xiaowei Chen")
                                .multilineTextAlignment(.center)
                            Spacer()
                            
                            Button(action: {
                                navigateToContactUs.toggle()
                            }) {
                                Text("Contact Us")
                            }
                            .padding(.top, 20)
                            
                            // Invisible NavigationLink
                            NavigationLink("", destination: ContactUsView(), isActive: $navigateToContactUs).hidden()
                        }
                        //                        .padding(.horizontal)
                    }
                }
            }
        }
    }
}
