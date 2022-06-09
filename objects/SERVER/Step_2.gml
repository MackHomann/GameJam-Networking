/// @description 

while(ds_stack_size(packet_stack) > 0 and client != -1) {
	var _packet = ds_stack_pop(packet_stack);
	network_send_packet(client, _packet, buffer_get_size(_packet));
	buffer_delete(_packet);
}
