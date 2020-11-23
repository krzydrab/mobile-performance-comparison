import React, { useState } from 'react';
import { View, Text, Dimensions } from 'react-native';
import { WebView } from 'react-native-webview';
import Julia from './src/julia.js';

export default function App() {
  const [fps, setFps]= useState(0);
  const [fpsHistory, setFpsHistory] = useState([])

  const height = Dimensions.get('window').height;

  return (
    <View style={{ height: height - 40 }}>
      <WebView
        style={{ marginTop: 50 }}
        automaticallyAdjustContentInsets={false}
        source={{ html: Julia}}
        javaScriptEnabledAndroid={true}
        scalesPageToFit={true}
        onMessage={event => {
          setFps(event.nativeEvent.data);
          setFpsHistory([...fpsHistory, +event.nativeEvent.data]);
        }}
      />
      <Text>FPS: { fps } / {fpsHistory.reduce((acc, n) => acc + n, 0) / fpsHistory.length}</Text>
    </View>
  );
}