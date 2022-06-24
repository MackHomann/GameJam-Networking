/// @description Updating joined client
log("Sending");

var _buffer = build_packet(network_events.update_client_to_active_server);

var _key = ds_map_find_first(INST_MAP);
log("Start")
repeat(ds_map_size(INST_MAP)) {
	
	var _inst_id		= _key;
	var _inst_map		= ds_map_find_value(INST_MAP, _inst_id);
	var _inst_var_list	= _inst_map[? map_keys.variable_list];
	var _inst_var_count	= ds_list_size(_inst_var_list);
	
	buffer_write(_buffer, buffer_s16,		_inst_id.object_index);	
	buffer_write(_buffer, buffer_string,	_inst_id);
	buffer_write(_buffer, buffer_s8,		_inst_var_count);
	
	for (var i = 0; i < _inst_var_count; ++i) {
		
		var _var_name	= _inst_var_list[|i];
		var _var_value	= variable_instance_get(real(_inst_id), string(_inst_var_list[|i]));
		var _type		= is_string(_var_value) ? buffer_string : buffer_s16;
		
		buffer_write(_buffer, buffer_string, _var_name);	
		buffer_write(_buffer, buffer_s8,	 _type);	
		buffer_write(_buffer, _type,		 _var_value);
		
	}	
		
	_key = ds_map_find_next(INST_MAP, _key);
}

queue_packet(_buffer);

network_client_give_instance_back_control();
		