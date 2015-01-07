
var Result = Backbone.Model.extend({

	initialize: function(attributes) {
		this.name = attributes[0];
		this.acronym = attributes[1];
		this.votes = attributes[2];
		this.seats = attributes[3];
		this.percent_votes = Math.round(attributes[2]*100/census.attributes.total_voters * 100) / 100 ;
		this.percent_seats = Math.round(attributes[3]*100/census.attributes.province_seats * 100) / 100 ;
	}

});

var Results = Backbone.Collection.extend({

	model: Result,

	parse: function(response) {
		return response.results;
	}

});

var resultView = Backbone.View.extend({

});

var TableOfResults = Backbone.View.extend({

	template: JST['templates/province/dhont_table'],

	render: function(data) {
		this.el = this.template(data);
		$('.table_of_results').prepend(this.el);
		return this;
	},

});

var results = new Results();
results.reset(results_json, {parse: true});
//console.log(results);

table_of_results = new TableOfResults();
table_of_results.render(results);
