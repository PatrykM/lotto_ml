$(document).on('turbolinks:load', function () {
	// clear cookie
	Cookies.set('gameResult','');
	// add event on result click
	$("#result-buttons label").click(function (e) {
		setCookieValue(getId(e.target.id));
	});
});

// $('.btn-group .btn.disabled').click(function(event) {
//   event.stopPropagation();
// });

// set value on cookie
function setCookieValue(button_value) {
	// Get current game result
	var game_result = getGameResult();	
	
	game_result = checkArray(game_result,button_value);
	Cookies.set('gameResult', game_result.join(','));
}

function getGameResult() {
	
	var game_result = Cookies.get('gameResult');
	
	if (game_result != "") {
		game_result = game_result.split(",");
	} else {
		game_result = [];
	}

	return game_result;
}

function checkArray(arr,value) {

	var arr_old_length = arr.length;
	var index = arr.indexOf(value)

	// when number is new
	if (index === -1) {
		if (arr_old_length < 6) {
			arr.push(value);
		} 
	} else {
			arr.splice(index,1);
	}
	// when we rached the numbers limit
	if (arr.length == 6) {
		disableButtons(arr);
	// when limit is changed from max to max-1 we have to enable deactivated buttons
	} else if (arr.length == 5 && arr_old_length == 6 ) {
		
		activateButtons(arr);
	}

	return arr;
}
// Activate buttons
function activateButtons(arr) {
	
	$("#result-buttons label").each(function() {
		if (arr.indexOf(getId($(this).attr("id"))) === -1) {
			$(this).attr("class","label-static btn btn-default");
		} 
		// else {
		// 	$(this).attr("class","label-static btn btn-default active");
		// 	//$(this).blur();
		// }
	});
	
}
// Set disabled state on button
function disableButtons(arr) {
	$("#result-buttons label").each(function() {
		if (arr.indexOf(getId($(this).attr("id"))) === -1) {
			$(this).attr("class","label-static btn btn-default disabled");
		}
	});
};
// Get number from id string
function getId(id) {
	return id.replace('result_','');
}