
$(document).on('change','#year_selector',function(){
	var year_selected = $('#year_selector').find(":selected").attr("value");
	window.location.href = '/elecciones/'+year_selected;
});

// render the table
tabulate('general_results', results_json.general_results, ['name', 'seats', 'votes', 'percent_votes','percent_seats' ]);
