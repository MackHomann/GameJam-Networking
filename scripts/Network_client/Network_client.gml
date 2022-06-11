
function network_client_connect(){
	var _map = async_load;
	
	client	 = _map[? "socket"];
	alarm[0] = 1;
	
	network_client_version_handshake();
}

function network_client_disconnect(){
	client		  = -1;
	authenticated = false;
	log("Client has disconected");
	
	var _key = ds_map_find_first(INST_MAP);
	
	while(!is_undefined(_key)) {
		_key.other_id	= -1;
		
		if (_key.auto_fix_in_control) {
			_key.was_other_in_control = !_key.in_control;
		}
		
		_key.in_control		= true;
		
		_key = ds_map_find_next(INST_MAP, _key);
	}
	
}

function network_client_version_handshake() {
	log("Sending handshake")
	var _buffer = build_packet(network_events.version_handshake);
	buffer_write(_buffer, buffer_string, string(VERSION));
	network_send_packet(client, _buffer, buffer_get_size(_buffer));
	buffer_delete(_buffer);
	
}

function network_client_kick() {
	var _buffer = build_packet(network_events.kicked);		
	network_send_packet(client, _buffer, buffer_get_size(_buffer));
	buffer_delete(_buffer);
	
}

function network_client_disconect_from_server() {

	if (use_steam_networking) {
		steam_lobby_leave()
	} else {
		network_destroy(client);
		client	= -1;
		host	= -1;
	}
}
	
function network_client_give_instance_back_control() {

	var _buffer = build_packet(network_events.give_instance_control);
	var _count	= 0;
	
	buffer_write(_buffer, buffer_u8, 0);
	
	with(NETWORK_ENTITY) {
		if (auto_fix_in_control && was_other_in_control) {
			buffer_write(_buffer, buffer_string, string(other_id));
			_count ++;
			was_other_in_control = false;
			in_control			 = false;
		}
	}
	
	buffer_seek(_buffer, buffer_seek_start, 1);
	buffer_write(_buffer, buffer_u8, _count);
	
	queue_packet(_buffer);
	
}
	
function network_client_run_function(_instance_id, _function) {
	
	var _buffer = build_packet(network_events.client_run_function);
	var _count  = argument_count-2;
	
	buffer_write(_buffer, buffer_string, _instance_id);
	buffer_write(_buffer, buffer_u16,	 _function);
	buffer_write(_buffer, buffer_u8,	 _count);
	
	for (var i = 0; i < _count; ++i) {
	    var _type = is_string(argument[i+2])? buffer_string : buffer_u16;
		buffer_write(_buffer, buffer_u8, _type);
		buffer_write(_buffer, _type, argument[i+2]);
	}
	
	queue_packet(_buffer);
} 
