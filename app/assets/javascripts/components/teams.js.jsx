var Teams = React.createClass({
  render: function() {
    var teams = this.props.teams;
    return (
      <div className="large-12 medium-12 small-12 columns">
        <ul>
          {teams.map(function(team) {
            return (<Team key={team.id} team={team} />);
          }, this)}
        </ul>
      </div>
    );
  }
});