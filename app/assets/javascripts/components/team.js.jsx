var Team = React.createClass({
  render: function() {
    var team = this.props.team;
    return (
      <li className="team-item" id="team-#{team.id}">
        <div className="custom-panel">
            <div className="panel-header">
              <div className="right">
                <DeleteButton path="event_team_path(team, event_id: event.id)" confirm="Delete Team #{team.id}?" />
              </div>
              {team.name} - {team.category_name}
            </div>
            <div className="panel-content">
              <div className="team-participant-list">
                {team.team_participants.map(function(tp) {
                  return (<TeamParticipant data={tp} />);
                }, this)}
              </div>
            </div>
            <div className="panel-footer">
              <GetButton path="new_teams_participant_path(team_id: team.id, event_id: event.id)" icon='plus' />
            </div>
        </div>
      </li>
    );
  }
});