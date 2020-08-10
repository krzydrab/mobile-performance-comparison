//
//  ContentView.swift
//  swfit_select_sort
//
//  Created by Krzysztof Drab on 17/02/2020.
//  Copyright © 2020 Krzysztof Drab. All rights reserved.
//

import SwiftUI

var NUMBER_OF_ELEMENTS = 10000

func generateRandomList() -> [Double] {
    var res = Array<Double>(repeating: 0.0, count: NUMBER_OF_ELEMENTS)
    for i in 0..<NUMBER_OF_ELEMENTS {
        res[i] = Double.random(in: 0...1)
    }
    return res;
}

func selectSort(list: inout [Double]) -> Void {
    for i in 0..<list.count {
        var minElPos = i;
        for j in (minElPos + 1)..<list.count {
            if list[j] < list[minElPos] {
                minElPos = j;
            }
        }
        // swap
        let temp = list[i];
        list[i] = list[minElPos];
        list[minElPos] = temp;
    }
}

func selectSort2(list: inout [Double]) -> Void {
    var i = 0, j = 0
    while i < list.count {
        var minElPos = i;
        j = minElPos + 1
        while j < list.count {
            if list[j] < list[minElPos] {
                minElPos = j;
            }
            j += 1
        }
        // swap
        let temp = list[i];
        list[i] = list[minElPos];
        list[minElPos] = temp;
        i += 1
    }
}

struct ContentView: View {
    @State var time:Double = 0
    
    var body: some View {
        VStack {
            Text("Time: \(self.time)")
            Button(action: {
                var list = generateRandomList()
                let startingPoint = Date()
                selectSort2(list: &list)
                self.time = startingPoint.timeIntervalSinceNow * -1
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
