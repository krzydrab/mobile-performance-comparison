package com.example.androidalgorithms.algorithms;

import org.junit.Assert;
import org.junit.Test;

public class GaussEliminationTest {
    @Test
    public void gauss_SmallInput_ReturnsCorrectValue() {
        double[][] testMatrix = {
            { 4, -2, 4, -2, 8 },
            { 3, 1, 4, 2, 7 },
            { 2, 4, 2, 1, 10 },
            { 2, -2, 4, 2, 2 }
        };
        double[] expected = { -1, 2, 3, -2 };
        double[] actual = (new GaussElimination()).call(testMatrix);

        Assert.assertArrayEquals(actual, expected, 0.000001);
    }
}
