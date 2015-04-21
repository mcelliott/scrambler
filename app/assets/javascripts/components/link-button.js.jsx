var LinkButton = React.createClass({
  render: function() {
    return (
      <a href={this.props.path} className="event-button button-xs">
        <i className={"fa fa-" + this.props.icon}></i>
        &nbsp;{this.props.text}
      </a>
    );
  }
});
