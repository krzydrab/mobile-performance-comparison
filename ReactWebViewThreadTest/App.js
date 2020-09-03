import React, { Component } from 'react';
import { View, Text} from 'react-native';
import { WebView } from 'react-native-webview';

export default class App extends Component {
  constructor(props) {
    super(props);

    this.state = { frames: 0, fps: 0 };
  }

  componentDidMount() {
    const increaseFrames = () => {
      this.setState({ frames: this.state.frames + 1 });
      requestAnimationFrame(increaseFrames);
    }
    increaseFrames();
  
    this.intervalId = setInterval(() => 
      this.setState({ frames: 0, fps: this.state.frames }), 1000
    );
  }

  componentWillUnmount() {
    clearInterval(this.intervalId);
  }

  render() {
    const js = "for (;;) { Math.random() * 9999 / 7 }";
    const html = `<html><body>Before<script>${js}</script>After</body></html>`;
  
    return (
      <View style={ { padding: 100, height: 500 } }>
        <WebView
          source={{ html: html }}
          javaScriptEnabledAndroid={true}
        />
        <Text>FPS: { this.state.fps }</Text>
      </View>
    );
  }
}