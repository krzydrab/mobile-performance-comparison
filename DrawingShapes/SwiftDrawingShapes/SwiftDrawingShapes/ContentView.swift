//
//  ContentView.swift
//  SwiftDrawingShapes
//
//  Created by Krzysztof Drab on 04/11/2020.
//  Copyright © 2020 Krzysztof Drab. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    let screenSize: CGRect = UIScreen.main.bounds
    let ovalSize: CGFloat
    let rectSize: CGFloat
    let width: Int
    let height: Int
    //=== TEST PARAMETERS ===
    let numberOfShapes = 100
    let mode = "ovals"
    //=======================
    
    init() {
        ovalSize = screenSize.width * 0.1
        rectSize = screenSize.width * 0.1
        width = Int(screenSize.width * 0.8)
        height = Int(screenSize.height * 0.8)
    }
    
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

    private let updateTimer = Timer.publish(every: 0.0166, on: .main, in: .common).autoconnect();
    private var fpsCalculator = FPSCalculator();
    @State private var updateTrigger = false;

    var ovals: some View {
        let _ = self.updateTrigger; // Trick swift to rebuild
        let colors = Gradient(colors: [
            Color.init(red: 1, green: 0, blue: 0).opacity(0.3),
            Color.init(red: 1, green: 1, blue: 0).opacity(0.1),
        ])
        let gradient = RadialGradient(gradient: colors, center: .center, startRadius: 0, endRadius: ovalSize/2)
        return ZStack {
            ForEach(0 ..< self.numberOfShapes) { _ in
                return Circle()
                    .fill(gradient)
                    .frame(width: self.ovalSize, height: self.ovalSize)
                    .position(CGPoint(x: Int.random(in: 0...self.width), y: Int.random(in: 0...self.height)))
            }
        }
    }
    
    var rects: some View {
        let _ = self.updateTrigger; // Trick swift to rebuild
         return ZStack {
            ForEach(0 ..< self.numberOfShapes) { _ in
                 return Rectangle()
                     .stroke()
                     .rotation(Angle(degrees: Double.random(in: 1...356)))
                     .frame(width: self.rectSize, height: self.rectSize)
                     .position(CGPoint(x: Int.random(in: 0...self.width), y: Int.random(in: 0...self.height)))
             }
         }
    }
    
    @ViewBuilder
    var body: some View {
        if (mode == "ovals") {
            ovals.onReceive(self.updateTimer) { _ in
                self.updateTrigger.toggle();
                self.fpsCalculator.update();
                print(self.fpsCalculator.fps);
            }
        } else {
            rects.onReceive(self.updateTimer) { _ in
                self.updateTrigger.toggle();
                self.fpsCalculator.update();
                print(self.fpsCalculator.fps);
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
