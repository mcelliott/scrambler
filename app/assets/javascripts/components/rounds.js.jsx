var Rounds = React.createClass({
  render: function() {
    return (
      <div className="large-12 medium-12 small-12 columns vertical-tab-container" id="teams-list">
        <div className="large-3 medium-3 small-12 columns event-content">
          <ul className="tabs vertical" data-tab="true" options-deep_linking="true" role='tablist'>
            <li className="tab-title active" role="presentational">
              <a href="#participants-tab">Participants</a>
            </li>
            {this.props.rounds.map(function(round) {
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
              <Participants data={this.props.category_participants} />
            </section>
            {this.props.rounds.map(function(round) {
              return (<Round key={round.id} round={round} />);
            }, this)}
          </div>
        </div>
      </div>
    )
  }
});