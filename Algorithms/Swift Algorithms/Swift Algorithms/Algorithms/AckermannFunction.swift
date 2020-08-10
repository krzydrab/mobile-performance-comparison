//
//  AckermannFunction.swift
//  Swift Algorithms
//
//  Created by Krzysztof Drab on 17/05/2020.
//  Copyright © 2020 Krzysztof Drab. All rights reserved.
//

import Foundation

func ackermannFunction(_ m: Int, _ n: Int) -> Int {
    if(m == 0) {
        return n + 1;
    }
    if(m > 0 && n == 0) {
        return ackermannFunction(m - 1, 1);
    }
    return ackermannFunction(m - 1, ackermannFunction(m, n - 1));
}
