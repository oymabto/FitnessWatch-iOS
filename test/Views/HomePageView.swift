//
//  HomePageView.swift
//  test
//
//  Created by Alireza on 2023-08-16.
//

import SwiftUI

struct HomePageView: View {
    
    @EnvironmentObject var realmViewModel: RealmViewModel
    @State private var shouldNavigateToLogin: Bool = false
    
    let items: [Item] = [
        Item(imageName: "dumbbell.fill", title: "WORKOUT"),
        Item(imageName: "figure.run", title: "REAL-TIME TRACKER"),
        Item(imageName: "heart.rectangle.fill", title: "HEALTH"),
        Item(imageName: "menucard.fill", title: "DIET"),
        Item(imageName: "calendar", title: "SCHEDULE"),
        Item(imageName: "bed.double.fill", title: "SLEEP"),
        Item(imageName: "bell.and.waves.left.and.right.fill", title: "MMR"),
        Item(imageName: "macpro.gen3.server", title: "CALORIE BURNER")
    ]
    
    @State private var selectedTab: Int = 0
    
    var body: some View {
        //        NavigationView {
        VStack {
            if selectedTab == 0 {
                ScrollView {
                    LazyVGrid(columns: Array(repeating: .init(), count: 2), spacing: 20) {
                        ForEach(items, id: \.title) { item in
                            NavigationLink(destination: destinationView(for: item.title)) {
                                CardView(item: item).frame(width: 150, height: 150)
                            }
                        }
                    }
                }
            } else if selectedTab == 1 {
                ReportsView()
            }else if selectedTab == 2 {
                ProfileView()
            } else {
                AboutView()
            }
            Spacer()
            TabBarView(selectedTab: $selectedTab)
        }
        .padding()
        .navigationBarTitle(tabTitle(for: selectedTab), displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(trailing: HStack {
            Button(action: {
                realmViewModel.logoutV2()
                print("FW-[AdminPageView]-logout Button 2: CurrentUser == \(realmViewModel.realmApp.currentUser?.id ?? "?")")
                shouldNavigateToLogin = true
            }) {
                Text("Logout")
                    .padding()
                    .foregroundColor(.white)
                    .background(.purple)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
        }
        )
        
        NavigationLink(destination: LoginView(), isActive: $shouldNavigateToLogin) {
            EmptyView()
        }
    }
    
    func tabTitle(for index: Int) -> String {
            switch index {
            case 0: return "Home"
            case 1: return ""
            case 2: return "Profile"
            default: return "About"
            }
        }
    
    func destinationView(for title: String) -> some View {
        switch title {
        case "WORKOUT":
            return AnyView(WorkoutView())
        case "REAL-TIME TRACKER":
            return AnyView(MapView())
        case "HEALTH":
            return AnyView(HealthHistoryView())
        case "DIET":
            return AnyView(DailyIntakeCalorieView())
        case "MMR":
            return AnyView(MMRView())
        case "SLEEP":
                return AnyView(DailySleepFlowView())
        case "CALORIE BURNER":
                return AnyView(CalorieBurnerView())
        default:
            return AnyView(Text(title))
        }
    }
}
struct CardView: View {
    let item: Item
    
    var body: some View {
        VStack {
            Image(systemName: item.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
            Text(item.title)
                .font(.caption)
        }
        .padding()
        .frame(width: 150, height: 150)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

struct TabBarView: View {
    @Binding var selectedTab: Int
    @State private var shouldNavigateToHomePage: Bool = true
    var tabs = [
        TabItem(title: "Home", icon: "house.fill"),
        TabItem(title: "Reports", icon: "chart.bar.fill"),
        TabItem(title: "Profile", icon: "person.fill"),
        TabItem(title: "About", icon: "info.circle.fill")
    ]
    
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            ForEach(0..<tabs.count) { index in
                Button(action: {
                    selectedTab = index
                }) {
                    VStack(spacing: 4) {
                        Image(systemName: tabs[index].icon)
                            .font(.title2)
                            .foregroundColor(selectedTab == index ? .blue : .gray)
                        
                        Text(tabs[index].title)
                            .font(.caption)
                            .foregroundColor(selectedTab == index ? .blue : .gray)
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .background(Color.white)
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 0)
    }
}

struct TabItem {
    let title: String
    let icon: String
}


struct Item {
    let imageName: String
    let title: String
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro Max"))
            .previewDisplayName("iPhone 14 Pro Max")
    }
}




