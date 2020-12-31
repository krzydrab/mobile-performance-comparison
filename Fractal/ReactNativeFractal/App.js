import React, { useState, useEffect } from 'react';
import { View, Text, Dimensions } from 'react-native';
import { WebView } from 'react-native-webview';
import Julia from './src/julia.js';

export default function App() {
  // ====== Test parameters ======
  const singleTestDuration = 20; // in sec
  // =============================

  const [frames, setFrames]= useState(0);
  const [calculatingTime, setCalculatingTime] = useState(0);
  const [showResults, setShowResults] = useState(false);

  const height = Dimensions.get('window').height;
  const width = Dimensions.get('window').width;

  useEffect(
    () => {
      let timer = setTimeout(() => setShowResults(true), singleTestDuration * 1000)

      return () => { clearTimeout(timer) }
    }, []
  )

  return (
    <View style={{ height: height - 40 }}>
      { showResults 
        ? <View style={{ marginTop: 50 }}>
            <Text>FPS: { frames / singleTestDuration }</Text>
            <Text>Calculating time: { calculatingTime / frames }</Text>
          </View>
        : <WebView
            style={{ marginTop: 50, width: "100%" }}
            automaticallyAdjustContentInsets={false}
            source={{ html: Julia}}
            javaScriptEnabledAndroid={true}
            scalesPageToFit={true}
            onMessage={event => {
              const parsedData = JSON.parse(event.nativeEvent.data);
              setFrames(parsedData.frames);
              setCalculatingTime(parsedData.calculatingTime);
            }}
          />
      }
    </View>
  );
}