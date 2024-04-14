//
//  MainTabView.swift
//  EcoRipple
//
//  Created by Prannvat Singh on 10/04/2024.
//

import SwiftUI

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            DashboardView(userEnergyBalance: 150, buyPrice: 0.08, sellPrice: 0.07)
                .tabItem {
                    Label("Dashboard", systemImage: "house")
                }
            
            MarketplaceView(energyOffers: [
                EnergyOffer(id: 1, company: "Google",kWh: 500, price: 0.1),
                EnergyOffer(id: 2,company: "Microsoft", kWh: 50, price: 0.075),
                EnergyOffer(id: 3, company: "Tesla",kWh: 800, price: 0.09),
                EnergyOffer(id: 4,company: "Starlink", kWh: 300, price: 0.11),
                EnergyOffer(id: 5, company: "Costco",kWh: 100, price: 0.08),
                EnergyOffer(id: 6,company: "CERN", kWh: 50, price: 0.075)
            ])
                .tabItem {
                    Label("Marketplace", systemImage: "cart")
                }
            
            EnergyConsumptionView(energyUsageHistory: mockEnergyUsageHistory)
                .tabItem {
                    Label("Consumption", systemImage: "chart.bar")
                }
            
            RenewableProjectsView(projects: mockRenewableProjects)
                .tabItem {
                    Label("Projects", systemImage: "leaf.arrow.circlepath")
                }
            
            SustainabilityScoreView(sustainabilityScore: 85)
                .tabItem {
                    Label("Eco Score", systemImage: "star")
                }
        }
        
    }
}


struct EnergyConsumptionView: View {
    var energyUsageHistory: [Double] // Array of monthly energy usage in kWh
    
    var body: some View {
        LineChartView(data: energyUsageHistory, title: "Energy Consumption")
            .padding()
            .navigationTitle("Your Energy Usage")
    }
}

struct RenewableProjectsView: View {
    var projects: [RenewableProject] // Array of projects
    
    var body: some View {
        List(projects) { project in
            VStack(alignment: .leading) {
                Text(project.name)
                    .font(.headline)
                Text(project.description)
                    .font(.subheadline)
                Button("Invest") {
                    // Action to invest in the project
                }
            }
        }
        .navigationTitle("Invest in Green Projects")
    }
}


struct PeerToPeerTradingView: View {
    var offers: [EnergyOffer]
    
    var body: some View {
        List(offers) { offer in
            HStack {
                VStack(alignment: .leading) {
                    Text("\(offer.kWh, specifier: "%.0f") kWh")
                    Text("at \(offer.price, specifier: "%.3f") XRP/kWh")
                }
                Spacer()
                Button("Contact Seller") {
                    // Action to initiate negotiation
                }
            }
        }
        .navigationTitle("Peer-to-Peer Trading")
    }
}


struct MarketPriceAlertsView: View {
    @State private var targetBuyPrice: Double = 0.0
    @State private var targetSellPrice: Double = 0.0
    
    var body: some View {
        Form {
            Section(header: Text("Set Alert Prices")) {
                TextField("Target Buy Price (XRP/kWh)", value: $targetBuyPrice, formatter: NumberFormatter())
                TextField("Target Sell Price (XRP/kWh)", value: $targetSellPrice, formatter: NumberFormatter())
            }
            Button("Save Alerts") {
                // Action to save alert thresholds
            }
        }
        .navigationTitle("Price Alerts")
    }
}

struct SustainabilityScoreView: View {
    var sustainabilityScore: Int
    
    var body: some View {
        VStack {
            Text("ECO CREDIT")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .foregroundColor(sustainabilityScore > 80 ? .green : .orange)
            Spacer()
            Text("Your Sustainability Score")
                .font(.headline)
            Text("\(sustainabilityScore)")
                .font(.largeTitle)
                .foregroundColor(sustainabilityScore > 80 ? .green : .orange)
            // Additional information and tips to improve the score
            Spacer()
        }
        .padding()
        .navigationTitle("Eco Score")
    }
}


import SwiftUI

struct LineChartView: View {
    var data: [Double]
    var title: String
    
    // Calculate the maximum value in the data set for scaling
    private var maxY: Double {
        data.max() ?? 0
    }
    
    private var path: Path {
        var path = Path()
        guard let firstPoint = data.first else { return path }
        
        // Scale the first point to the path
        let startPoint = CGPoint(x: 0, y: (1 - (firstPoint / maxY)) * 200)
        path.move(to: startPoint)
        
        // Add lines for each data point
        for (index, point) in data.enumerated() {
            let xPosition = Double(index) / Double(data.count - 1) * 300 // Assuming a fixed width of 300
            let yPosition = (1 - (point / maxY)) * 200 // Assuming a fixed height of 200
            let nextPoint = CGPoint(x: xPosition, y: yPosition)
            path.addLine(to: nextPoint)
        }
        
        return path
    }
    
    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
            ZStack {
                // Background grid (optional)
                GeometryReader { geometry in
                    Path { path in
                        let width = geometry.size.width
                        let height = geometry.size.height
                        
                        // Horizontal lines
                        for i in 0..<7 {
                            let y = height / 6 * CGFloat(i)
                            path.move(to: CGPoint(x: 0, y: y))
                            path.addLine(to: CGPoint(x: width, y: y))
                        }
                    }
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                }
                
                // Line chart
                path
                    .stroke(Color.blue, lineWidth: 2)
                    .padding(.horizontal) // Add padding to ensure the chart does not touch the edges
            }
            .frame(height: 200) // Fixed height for the chart
        }
    }
}


#Preview {
    MainTabView()
}
