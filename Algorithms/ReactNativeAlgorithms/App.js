import React, { useState } from 'react';
import { Button, View, Text } from 'react-native';
import RNPickerSelect from 'react-native-picker-select';
import { testAlgorithm } from './src/tester';

export default function App(props) {
  const [result, setResult] = useState("Please start an algorithm to measure time.");
  const [algorithm, setAlgorithm] = useState("ackermannFunction");

  return (
    <View style={ {'flex': 1, 'justifyContent': 'center', 'align-items': 'center' } }>
      <Text>{ result }</Text>
      <RNPickerSelect
        onValueChange={setAlgorithm}
        items={[
          { label: 'Ackermann function', value: 'ackermannFunction' },
          { label: 'Gauss elimination', value: 'gaussElimination' },
          { label: 'Select sort', value: 'selectSort' },
        ]}
        value={algorithm}
      />
      <Button
        onPress={() => {
          const results = testAlgorithm(algorithm, 0, 9);
          const text = results.map((res) => `${res.description}: \t${res.time / 1000.0} s`).join("\n");
          setResult(text);
        }}
        title={"Start"}
      />
    </View>
  );
}