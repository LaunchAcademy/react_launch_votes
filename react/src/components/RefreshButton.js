import React from 'react';

let RefreshButton = ({refreshTeam, teamId}) => {
  let eventTarget;

  let handleButtonClick = (event) => {
    event.target.classList.add('fa-spin');
    refreshTeam(teamId);
    eventTarget = event.target
    setTimeout(stopSpinning, 1000);
  }

  let stopSpinning = () => {
    eventTarget.classList.remove('fa-spin')
  }

  return(
    <i className="fa fa-refresh pink" onClick={handleButtonClick} />
  );
};

export default RefreshButton;
