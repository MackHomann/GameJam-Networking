/// @description 
// This is wrong. x/y = should only be on new position, x/y += should be outside each frame
if (!in_control && network_pos_dot_predict && !has_updated_this_frame) {
	
	x += predict_dot_x;
	y += predict_dot_y;
	
	network_draw_x = lerp(network_draw_x, x, 1/2);
	network_draw_y = lerp(network_draw_y, y, 1/2);
	
	has_updated_this_frame = true;
} else if (!in_control && network_pos_dot_predict && has_updated_this_frame) {
	network_x = x;
	network_y = y;
}

if (in_control && network_pos_dot_predict) {
	predict_dot_x = x - network_x;
	predict_dot_y = y - network_y;
}

network_draw_x = network_x;
network_draw_y = network_y;

