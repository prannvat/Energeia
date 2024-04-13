//
//  DashboardView.swift
//  EcoRipple
//
//  Created by Prannvat Singh on 08/04/2024.
//

struct EnergyOffer: Identifiable {
    let id: Int
    let company: String
    let kWh: Double
    let price: Double // Price in XRP
}

struct Transaction: Identifiable {
    let id: Int
    let kWh: Double
    let price: Double // Price in XRP
    let date: Date
}


import SwiftUI

struct DashboardView: View {
    // Mock data for demonstration
    var userEnergyBalance: Double // in kWh
    var buyPrice: Double // Price in XRP per kWh
    var sellPrice: Double// Price in XRP per kWh

    var body: some View {
        NavigationView {
            
            ScrollView {
                VStack(alignment: .leading) {
                    
                    HStack {
                        Spacer()
                        Circle()
                            .foregroundColor(.blue)
                            .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                            .frame(width: UIScreen.main.bounds.width * 0.6)
                            .overlay{
                                Text("Your Energy Balance: \(userEnergyBalance, specifier: "%.2f") kWh")
                                    .multilineTextAlignment(.center)
                                    .font(.title2)
                                    .padding()
                            }
                        Spacer()
                    }
                    
                    
                    Text("Market Prices (XRP)")
                        .font(.headline)
                        .padding(.top)
                    HStack {
                        Text("Buy: \(buyPrice, specifier: "%.2f")/kWh")
                        Spacer()
                        Text("Sell: \(sellPrice, specifier: "%.2f")/kWh")
                    }
                    .padding()
                    
                    Spacer()
                    
                    NavigationLink(
                        destination: MarketplaceView(energyOffers: [
                            EnergyOffer(id: 1, company: "Google",kWh: 500, price: 0.1),
                            EnergyOffer(id: 2,company: "Microsoft", kWh: 50, price: 0.075),
                            EnergyOffer(id: 1, company: "Tesla",kWh: 800, price: 0.09),
                            EnergyOffer(id: 2,company: "Starlink", kWh: 300, price: 0.11),
                            EnergyOffer(id: 1, company: "Costco",kWh: 100, price: 0.08),
                            EnergyOffer(id: 2,company: "CERN", kWh: 50, price: 0.075)
                        ]))
                    {
                        Text("Browse")
                    }
                    
                }
                .padding()
            }
            .navigationTitle("XRP Energy Dashboard")
        }
    }
}
struct ProfileSettingsView: View {
    @State private var hasSolarPanels: Bool = false
    @State private var hasWindTurbine: Bool = false
    @State private var username: String = ""
    @State private var password: String = ""
    var body: some View {
        Form {
            Section(header: Text("Energy Sources")) {
                Toggle("Solar Panels", isOn: $hasSolarPanels)
                Toggle("Wind Turbine", isOn: $hasWindTurbine)
            }
            Section(header: Text("Account")) {
                TextField("Username", text: $username)
                SecureField("Password", text: $password)
            }
        }
        .navigationTitle("Profile & Settings")
    }
}

struct MarketplaceView: View {
    // Mock data for demonstration
    var energyOffers: [EnergyOffer]
    
    var body: some View {
        List(energyOffers) { offer in
            HStack {
                
                Text("\(offer.company): \(offer.kWh, specifier: "%.0f") kWh at \(offer.price, specifier: "%.3f") XRP/kWh")
                Spacer()
                Button("Trade") {
                    // Action to trade
                }
            }
        }
        
        .navigationTitle("XRP Eco Marketplace")
    }
}
//#Preview {
//    DashboardView()
//}
