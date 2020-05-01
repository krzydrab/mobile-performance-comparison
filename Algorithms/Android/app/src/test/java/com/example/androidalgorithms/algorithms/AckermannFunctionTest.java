package com.example.androidalgorithms.algorithms;

import org.junit.Assert;
import org.junit.Test;

public class AckermannFunctionTest {
    @Test
    public void ackermannFunction_SmallInput_ReturnsCorrectValue() {
        Assert.assertEquals((new AckermannFunction()).call(2, 3), 9);
    }

    @Test
    public void ackermannFunction_MediumInput_ReturnsCorrectValue() {
        Assert.assertEquals((new AckermannFunction()).call(3, 5), 253);
    }
}
