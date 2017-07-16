import React, { Component } from 'react';
import './App.css';

class App extends Component {
  constructor(props) {
    super(props);
    this.state={error:false, messageMe: "", message:"",time: 0, lastKey: ""}
    this.getValue= this.getValue.bind(this)
    this.tick = this.tick.bind(this)
    this.resetTime = this.resetTime.bind(this)
    this.converter = this.converter.bind(this)
    this.onKeyDown = this.onKeyDown.bind(this)
  }
  tick() {
    this.setState((prevState) => ({
      time: prevState.time + 1
    }));
  }
  resetTime() {
    this.setState({time: 0});
    clearInterval(this.interval);
  }
  converter(value){
    if (value === "") { return }
    let cadena = ""
    let keys = [[" ", "0"], [":", "+", "-", "_","1"], ["a", "b", "c", "2"], ["d", "e", "f", "3"],
     ["g", "h", "i", "4"], ["j", "k", "l", "5"], ["m", "n", "o", "6"],
     ["p", "q", "r", "s", "7"], ["t", "u", "v", "8"], ["w", "x", "y", "z", "9"]]
    let a = value.split(/\./)
    for(let i in a){
      if (a[i]!=="") {
        let tam = keys[a[i].slice(-1)].length
        let we = a[i].length % tam
        if (we===0) {
          we = tam
        }
        cadena += keys[a[i].slice(-1)][we - 1]
      }
    }
    return cadena
  }
  onKeyDown(e) {
    if (e.keyCode === 8) {
      this.setState({message: this.state.message.slice(0, -1), messageMe: this.state.messageMe.slice(0,this.state.messageMe.lastIndexOf("."))})
    }
  }
  getValue(e){
    const key = e.target.value.slice(-1)
    this.resetTime()
    this.interval = setInterval(() => this.tick(), 1000);
    let nextMessage = ""
    if (/[^0-9]/.test(key) || key === "") {
      this.setState({error:true})
    }else{
      if ((key === this.state.lastKey || this.state.lastKey==="") && this.state.time < 1){
        //console.log('%c ENTRA: ','background: purple; color: white', key === this.state.lastKey, this.state.lastKey==="", this.state.time < 1)
        nextMessage = this.state.messageMe+key
        this.setState({error:false, messageMe: nextMessage, lastKey: key})
      }else{
        nextMessage = this.state.messageMe+"."+key
        this.setState({error:false, messageMe: nextMessage, lastKey: key})
      }
      this.setState({message: this.converter(nextMessage)})
      //console.log('%c Value: ','background: green; color: red', this.state.message)
    }
  }
  render() {
    const keys = [["ESPACE", "0"], [":", "+", "-", "_", "1"], ["a", "b", "c", "2"], ["d", "e", "f", "3"],
                ["g", "h", "i", "4"], ["j", "k", "l", "5"], ["m", "n", "o", "6"],
                ["p", "q", "r", "s", "7"], ["t", "u", "v", "8"], ["w", "x", "y", "z", "9"]]
    return (
      <div className="App" style={{width: "100%", height: "100%"}}>
        <h2>Escriba su mensaje :)</h2>
        <input type="text" value={this.state.message} onChange={this.getValue} onKeyDown={this.onKeyDown}/>
        <h2>KEYS DISPONIBLES</h2>
        <table style={{margin: "0 auto"}}>
          <thead>
            <tr>
              <th>Key</th>
              <th>Values</th>
            </tr>
          </thead>
          <tbody>
            {keys.map((element)=>(
              <tr key={element[element.length-1]}>
                <td>{element[element.length-1]}</td>
                <td>{element.map((x)=>(<text key={x}>{x} </text>))}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    );
  }
}

export default App;
