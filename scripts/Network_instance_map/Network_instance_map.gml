function instance_map_add_var() {
	
	var _count		= argument_count;
	var _key		= id;
	var _inst_map	= ds_map_find_value(INST_MAP, _key);
	
	if (is_undefined(_inst_map)) {
		
		ds_map_add(INST_MAP, _key, ds_map_create());		
		_inst_map = ds_map_find_value(INST_MAP, _key);
		
	}
	
	for (var i = 0; i < _count; ++i) {
		if (variable_instance_exists(_key, argument[i])) {
			
			var _variable	= argument[i];
			if (!ds_map_exists(_inst_map, map_keys.variable_list)) {
				ds_map_add(_inst_map,  map_keys.variable_list, ds_list_create());
			}
			
			var _inst_var_list = _inst_map[? map_keys.variable_list]
			ds_list_add(_inst_var_list, _variable);
			
		}
	}
}

function instance_map_destroy() {
	var _key  = id;
	var _inst_map = ds_map_find_value(INST_MAP, _key);
	
	if (!is_undefined(_inst_map)) {
		ds_list_destroy(_inst_map[? map_keys.variable_list]);
		ds_map_destroy(_inst_map);
	}
}
	

