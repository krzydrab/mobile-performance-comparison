package com.example.androidalgorithms.algorithms;

public class SelectSort {

    // NOTE: function mutates input
    public static double[] call(double[] list) {
        for(int i = 0; i < list.length - 1; i++) {
            int min_el_pos = i;
            for(int j = min_el_pos + 1; j < list.length; j++) {
                if(list[j] < list[min_el_pos]) {
                    min_el_pos = j;
                }
            }
            // swap
            double temp = list[i];
            list[i] = list[min_el_pos];
            list[min_el_pos] = temp;
        }
        return list;
    }

}
