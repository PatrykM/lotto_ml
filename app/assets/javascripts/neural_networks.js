// results_list holds id's of chosen resluts
var results_list = []
$(document).on('turbolinks:load', function () {
	var results=document.getElementById("results");
    if (results) {
	    results.addEventListener('click',function(evt){
	    	 if(evt.target.tagName=="INPUT"){
	    	 		manage_results_list(evt.target.id);
	    	 }
	    	});
	    }
});

// managing results list
function manage_results_list(id) {
	
	var present = results_list.indexOf(id);
	if (present == -1) {
		add_to_results_list(id);
	}else {
		delete_from_results_list(id,present);
	}
}
// delete id from results list
function delete_from_results_list(id,present) {
	results_list.splice(present,1);
}

// add result id to results_list
function add_to_results_list(id) {
		
	if (results_list.length < 10) {
		results_list.push(id);
	}else {
		alert("Jest juz 10 na liscie");
	}
}

	




