
function build_packet(_network_event) {
	var _buffer = buffer_create(1, buffer_grow, 1);
				  buffer_write(_buffer, buffer_s8, _network_event);
	return(_buffer);
}

function queue_packet(_packet) {
	ds_stack_push(SERVER.packet_stack, _packet);
}

function crop_packet(_packet) {
	var _realsize = buffer_tell(_packet);
	buffer_resize(_packet, _realsize +1);	
}


function send_packet_stack() {
	while(ds_stack_size(packet_stack) > 0 and client != -1) {
		var _packet = ds_stack_pop(packet_stack);
		if (use_steam_networking) {
			var _sent = steam_net_packet_send(client, _packet, buffer_get_size(_packet), steam_net_packet_type_reliable_buffer)
			if (_sent = 0) {
				log("packet sent failed using steam");
			}
		} else {	
			network_send_packet(client, _packet, buffer_get_size(_packet));
		}
		buffer_delete(_packet);
	}
}