//
//  MainTabView.swift
//  energeia
//
//  Created by Prannvat Singh on 13/04/2024.
//
from xrpl.clients import JsonRpcClient
mainnet_client = JsonRpcClient("https://s2.ripple.com:51234/")
import SwiftUI

let appGreen = Color(red: 88/255, green:148/255, blue:138/255)
struct MainTabView: View {
    var body: some View {
        TabView {
            GreenFinanceView()
                .tabItem {
                    Label("Green Finance", systemImage: "dollarsign.circle")
                }
            
            CarbonCreditMarketplaceView()
                .tabItem {
                    Label("Carbon Credits", systemImage: "leaf.arrow.circlepath")
                }
            
            SustainableProjectsView()
                .tabItem {
                    Label("Projects", systemImage: "hammer")
                }
            
            InvestmentOpportunitiesView()
                .tabItem {
                    Label("Invest", systemImage: "heart")
                }
            
            UserProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }
        }
    }
}

struct GreenFinanceView: View {
    // Example properties, replace with actual data and logic
    var body: some View {
        NavigationView {
            VStack {
                Image("AppLogo")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(20)
                    .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.15)
                
                    .shadow(radius: 40)
                Section(header: Text("Portfolio").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)){
                    Rectangle()
                        .foregroundColor(appGreen)
                        .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.1)
                        .cornerRadius(20)
                        .shadow(radius: 40)
                        .overlay(
                           
                                HStack
                                {
                                   Text("236.952 XRP")
                                        .font(.title)
                                        .padding()
                                    
                                    Text("Up 7% .last 24 hrs")
                                        .foregroundStyle(appGreen)
                                         .font(.headline)
                                         .multilineTextAlignment(.center)
                                         .padding()
                                    
                                         .background().cornerRadius(2400)
                                    
                                }
                            
                                .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.2)
                                .cornerRadius(20)
                        )
                }
                
                Rectangle()
                    .foregroundColor(appGreen)
                    .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.2)
                    .cornerRadius(20)
                    .shadow(radius: 40)
                    .overlay(
                        ScrollView(.vertical, showsIndicators: true) {
                            Text("Green finance directly contributes to combating climate change by supporting projects that reduce carbon emissions and enhance renewable energy usage. It plays a crucial role in preserving biodiversity, protecting water resources, and promoting sustainable land use. By channeling funds into environmentally friendly projects, green finance helps ensure a healthier planet for future generations.Investing in green projects isn't just good for the earth—it can also be good for your wallet. Renewable energy projects, for example, are becoming increasingly cost-competitive with traditional energy sources, offering attractive returns on investment. Green bonds and other financial instruments provide opportunities for investors to contribute to environmental sustainability while potentially reaping financial rewards.")
                                .foregroundStyle(.white)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .multilineTextAlignment(.center)
                                .padding()
                        }
                            .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.2)
                            .cornerRadius(20)
                    ).padding()
                
               
                Section(header: Text("Weeks Top Investment Choices").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)){
                    Rectangle()
                        .foregroundColor(appGreen)
                        .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.2)
                        .cornerRadius(20)
                        .shadow(radius: 40)
                        .overlay(
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack
                                {
                                    ForEach(0 ..< 10) { item in
                                        Rectangle()
                                            .foregroundStyle(.white)
                                            .frame(width: UIScreen.main.bounds.width * 0.3, height: UIScreen.main.bounds.height * 0.15)
                                            .cornerRadius(20)
                                            .overlay{
                                                Image(systemName: "dollarsign.arrow.circlepath")
                                                    .font(.system(size: 35))
                                            }
                                        
                                    }
                                }
                            }
                                .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.2)
                                .cornerRadius(20)
                        )
                    
                    
                }
                Spacer()
               
            }
            
        }
    }
}


