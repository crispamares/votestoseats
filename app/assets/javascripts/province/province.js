
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

});
