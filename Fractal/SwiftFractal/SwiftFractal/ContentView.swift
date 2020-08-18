//
//  ContentView.swift
//  SwiftFractal
//
//  Created by Krzysztof Drab on 30/07/2020.
//  Copyright © 2020 Krzysztof Drab. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    // https://medium.com/swlh/swiftui-performance-battle-anyview-vs-group-55bf852158df
    private class FPSCalculator {
        private var lastUpdate: TimeInterval = 0;
        private(set) var fps: Int = 0;
        
        func update() {
            let currentUpdate = Date().timeIntervalSinceReferenceDate
            self.fps = Int(1.0 / (currentUpdate - self.lastUpdate));
            self.lastUpdate = currentUpdate;
        }
    }
    
    private let updateTimer = Timer.publish(every: 0.015, on: .main, in: .common).autoconnect();
    private var fpsCalculator = FPSCalculator();
    @State private var updateTrigger = false;
    
    var body: some View {
        JuliaFractal(updateTrigger: self.$updateTrigger)
        .onReceive(self.updateTimer) { _ in
            self.updateTrigger.toggle();
            self.fpsCalculator.update();
            print(self.fpsCalculator.fps);
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
