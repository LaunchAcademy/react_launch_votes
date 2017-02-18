import React from 'react';

let Vote = ({ nominationId, voteHandler, voteId }) => {
  let handleVoteClick = () => {
    voteHandler(nominationId, voteId);
  }

  let voteText;
  if (voteId) {
    voteText = "Voted"
  } else {
    voteText = "Vote"
  }

  return (
    <div className="ribbon" onClick={handleVoteClick}>
      <p>{voteText}</p>
    </div>
  );
}

export default Vote;
