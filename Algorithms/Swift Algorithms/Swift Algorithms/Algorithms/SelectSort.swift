//
//  SelectSort.swift
//  Swift Algorithms
//
//  Created by Krzysztof Drab on 17/05/2020.
//  Copyright © 2020 Krzysztof Drab. All rights reserved.
//

import Foundation

func selectSort(list: inout [Double]) -> [Double] {
    for i in 0..<list.count {
        var minElPos = i;
//        var minEl = list[minElPos];
        for j in (minElPos + 1)..<list.count {
            if list[j] < list[minElPos] {
                minElPos = j;
            }
//            if list[j] < minEl {
//                minElPos = j;
//                minEl = list[minElPos];
//            }
        }
        // swap
//        let temp = list[i];
//        list[i] = list[minElPos];
//        list[minElPos] = temp;
        list.swapAt(i, minElPos);
    }
    return list;
}
