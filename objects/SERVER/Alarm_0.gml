/// @description Server Tick 
/*
On a server tick this event will go thought the active instance list 
and see if said instance is stored as a key in the instance_map.

If the instance is stored, it will go though the stored ds_list of variables,
grab the variable value and store it in a buffer to be sent to conected clients.

buffer_sizeof(type);
buffer_fixed
buffer_resize

var test = buffer_compress(_map_buffer, 0, buffer_tell(_map_buffer));
log(buffer_get_size(test));
buffer_delete(test);
*/
//log(authenticated);
if (authenticated and ds_map_size(INST_MAP) > 0) {
	var _collective_packet_size = 0;
	var _map_buffer		= build_packet(network_events.update_from_map);
	var _buffer_in_use	= false;

	var _key = ds_map_find_first(INST_MAP);
	
	while(!is_undefined(_key)) {
		
		var _inst_map		= ds_map_find_value(INST_MAP, _key);
		var _inst_var_list	= _inst_map[? map_keys.variable_list];
		var _target_inst	= _key.other_id;
		
		if (_target_inst != -1 && _key.in_control) {
			
			_buffer_in_use = true;
			
			buffer_write(_map_buffer, buffer_string, string(_target_inst));
			buffer_write(_map_buffer, buffer_s8, ds_list_size(_inst_var_list));
			
			for (var i = 0; i < ds_list_size(_inst_var_list); ++i) {
					
				var _var_name	= _inst_var_list[|i];
				var _var_value	= variable_instance_get(real(_key), string(_inst_var_list[|i]));
				var _type		= is_string(_var_value) ? buffer_string : buffer_s16;

				buffer_write(_map_buffer, buffer_string, _var_name);	
				buffer_write(_map_buffer, buffer_s8,	 _type);	
				buffer_write(_map_buffer, _type,		 _var_value);	

			}
		} 
		
		_collective_packet_size += buffer_get_size(_map_buffer);
		
		if (buffer_get_size(_map_buffer) > max_packet_size) {
			crop_packet(_map_buffer);
			queue_packet(_map_buffer);
			var _map_buffer	= build_packet(network_events.update_from_map);
				_buffer_in_use = false;	
		}
		
		_key = ds_map_find_next(INST_MAP, _key);
	}

	if (_buffer_in_use) {
		
		crop_packet(_map_buffer);
		queue_packet(_map_buffer);
		
	} else {
		buffer_delete(_map_buffer);
	}

}

alarm[0] = tick_speed; 