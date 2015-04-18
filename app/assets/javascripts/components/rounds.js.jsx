var Rounds = React.createClass({
  getInitialState: function() {
    return { category_participants: [], rounds: [] };
  },
  componentDidMount: function() {
    $.ajax({
      url: this.props.path,
      dataType: 'json',
      success: function(data) {
        this.setState({category_participants: data.event.category_participants, rounds: data.event.rounds});
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(this.props.path, status, err.toString());
      }.bind(this)
    });
  },
  render: function() {
    return (
      <div className="large-12 medium-12 small-12 columns vertical-tab-container" id="teams-list">
        <div className="large-3 medium-3 small-12 columns event-content">
          <ul className="tabs vertical" data-tab="true" options-deep_linking="true" role='tablist'>
            <li className="tab-title active" role="presentational">
              <a href="#participants-tab">Participants</a>
            </li>
            {this.state.rounds.map(function(round) {
              return (
                <li className="tab-title" role="presentational">
                  <a href={"#panel-" + round.round_number} >Round {round.round_number}</a>
                </li>
              )
            }, this)}
          </ul>
        </div>
        <div className="large-9 medium-9 small-12 columns event-content">
          <div className="tabs-content">
            <section className="content active" role='tabpanel' id="participants-tab" aria-hidden="true">
              <Participants data={this.state.category_participants} />
            </section>
            {this.state.rounds.map(function(round) {
              return (<Round key={round.id} round={round} />);
            }, this)}
          </div>
        </div>
      </div>
    )
  }
});