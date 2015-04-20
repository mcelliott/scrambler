var Team = React.createClass({
  render: function() {
    var team = this.props.team;
    return (
      <li className="team-item" id="team-#{team.id}">
        <div className="custom-panel">
            <div className="panel-header">
              <div className="right">
                <DeleteButton path={team.links.delete} confirm={"Delete Team " + team.name + "?"} />
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
              <GetButton path={team.links.new} icon='plus' />
            </div>
        </div>
      </li>
    );
  }
});