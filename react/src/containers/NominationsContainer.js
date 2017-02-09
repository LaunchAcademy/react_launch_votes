import React, { Component } from 'react';
import NewNominationFormContainer from './NewNominationFormContainer'

class NominationsContainer extends Component {
  constructor(props) {
    super(props);
  }

  render() {
    return(
      <div>
        <h2>Hello from the <code>NominationsContainer.js</code> container.</h2>
        <div className="row">
          <div className="small-11 medium-7 small-centered columns">
            <NewNominationFormContainer />
          </div>
        </div>
      </div>
    )
  }
}

export default NominationsContainer;
