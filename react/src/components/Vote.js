import React from 'react';

let Vote = ({ voteText }) => {
  return (
    <div className="ribbon">
      <p>{voteText}</p>
    </div>
  );
}

export default Vote;
