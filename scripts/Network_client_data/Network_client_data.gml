function network_client_data() {
	
	var _map = async_load;
	var _buffer = _map[? "buffer"];
	
	buffer_seek(_buffer, buffer_seek_start, 0);
	
	var _buffer_event = buffer_read(_buffer, buffer_u8);
	
	switch (_buffer_event) {
		
	    case network_events.sync_inst_ids:
		#region	
			log("Type : network_events.sync_inst_ids");
			
	        var _target_inst_id	= buffer_read(_buffer, buffer_string);
			var _other_inst_id	= buffer_read(_buffer, buffer_string);
			
			while(_target_inst_id != "") {
				with(real(_target_inst_id)) {
					other_id = real(_other_inst_id);
				}
				
				_target_inst_id	= buffer_read(_buffer, buffer_string);
				
				if(_target_inst_id = "") {
					break;
				}
				
				_other_inst_id	= buffer_read(_buffer, buffer_string);
			}
			#endregion
	        break;
			
	    case network_events.create_instance:
		#region
			log("Type : network_events.create_instance");
			
			var _obj_index		=	buffer_read(_buffer, buffer_u8);
			var _other_inst_id	=	buffer_read(_buffer, buffer_string);
			var _x				=	buffer_read(_buffer, buffer_u16);
			var _y				=	buffer_read(_buffer, buffer_u16);
			
			var _inst = instance_create_depth(_x, _y, depth, _obj_index);
			with(_inst) {
				other_id		= _other_inst_id;
				my_id			= _inst.id
				in_control		= false;
			}

			//Returning instance created id	
			
			var _return_buffer = build_packet(network_events.sync_inst_ids);
			buffer_write(_return_buffer, buffer_string, string(_other_inst_id));
			buffer_write(_return_buffer, buffer_string, string(_inst.id));
			
			network_send_packet(client, _return_buffer, buffer_get_size(_return_buffer));
			
			buffer_delete(_return_buffer);
			#endregion
	        break;
			
		case network_events.update_visuals_basic:
		#region
			
			#endregion;
			break;
			
		case network_events.update_position:
		#region
			log("Type : network_events.update_position");
			var _inst_id	= buffer_read(_buffer, buffer_string);
			var _x		    = buffer_read(_buffer, buffer_u16);
			var _y		    = buffer_read(_buffer, buffer_u16);
			
			with(_inst_id) {
				x = _x;
				y = _y;
			}
			#endregion
			break;
			
		case network_events.update_from_map: 
		#region
			//log("Type : network_events.update_from_map");
			var _get_targ_inst = buffer_read(_buffer, buffer_string)
			
			
			while(!is_undefined(_get_targ_inst)) {
				var _targ_inst = real(_get_targ_inst);
				var _var_count = (buffer_read(_buffer, buffer_u8));
				
				repeat(_var_count) {
					var _var_name	 = (buffer_read(_buffer, buffer_string));
					var _buffer_type = (buffer_read(_buffer, buffer_u8));
					var _var_value	 = (buffer_read(_buffer, _buffer_type));
					
					if (instance_exists(_targ_inst)) {
						variable_instance_set(_targ_inst, _var_name, _var_value);
					}
					
				}
				
				var _get_targ_inst = buffer_read(_buffer, buffer_string);
				
				if (_get_targ_inst == "") {
					//log("Updated all instances");
					break;
				}
			}
			
			#endregion
			break;
			
		case network_events.update_client_to_active_server: 
		#region
			log("Type : network_events.update_client_to_active_server");
			
			var _return_buffer		= build_packet(network_events.sync_inst_ids);
			var _buffer_in_use		= false;
			
			var _inst_object_index	= buffer_read(_buffer, buffer_u16);
			var _other_inst			= buffer_read(_buffer, buffer_string);
			
			while(_other_inst != "") {
				
				var _inst_id = instance_create_depth(0, 0, depth, _inst_object_index);
				with(_inst_id) {
					other_id	= _other_inst;
					in_control	= false;
				};
				
				buffer_write(_return_buffer, buffer_string, string(_other_inst));
				buffer_write(_return_buffer, buffer_string, string(_inst_id));
				_buffer_in_use = true;
				
				var _var_count = (buffer_read(_buffer, buffer_u8));
				repeat(_var_count) {
					var _var_name	 = (buffer_read(_buffer, buffer_string));
					var _buffer_type = (buffer_read(_buffer, buffer_u8));
					var _var_value	 = (buffer_read(_buffer, _buffer_type));
					
					if (instance_exists(_inst_id)) {
						variable_instance_set(_inst_id, _var_name, _var_value);
					}
					
				}
				
				var _inst_object_index	= buffer_read(_buffer, buffer_u16);
				var _other_inst			= buffer_read(_buffer, buffer_string);
				
				if (_other_inst = "") {
					log("Made all sever side instances");
					if (_buffer_in_use) {
						queue_packet(_return_buffer);
					}else {
						buffer_delete(_return_buffer);
					}
					
					break;
				}
			}
			
					
			#endregion
			break;
			
		case network_events.kicked:
		#region
			if (client != -1) {
				network_destroy(client);
			}
			#endregion
			break;
			
		case network_events.version_handshake: 
		#region
			if (host) {

				var client_version = buffer_read(_buffer, buffer_string); 
				if (VERSION = client_version) {

					authenticated = true;
	
					if (ds_map_size(INST_MAP) > 0) {
						event_user(2);
					}
					
				} else {

					network_client_kick();
					network_destroy(client);
				}
			} else {

				var server_version = buffer_read(_buffer, buffer_string);
				if (VERSION = server_version) {
					alarm[0] = 1;
					authenticated = true;	
					network_client_version_handshake();
					
				} else {
					network_client_disconect_from_server();
				}
			}
			#endregion
			break;
			
	    default:
	        // code here
	        break;
	};
	
	buffer_delete(_buffer);
};



