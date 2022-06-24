/// @description 
server_active = (instance_exists(SERVER));

has_updated_this_frame = false;

network_pos_dot_predict = true;

network_x = x;
network_y = y;

predict_dot_x = 0.0;
predict_dot_y = 0.0;

network_draw_x = x;
network_draw_y = y;

network_max_pixels_wrong = 2;

function network_prep_for_networking () {
	
	instance_setup_paired_ids();
	
	if (network_use_map) {
		instance_map_add_var("x", "y");
		
		if (network_pos_dot_predict) {
			instance_map_add_var("predict_dot_x", "predict_dot_y");
		}
	}
	
	if (!AUTO_CREATE_PAUSED && network_auto_network_create) {
		instance_network_create();
	}
}

if (server_active && network_has_networking) {
	network_prep_for_networking();
} 


///TO DO
/*
	 have an active list so it only sends active objects
	 make instance hold values in a map update in begin step, 
	 then check if they updated by begining of the end step, 
	 if so add id to active list.
	 make it so server runs last, or first.
	 
	 change options for starting network map add var, 
	 add instance_map_remove_var() function
	 
	 
	 drawing using network_pos_dot_predict should 
	 use the pixel buffer idea, have vars that only use the dot product 
	 and only update when to far away. 
	 

*/

