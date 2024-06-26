//
//  SplashView.swift
//  MeliTest
//
//  Created by Nelson Geovanny Pena Agudelo on 14/10/23.
//

import SwiftUI

struct SplashView: View {
    @State var isActive: Bool = false
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.black]
    }
    
    var body: some View {
        VStack{
            if self.isActive {
                ItemListFactory().create()
            } else {
                ZStack{
                    Color(.white)
                        .ignoresSafeArea()
                    Text("{ }")
                        .font(.largeTitle)
                }
            }
            
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

#Preview {
    SplashView()
}
