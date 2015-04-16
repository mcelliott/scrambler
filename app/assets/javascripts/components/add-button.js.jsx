var AddButton = React.createClass({
  add: function() {
    $.ajax({
      type: 'GET',
      url: this.props.path,
      dataType: 'script',
      success: function (data) {}
    }).fail(function(xhr, status, err) {
      console.error(this.props.path, status, err.toString());
    });
  },
  render: function() {
    return (
      <a className="add-button button-xs" onClick={this.add}>
        <i className="fa fa-plus"></i>
      </a>
    );
  }
});