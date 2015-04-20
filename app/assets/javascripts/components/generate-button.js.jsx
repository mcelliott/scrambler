var GenerateButton = React.createClass({
  render: function() {
    return (
      <a href='#' className="button-xs" onClick={this.props.onClick}>
        <i className="fa fa-refresh"></i>
        &nbsp;Generate Teams
      </a>
    );
  }
});