/// @description 
init_singleton();
/*
	Authetication needs a first packet to get it running on steams side.
	Authentication isnt using the packet_send, so it will never work, 
	AKA check for network send and change to packet send.

*/
network_set_config(network_config_connect_timeout, 1000);
#macro INST_MAP SERVER.instance_map
#macro AUTO_CREATE_PAUSED SERVER.auto_creation_paused

enum map_keys {
	variable_list	
}

instance_map = ds_map_create();

auto_creation_paused = false;

target_ip	= "127.0.0.1";
target_port	= 25565;

host			= -1;			// Bool checks are you a host or a client
server			= -1;			// Hosted server id
client			= -1;			// Socket to other conected client
authenticated	= false;		// Used to check connecting client is on same version
tick_speed		=  3;			// Frames, fps/tick_speed = ticks per second

dynamic_tick_speed	= false;	// Tick speed that changes when needed

network_event_map	= ds_map_create();		// Event map, uses network_game_events as triggers
packet_stack		= ds_stack_create();	// Stack packets to be send over network

max_packet_size = 512;	// In bytes

steam_lobby_steam_ids  = [];



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
	game_event
	
}

enum network_game_events {
	pre_client_connect,
	start_game,
	end_game,
	build_room,
	set_seed,
	room_swap,
	game_over,
	game_win
}
