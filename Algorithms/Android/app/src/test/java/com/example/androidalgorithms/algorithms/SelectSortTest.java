package com.example.androidalgorithms.algorithms;

import org.junit.Assert;
import org.junit.Test;

public class SelectSortTest {
    @Test
    public void sort_SmallInput_ReturnsCorrectValue() {
        double[] input = { 0.2, 11, 3.14, -1, 1, 0.21, 10.999 };
        double[] expected = { -1, 0.2, 0.21, 1, 3.14, 10.999, 11 };
        double[] actual = (new SelectSort()).call(input);

        Assert.assertArrayEquals(actual, expected, 0.000001);
    }
}
