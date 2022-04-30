init_singleton();
#macro log show_debug_message
#macro VERSION  string(GAME_CONTROLLER.version)

enum channel {
	client_game,
	server_game,
	server_chat,
	channel_count
}

build_chat_channels();

instance_create_layer(x, y, layer, SERVER);