struct CarbonCreditMarketplaceView: View {
    // Example properties, replace with actual data and logic
    var body: some View {
        NavigationView {
            VStack {
                
                
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(0..<10) { item in
                        Rectangle()
                            .foregroundColor(appGreen)
                            .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.1)
                            .cornerRadius(20)
                            .shadow(radius: 40)
                            .overlay(
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("Offer \(item+1)")
                                            .font(.headline)
                                            .foregroundColor(.white)
                                        Text("100 Credits")
                                            .font(.subheadline)
                                            .foregroundColor(.white)
                                    }
                                    Spacer()
                                    Button(action: {
                                        // Action for buying or selling credits
                                    }) {
                                        Text("Trade")
                                            .foregroundColor(.white)
                                            .padding()
                                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
                                    }
                                }
                                .padding()
                            )
                            .padding(.bottom)
                    }
                }
                Spacer()
            }
            .navigationTitle("Carbon Credit Market")
        }
    }
}

struct RenewableProject: Identifiable {
    let id: UUID = UUID()
    let name: String
    let description: String
    // Add more properties as needed
}

struct SustainableProjectsView: View {
    // Example array of projects, replace with actual data
    var projects: [RenewableProject] = [
        // Populate with actual projects
        RenewableProject(name: "Solar Power Initiative", description: "A project aimed at increasing solar power usage."),
        RenewableProject(name: "Wind Farm Expansion", description: "Expanding wind farm capacities to power more homes.")
    ]
    
    var body: some View {
        NavigationView {
            List(projects) { project in
                VStack(alignment: .leading) {
                    Text(project.name)
                        .font(.headline)
                        .foregroundColor(.white)
                    Text(project.description)
                        .font(.subheadline)
                        .foregroundColor(.white)
                    Button(action: {
                        // Action to support or invest in the project
                    }) {
                        Text("Support")
                            .foregroundColor(.white)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding()
                .background(appGreen)
                .cornerRadius(20)
                .shadow(radius: 10)
            }
            .navigationTitle("Sustainable Projects")
            .listStyle(PlainListStyle())
        }
    }
}

import SwiftUI

struct InvestmentOpportunity: Identifiable {
    let id: UUID = UUID()
    let name: String
    let description: String
    let investmentNeeded: String // Example: "$100,000"
    // Add more properties as needed
}

struct InvestmentOpportunitiesView: View {
    // Example array of opportunities, replace with actual data
    var opportunities: [InvestmentOpportunity] = [
        // Populate with actual opportunities
        InvestmentOpportunity(name: "Solar Power Expansion", description: "Expanding solar power to remote areas.", investmentNeeded: "$150,000"),
        InvestmentOpportunity(name: "Eco-Friendly Packaging", description: "Innovative packaging solutions that are 100% biodegradable.", investmentNeeded: "$50,000")
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(opportunities) { opportunity in
                        VStack(alignment: .leading) {
                            Text(opportunity.name)
                                .font(.headline)
                                .foregroundColor(.white)
                            Text(opportunity.description)
                                .font(.subheadline)
                                .foregroundColor(.white)
                            Text("Investment Needed: \(opportunity.investmentNeeded)")
                                .font(.subheadline)
                                .foregroundColor(.yellow)
                            Button(action: {
                                // Action to explore or invest in the opportunity
                            }) {
                                Text("Explore")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        .padding()
                        .background(appGreen)
                        .cornerRadius(20)
                        .shadow(radius: 10)
                        .padding(.bottom)
                    }
                }
                .padding()
                .navigationTitle("Investment Opportunities")
            }
        }
    }
}



struct UserProfileView: View {
    @State private var username: String = ""
    @State private var email: String = ""
    // Additional state variables for profile information
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Profile").font(.headline).foregroundColor(appGreen)) {
                    TextField("Username", text: $username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    // Additional fields for profile information
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                
                // Example section for investments
                Section(header: Text("Investments").font(.headline).foregroundColor(appGreen)) {
                    // Placeholder for investment data
                    Text("Your investments will be listed here.")
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                
                // Example section for carbon credits
                Section(header: Text("Carbon Credits").font(.headline).foregroundColor(appGreen)) {
                    // Placeholder for carbon credit data
                    Text("Your carbon credits will be displayed here.")
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
            }
            .navigationTitle("Your Profile")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.all))
        }
    }
}

#Preview {
    MainTabView()
}
