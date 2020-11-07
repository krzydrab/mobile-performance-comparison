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
        private var frames = 0;
        private(set) var fps: Int = 0;

        func update() {
            let currentUpdate = Date().timeIntervalSinceReferenceDate
            if (currentUpdate - lastUpdate >= 1.0) {
                self.fps = frames
                self.frames = 0
                self.lastUpdate = currentUpdate
            };
            self.frames += 1
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
