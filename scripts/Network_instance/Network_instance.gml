
function instance_network_create() {
	var _buffer = build_packet(network_events.create_instance);
	
	buffer_write(_buffer, buffer_s8,		object_index);
	buffer_write(_buffer, buffer_string,	string(my_id));
	buffer_write(_buffer, buffer_s16,		x);
	buffer_write(_buffer, buffer_s16,		y);
	
	queue_packet(_buffer);
}

function instance_update_position() {
	var _buffer = build_packet(network_events.update_position);	
	
	buffer_write(_buffer, buffer_string,	string(other_id));
	buffer_write(_buffer, buffer_s16,		x);
	buffer_write(_buffer, buffer_s16,		y);
	
	queue_packet(_buffer);
}

function instance_update_visuals_basic() {
	var _buffer = build_packet(network_events.update_visuals_basic);	

	buffer_write(_buffer, buffer_s16,		sprite_index);
	buffer_write(_buffer, buffer_s16,		image_index);
	
	queue_packet(_buffer);	
}
	
function instance_setup_paired_ids() {
	my_id	 = id;
	other_id = -1;
	in_control = true;
}

function instance_give_control () {
	
	was_other_in_control = false;
	in_control			 = false;
	
	var _buffer = build_packet(network_events.give_instance_control);

	buffer_write(_buffer, buffer_s8, 1);
	buffer_write(_buffer, buffer_string, string(other_id));

	queue_packet(_buffer)
}
