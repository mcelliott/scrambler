var FilterBar = React.createClass({
  getInitialState: function() {
    return { filters: [] };
  },
  componentDidMount: function() {
    var filters = window.filters.map(function (filter) {
      filter.enabled = false;
      filter.query_string = "q[" + filter.field + "]";
      return filter
    });
    this.setState({ filters: filters });
  },
  updateFilter: function(filter) {
    var filters = this.state.filters.slice(0);

    for (var i in filters) {
      if (filters[i].uid === filter.uid) {
        filters[i].value = filter.value;
        filters[i].query_string = filter.query_string;
        break;
      }
    }
    this.setState({ filters: filters });
  },
  applyFilter: function() {
    var filteredArray = this.state.filters.filter(function (filter) {
      return filter.enabled === true && Object.keys(filter.value !== 0);
    });

    var payload = filteredArray.map(function (filter) {
      var filterConfig = {};
      filterConfig[filter.query_string] = filter.value;
      var filterParams = $.param(filterConfig);
      return filterParams;
    });

    var result = payload.join("&");

    $.ajax({
      url: this.props.resource_url + '?' + result,
      dataType: 'script',
      success: function (data) {}
    }).fail(function(xhr, status, err) {
      console.error(this.props.resource_url, status, err.toString());
    });

  },
  render: function() {
    var updateFitlerCallback = this.updateFilter;
    var filters = window.filters.map(function (filter) {
      filter.enabled = false;
      filter.query_string = "q[" + filter.field + "]";
      if (filter.input === 'text') {
        return React.createElement(TextField, {
          filter: filter,
          onChange: updateFitlerCallback
        });
      }
    });

    return (
        <div className="search-panel">
          <div className="row">
            <div className='large-12 medium-12 small-12 columns'>
              {filters}
              <ApplyFilterButton onClick={this.applyFilter} />
            </div>
          </div>
        </div>
      );
  }
});

var ApplyFilterButton = React.createClass({
  render: function render() {
    return (
      <div className="large-1 medium-2 small-12 columns end">
        <button className="button-xs search-btn" onClick={this.props.onClick}>
          <span>
            <i className='fa fa-search'></i>
          </span>
        </button>
      </div>
    )
  }
});

var TextField = React.createClass({
  getInitialState: function() {
    return {
      value: this.props.filter.value || ''
    };
  },
  onChange: function(event) {
    var filter = $.extend(true, {}, this.props.filter);
    filter.value = event.target.value;
    this.setState({ value: event.target.value });
    this.props.onChange(filter);
  },
  render: function() {
    this.props.filter.enabled = true
    return React.createElement('div', { className: 'large-4 medium-5 small-12 columns' },
      React.createElement("input", {
        type: "search",
        value: this.state.value,
        onChange: this.onChange,
        id: this.props.filter.field,
        placeholder: this.props.filter.placeholder
      })
    );
  }
});

window.FilterBar = FilterBar;
