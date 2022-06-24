function build_chat_channels() {
	chat_channel = ds_list_create();
	for (var i = 0; i < channel.channel_count; ++i) {
	    chat_channel[| i] = ds_list_create();
	}	
}


function network_message_send(_channel, _string) {
	var _buffer = build_packet(network_events.channel_message);
	buffer_write(_buffer, buffer_s8, _channel);
	buffer_write(_buffer, buffer_string, _string);
	
	queue_packet(_buffer);
}

