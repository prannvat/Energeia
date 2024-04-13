//
//  MockData.swift
//  EcoRipple
//
//  Created by Prannvat Singh on 10/04/2024.
//

struct RenewableProject: Identifiable {
    let id: Int
    let name: String
    let description: String
}

let mockEnergyUsageHistory = [200.0, 350.0, 120.0, 150.0, 400.0] // Mock monthly energy usage in kWh

let mockRenewableProjects = [
    RenewableProject(id: 1, name: "Solar Farm Expansion", description: "Expand a local solar farm to provide clean energy to 1000 more homes."),
    RenewableProject(id: 2, name: "Community Wind Turbines", description: "Install wind turbines to power local community centers sustainably.")
]
