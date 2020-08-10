/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow
 */

import React, { useState } from 'react';
import {
  Button,
  View,
  Text
} from 'react-native';

// const App: () => React$Node = () => {

var NB_OF_ELEMENTS = 40000;

function generateRandomList() {
  var res = new Array(NB_OF_ELEMENTS);
  for(var i = 0; i < res.length; i++) {
    res[i] = Math.random();
  }
  return res;
}

function selectSort(list) {
  for(var i = 0; i < list.length - 1; i++) {
    var min_el_pos = i;
      for(var j = min_el_pos + 1; j < list.length; j++) {
        if(list[j] < list[min_el_pos]) {
          min_el_pos = j;
        }
      }
      // swap
      var temp = list[i];
      list[i] = list[min_el_pos];
      list[min_el_pos] = temp;
    }
    return list;
}

export default function App(props) {
  const [time, setTime] = useState(0);

  return (
    <View style={ {'flex': 1, 'justifyContent': 'center', 'align-items': 'center' } }>
      <Text>
        Time: { time / 1000 }
      </Text>
      <Button
        onPress={() => {
          var list = generateRandomList();
          var start = Date.now();
          selectSort(list);
          var end = Date.now();
          setTime(end - start);
        }}
        title={"Start"}
      />
    </View>
  );
}