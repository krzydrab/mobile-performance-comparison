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
    return list;
}
