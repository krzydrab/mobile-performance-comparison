//
//  ContentView.swift
//  Swift Algorithms
//
//  Created by Krzysztof Drab on 17/05/2020.
//  Copyright © 2020 Krzysztof Drab. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var algorithmsLabels = ["Ackermann function", "Select sort", "Gauss elimination"]
    var algorithmsTesters = [
        AckermannFunctionTester(),
        SelectSortTester(),
        GaussEliminationTester(),
    ]
    @State private var selectedAlgorithm = 0
    @State var results:String = "Press start to calculate times"
    
    var body: some View {
        VStack {
            Picker(selection: $selectedAlgorithm, label: Text("Please choose an algorithm")
                ) {
                    ForEach(0 ..< self.algorithmsLabels.count) {
                 Text(self.algorithmsLabels[$0])
              }
           }
           Text("\(self.results)")
           Button(action: {
            let results = self.algorithmsTesters[self.selectedAlgorithm].testAll(fromTestSize: 0, toTestSize: 5)
            self.results = results.map { "\($0.description) : \(String(format: "%.06f", $0.time))s" }.joined(separator: "\n")
           }) {
               Text("Start")
           }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
