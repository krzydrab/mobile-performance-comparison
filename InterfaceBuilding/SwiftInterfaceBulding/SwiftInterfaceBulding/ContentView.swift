//
//  ContentView.swift
//  SwiftInterfaceBulding
//
//  Created by Krzysztof Drab on 17/10/2020.
//  Copyright © 2020 Krzysztof Drab. All rights reserved.
//

import SwiftUI

func generateRandomList(size: Int) -> [Double] {
    var res = Array<Double>(repeating: 0.0, count: size)
    for i in 0..<size {
        res[i] = Double.random(in: 0...1)
    }
    return res;
}
//    let randomName = names.randomElement()
struct ContentView: View {
    // https://medium.com/swlh/swiftui-performance-battle-anyview-vs-group-55bf852158df
    private class FPSCalculator {
        private var lastUpdate: TimeInterval = 0;
        private var frames = 0;
        private(set) var fps: Int = 0;

        func update() {
            let currentUpdate = Date().timeIntervalSinceReferenceDate;
            if (currentUpdate - lastUpdate >= 1.0) {
                self.fps = frames;
                self.frames = 0;
                self.lastUpdate = currentUpdate
            }
            self.frames += 1;
        }
    }
    
    struct RowData: Identifiable {
        var id = UUID()
        var value: Double
        var visibility = true
    }
    
    struct RowView: View {
        public var data: RowData

        var body: some View {
            Text("Row: \(data.value)")
                .font(.system(size: 10))
        }
    }
    
    // Understand better changing the model
    // I think we should measure CPU and check CPU according to number of elements rendered
    
    func randomVisiblityChange() {
      var itemsToChange = 2;
      while(itemsToChange > 0) {
        let pos = Int.random(in: 0..<self.rows.count);
        self.rows[pos] = RowData(id: self.rows[pos].id, value: Double.random(in: 0...1), visibility: !self.rows[pos].visibility);
        itemsToChange -= 1;
      }
    }
    
    func randomElementsSwap() {
        var itemsToChange = 10;
        while(itemsToChange > 0) {
            let i = Int.random(in: 0..<self.rows.count);
            let j = Int.random(in: 0..<self.rows.count);
            rows.swapAt(i, j);
            itemsToChange -= 1;
        }
    }
    
    private let updateTimer = Timer.publish(every: 0.010, on: .main, in: .common).autoconnect();
    private var fpsCalculator = FPSCalculator();
    @State private var updateTrigger = false;
    @State var rows = generateRandomList(size: 100).map {
        RowData(value: $0)
    };
    
    var body: some View {
//        List(rows) { row in
//            RowView(data: row)
//        }.environment(\.defaultMinListRowHeight, 7)
        ForEach(rows.filter(\.visibility), id: \.id) { data in
            RowView(data: data)
        }
        .onReceive(self.updateTimer) { _ in
//            self.updateTrigger.toggle();
            self.fpsCalculator.update();
//            self.randomVisiblityChange();
            self.randomElementsSwap();
            print(self.fpsCalculator.fps);
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
