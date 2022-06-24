
function log() {
	var _args = argument_count;
	var _string = "";
	
	for (var i = 0; i < _args; ++i) {
	    _string += string(argument[i]) + " ";
	}
	
	show_debug_message(_string);
}


function Vector2(_x, _y) constructor
{
    x = _x;
    y = _y;

    static Add = function(_vec2)
    {
        x += _vec2.x;
        y += _vec2.y;
    }
}