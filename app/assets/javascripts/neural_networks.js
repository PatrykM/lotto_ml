// results_list holds id's of chosen resluts
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

$(document).on("change",".game_type", function(){
  $.get($(this).data('href'), null, null, 'script');
  document.getElementById("results_list").value=[];
});

// managing results list
function manage_results_list(id) {
	
	var results_list = get_results_list();
	var present = results_list.indexOf(id);

	if (present == -1) {
		add_to_results_list(id);
	}else {
		delete_from_results_list(id,present);
	}
}

// delete id from results list
function delete_from_results_list(id,present) {
	
	var results_list = get_results_list();
	results_list.splice(present,1);
	set_results_list(results_list);
}

// add result id to results_list
function add_to_results_list(id) {
	
	var results_list = get_results_list();
	if (results_list.length < 10) {
		results_list.push(id);
		set_results_list(results_list);
	}else {
		alert("Jest juz 10 na liscie");
	}
}

// get results from hidden field
function get_results_list(){
	
	var results_list_field = document.getElementById("results_list").value;
	if (results_list_field.length == 0) {
		return [];
	}else {
		return results_list_field.split(",");
	}
}

// set hidden field with results
function set_results_list(list){
	document.getElementById("results_list").value = list.join(",");
}






