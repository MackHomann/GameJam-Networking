/// @description 
init_singleton();

network_set_config(network_config_connect_timeout, 1000);
#macro INST_MAP SERVER.instance_map
#macro AUTO_CREATE_PAUSED SERVER.auto_creation_paused

enum map_keys {
	variable_list	
}

instance_map = ds_map_create();

auto_creation_paused = false;

host			= -1;	// Bool checks are you a host or a client
server			= -1;	// Hosted server id
client			= -1;	// Client connected to the server
authenticated	= false	// Used to check connecting client is on same version
tick_speed		=  1;	// Frames, fps/tick_speed = ticks per second

packet_stack = ds_stack_create();

max_packet_size = 512;	// bytes



enum network_events {
	
	version_handshake,
	kicked,
	sync_inst_ids,
	create_instance,
	update_client_to_active_server,
	update_position,
	update_visuals_basic,	// unfinished
	update_from_map,
	give_instance_control,
	client_run_function,
	channel_message,
	network_function_list,	// unfinished
	instance_function_list	// unfinished
	
	
}

enum network_custom_events {
	start_game,
	end_game,
	build_room,
	set_seed,
	room_swap,
	game_over,
	game_win
}
