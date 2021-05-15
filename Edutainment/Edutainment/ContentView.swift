//
//  ContentView.swift
//  Edutainment
//
//  Created by Kat Ou on 01.06.2020.
//  Copyright © 2020 Kat Ou. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var enabled = false
    @State private var nextView = false
    @State private var dragAmount = CGSize.zero
    let letters = Array("🐝🦄count us🐸🐳")
    @State private var timer: Timer?
    
    
    var body: some View {
        
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 0.5409764051, blue: 0.8473142982, alpha: 0.5)), Color(#colorLiteral(red: 0.5808190107, green: 0.0884276256, blue: 0.3186392188, alpha: 0.7033390411))]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            if nextView{
                withAnimation(Animation.easeInOut(duration: 1)){
                    SettingsView()
                }
            }else{
                HStack(spacing: 0) {
                    ForEach(0..<letters.count) { num in
                        Text(String(self.letters[num]))
                            .foregroundColor(Color(#colorLiteral(red: 0.5810584426, green: 0.1285524964, blue: 0.5745313764, alpha: 1)))
                            .padding(5)
                            .font(.largeTitle)
                            .background(self.enabled ? Color(#colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)) : Color(#colorLiteral(red: 0, green: 0.9195801616, blue: 0.9863323569, alpha: 1)))
                            .offset(self.dragAmount)
                            .animation(Animation.default.delay(Double(num) / 20))
                    }
                }
                .gesture(
                    DragGesture()
                        .onChanged { self.dragAmount = $0.translation }
                        .onEnded { _ in
                            self.dragAmount = .zero
                            self.enabled.toggle()
                            withAnimation(Animation.easeInOut(duration: 1.3).delay(1.3)) {
                                self.nextView.toggle()
                                
                            }
                    }
                )
                
            }
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
