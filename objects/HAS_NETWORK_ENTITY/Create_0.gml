/// @description 
server_active = (instance_exists(SERVER));


if (server_active && network_has_networking) {
	
	instance_setup_paired_ids();
	
	if (network_use_map) {
		instance_map_add_var("x", "y");
	}
	
	if (!AUTO_CREATE_PAUSED && network_auto_network_create) {
		instance_network_create();
	}
	
} 

