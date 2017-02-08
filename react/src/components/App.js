import React, { Component }  from 'react';

class App extends Component {
  constructor(props) {
    super(props);
  }

  render() {
    return(
      <div className="row">
        <div className="small-12 columns">
          <h1>Hello from the <code>App.js</code> component.</h1>
          {this.props.children}
        </div>
      </div>
    )
  }
}

export default App;
