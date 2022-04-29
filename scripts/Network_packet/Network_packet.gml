
function build_packet(_network_event) {
	var _buffer = buffer_create(1, buffer_grow, 1);
				  buffer_write(_buffer, buffer_u8, _network_event);
	return(_buffer);
}

function queue_packet(_packet) {
	ds_stack_push(SERVER.packet_stack, _packet);
}

function crop_packet(_packet) {
	var _realsize = buffer_tell(_packet);
	buffer_resize(_packet, _realsize +1);	
}
