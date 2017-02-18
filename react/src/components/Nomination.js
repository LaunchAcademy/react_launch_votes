import React from 'react';
import { Link } from 'react-router';
import Vote from './Vote';

let Nomination = ({ currentUser, nomination, teamId, voteHandler }) => {
  let navButtons;
  if (currentUser["admin?"] || nomination.nominator_id === currentUser.id) {
    navButtons = <div className="button-group"><Link className="button" to={`/teams/${teamId}/nominations/${nomination.id}/edit`}>Edit</Link><div className="button">Delete</div></div>
  }
  let voteId;
  if (Object.keys(nomination.voter_ids).includes(String(currentUser.id))) {
    voteId = nomination.voter_ids[String(currentUser.id)]
  }
  return (
    <div className="column">
      <div className="callout secondary text-center">
        <Vote nominationId={nomination.id} voteHandler={voteHandler} voteId={voteId} />
        <img className="nomination" src={nomination.nominee.image_url} />
        <div>
          <span className="label position-top-minus-one"><i className="fa fa-github" />&nbsp;{nomination.nominee.handle}</span>
          <h4 className="pink">{nomination.nominee.name}</h4>
          <h5>{nomination.body}</h5>
        </div>
        {navButtons}
      </div>
    </div>
  );
}

export default Nomination;
