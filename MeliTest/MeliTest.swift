//
//  MeliTestApp.swift
//  MeliTest
//
//  Created by Nelson Geovanny Pena Agudelo on 14/10/23.
//

import SwiftUI

@main
struct MeliTest: App {
    @StateObject var networkMonitor = NetworkMonitor()
    var body: some Scene {
        WindowGroup {
           SplashView().environmentObject(networkMonitor)
        }
    }
}
