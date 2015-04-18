var Round = React.createClass({
  render: function() {
    var round = this.props.round;
    return (
      <section className="content" role='tabpanel' id={"panel-" + round.round_number} aria-hidden="true">
        <Teams teams={round.teams} />
      </section>
    );
  }
});
