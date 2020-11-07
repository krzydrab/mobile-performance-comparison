import React, { Component } from 'react';
import { View, Text} from 'react-native';

export default class App extends Component {
  constructor(props) {
    super(props);

    this.state = { frames: 0, fps: 0 };
    this.items = new Array(100).fill(0).map((_, id) => (
      { 
        id, 
        value: Math.random(),
        visibility: true,
      }
    ));
  }

  componentDidMount() {
    const increaseFrames = () => {
      this.setState({ frames: this.state.frames + 1 });
      // this.shuffle();
      this.randomVisiblityChange();
      requestAnimationFrame(increaseFrames);
    }
    increaseFrames();

    this.intervalId = setInterval(() => {
        console.log(this.state.frames);
        this.setState({ frames: 0, fps: this.state.frames });
      }, 1000
    );
  }

  componentWillUnmount() {
    clearInterval(this.intervalId);
  }

  renderItem = (i) => {
    return (
      <View key={i.id} style={{ height: 13 }}>
        <Text>Row: #{i.value}</Text>
      </View>
    );
  }

  shuffle = () => {
    let itemsToChange = 2;
    while(itemsToChange--) {
      a = Math.floor(Math.random() * this.items.length);
      this.items[a].value = Math.random(); // TODO: do not mutate
    }
    this.setState({items: this.items });
  }

  randomVisiblityChange = () => {
    let itemsToChange = 2;
    while(itemsToChange--) {
      a = Math.floor(Math.random() * this.items.length);
      this.items[a].visibility = !this.items[a].visibility; // TODO: do not mutate
    }
    this.setState({items: this.items });
  }

  render() {
    return (
      <View>
        {/* <Text>FPS: { this.state.fps }</Text> */}
        {
          this.items.filter((i) => i.visibility).map((i) => this.renderItem(i))
        }
      </View>
    );
  }
}
