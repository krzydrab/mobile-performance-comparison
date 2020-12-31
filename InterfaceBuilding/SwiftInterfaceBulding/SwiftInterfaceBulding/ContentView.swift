//
//  ContentView.swift
//  SwiftInterfaceBulding
//
//  Created by Krzysztof Drab on 17/10/2020.
//  Copyright © 2020 Krzysztof Drab. All rights reserved.
//

import SwiftUI

enum TestType {
    case Visibility, Swap, FullRebuild, NoChange
}

struct ContentView: View {
    
    // ====== Test parameters ======
    private let testType: TestType = TestType.FullRebuild;
    private static let singleTestDuration = TimeInterval(10); // in sec
    // =============================
    
    private var tester: Tester
    private var noOpFn = {}
    @State private var updateTimer = Timer.publish(every: 0.016, on: .main, in: .common).autoconnect();
    @State private var testTimer = Timer.publish(every: ContentView.singleTestDuration, on: .main, in: .common).autoconnect();
    @State var showResults = false
    @State var frames = 0
    @State var rows: [RowData] = [];
    
    init() {
        switch(self.testType) {
        case .Visibility:
            self.tester = VisibilityChangeTester()
        case .Swap:
            self.tester = SwapTester()
        case .FullRebuild:
            self.tester = FullRebuildTester()
        case .NoChange:
            self.tester = NoChangeTester()
        }
        self.rows = self.tester.nextTest()
    }
    
    var testView: some View {
        ForEach(rows, id: \.id) { data in
            Button(action: self.noOpFn) {
                Text("Row: \(data.value)")
            }
//            Text("Row: \(data.value)")
//                .font(.system(size: 10))
        }
        .onReceive(self.updateTimer) { _ in
            self.frames += 1
            self.rows = self.tester.updateRows()
        }.onReceive(self.testTimer) { _ in
            self.updateTimer.upstream.connect().cancel()
            self.testTimer.upstream.connect().cancel()
            self.tester.testEnded(fps: Double(self.frames) / ContentView.singleTestDuration)
            self.frames = 0
            if (self.tester.isCompleted()) {
                self.showResults = true
            } else {
                self.rows = self.tester.nextTest()
                self.updateTimer = Timer.publish(every: 0.016, on: .main, in: .common).autoconnect();
                self.testTimer = Timer.publish(every: ContentView.singleTestDuration, on: .main, in: .common).autoconnect();
            }
        }
    }
    
    var resultView: some View {
        ForEach(tester.results, id: \.n) { res in
            Text("N: \(res.n), FPS: \(res.fps), TTM: \(res.timeToModify)")
        }
    }
    
    @ViewBuilder
    var body: some View {
        if(self.showResults) {
            resultView
        } else {
            testView
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
