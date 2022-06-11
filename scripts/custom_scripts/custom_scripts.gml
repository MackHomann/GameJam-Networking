
function log() {
	var _args = argument_count;
	var _string = "";
	
	for (var i = 0; i < _args; ++i) {
	    _string += string(argument[i]) + " ";
	}
	
	show_debug_message(_string);
}

