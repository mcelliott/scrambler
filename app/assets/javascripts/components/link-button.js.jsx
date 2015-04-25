var LinkButton = React.createClass({
  render: function() {
    return (
      <a href={this.props.path} className="action-button button">
        <i className={"fa fa-" + this.props.icon}></i>
        {this.props.text}
      </a>
    );
  }
});
