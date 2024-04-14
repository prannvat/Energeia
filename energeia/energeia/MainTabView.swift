//
//  MainTabView.swift
//  energeia
//
//  Created by Prannvat Singh on 13/04/2024.
//

import UIKit
import SafariServices

struct SafariView: UIViewControllerRepresentable {
    let url: URL
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {
        // No update needed
    }
}

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
        .onAppear{
            UITabBar.appearance().backgroundColor = UIColor(appGreen)
        }
        .tint(.white)
    }
}

struct GreenFinanceView: View {
    @State private var balance: String = ""
    // Example properties, replace with actual data and logic
    var body: some View {
        NavigationView {
            VStack {
                Image("AppLogo")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10)
                    .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.15)
                    .shadow(radius: 40)
                Section(header: Text("Portfolio").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)){
                    LinearGradient(colors: [appGreen.opacity(0.6), appGreen], startPoint: .top, endPoint: .bottom)
                        .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.1)
                        .cornerRadius(10)
                        .shadow(radius: 40)
                        .overlay(
                            
                            HStack
                            {
                                Text("\(balance) XRP")
                                    .foregroundStyle(.white)
                                    .multilineTextAlignment(.center)
                                    .font(.title)
                                    .padding()
                                
                                Text("**^** 7% .24 hrs")
                                    .foregroundStyle(appGreen)
                                    .font(.headline)
                                    .multilineTextAlignment(.center)
                                    .padding(6)
                                
                                    .background().cornerRadius(2400)
                                
                            }
                            
                                .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.2)
                                .cornerRadius(10)
                        )
                }
                
                LinearGradient(colors: [appGreen.opacity(0.6), appGreen], startPoint: .top, endPoint: .bottom)
                    .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.2)
                    .cornerRadius(10)
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
                            .cornerRadius(10)
                    ).padding()
                
                
                Section(header: Text("Weeks Top Investment Choices").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)){
                    LinearGradient(colors: [appGreen.opacity(0.6), appGreen], startPoint: .top, endPoint: .bottom)
                        .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.2)
                        .cornerRadius(10)
                        .shadow(radius: 40)
                        .overlay(
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack
                                {
                                    ForEach(1 ..< 6) { item in
                                        Image("Image \(String(item))")
                                            .resizable()
                                            .frame(width: UIScreen.main.bounds.width * 0.25, height: UIScreen.main.bounds.width * 0.25)
                                            .cornerRadius(10)
                                    }
                                    ForEach(1 ..< 6) { item in
                                        Image("Image \(String(item))")
                                            .resizable()
                                            .frame(width: UIScreen.main.bounds.width * 0.25, height: UIScreen.main.bounds.width * 0.25)
                                            .cornerRadius(10)
                                    }
                                    
                                    
                                }
                            }
                                .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.2)
                                .cornerRadius(10)
                        )
                    
                    
                }
                Spacer()
                
            }
            .onAppear{
                getBalance(for: "0x697FF21B2e1b66E2b35A8f336B3CBcF9E5256ebe")
                print(balance)
            }
            
        }
        
    }
    
    func getBalance(for address: String) {
        guard let url = URL(string: "http://127.0.0.1:5000/get_balance/\(address)") else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { data, response, error in
            // Check for and log any errors
            if let error = error {
                print("Network request error: \(error)")
                return
            }
            
            // Check the response code and log if it's not 200 OK
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                print("HTTP Error: Status code \(httpResponse.statusCode)")
                return
            }
            
            // Ensure data is not nil
            guard let data = data else {
                print("No data received")
                return
            }
            
            // Attempt to decode the JSON response
            do {
                let decodedResponse = try JSONDecoder().decode(BalanceResponse.self, from: data)
                DispatchQueue.main.async {
                    self.balance = "\(decodedResponse.balance)"
                }
            } catch {
                print("JSON Decoding Error: \(error)")
            }
        }.resume()
    }
}
struct BalanceResponse: Codable {
    var address: String
    var balance: String
}


struct CarbonCreditMarketplaceView: View {
    @State private var showAlert: Bool = true
    @State private var balance: String = ""
    var body: some View {
        NavigationView {
            VStack {
                
                Text("Carbon Credit Market")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .foregroundStyle(appGreen)
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
                                    Button {
                                        showAlert = true
                                    } label: {
                                        Text("Trade")
                                            .foregroundColor(appGreen)
                                            .padding()
                                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                                    }
                                }
                                    .padding()
                            )
                            .padding(.bottom)
                    }
                }
                .scrollContentBackground(.hidden)
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Invest 100 XRP in this credit"),
                        message: Text("Take your step into green finance!"),
                        primaryButton: .default(Text("Invest")) {
                            sendEther()
                        },
                        secondaryButton: .cancel(Text("Cancel"))
                    )
                }
                Spacer()
            }
            .padding()
            
            
        }
    }
    
    func sendEther() {
        guard let url = URL(string: "http://127.0.0.1:5000/send_ether") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST" // Your Flask route might be a GET or POST, adjust accordingly
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            // Handle the response here. For simplicity, we're just printing it.
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("Response data string:\n \(dataString)")
            }
        }.resume()
    }
    
    
}

struct RenewableProject: Identifiable {
    let id: UUID = UUID()
    let name: String
    let description: String
    // Add more properties as needed
}

struct SustainableProjectsView: View {
    @State private var showAlert: Bool = false
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
                    Button {
                        showAlert = true
                    }label: {
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
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Help and be a part of sustainable projects"),
                    message: Text("Donate to an amazing project."),
                    dismissButton: .default(Text("Yayy!! Excited for Energeia to take over!"))
                )
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
    @State private var showAlert: Bool = false
    // Example array of opportunities, replace with actual data
    var opportunities: [InvestmentOpportunity] = [
        // Populate with actual opportunities
        InvestmentOpportunity(name: "Solar Power Expansion", description: "Expanding solar power to remote areas.", investmentNeeded: "$150,000"),
        InvestmentOpportunity(name: "Eco-Friendly Packaging", description: "Innovative packaging solutions that are 100% biodegradable.", investmentNeeded: "$50,000"),
        InvestmentOpportunity(name: "Wind Turbine generated business", description: "Completeley net zero carbon emissions.", investmentNeeded: "$100,000")
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
                            Button {
                                showAlert = true
                            }label: {
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
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Invest in amazing companies"),
                        message: Text("Make money by investing in SME's."),
                        dismissButton: .default(Text("Yayy!! Excited for Energeia to take over!"))
                    )
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
