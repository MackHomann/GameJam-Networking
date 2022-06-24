init_singleton();
#macro VERSION  string(GAME_CONTROLLER.version)

enum channel {
	client_game,
	server_game,
	server_chat,
	channel_count
}

build_chat_channels();

globalvar use_steam_networking, steam_user_id;
steam_user_id		 = -1;

if(steam_initialised() && steam_is_user_logged_on()) {
    steam_user_id		 = steam_get_user_steam_id();
	use_steam_networking = false;
	steam_net_set_auto_accept_p2p_sessions(true);
}


//avatar_sprite = -1;
//if (avatar_sprite = -1) {
//	var av = steam_get_user_avatar(steam_get_user_steam_id(), steam_user_avatar_size_large);
//	if (av != -1) {
//		avatar_sprite = steam_image_create_sprite(av);
//	}
//	
//}

log("steam_gml_is_available : "  + string(steam_gml_is_available()));
log("steam_gml_is_ready : "		 + string(steam_gml_is_ready()));
log("steam_gml_check_version : " + string(steam_gml_check_version()));
log("steam_controller_init : "	 + string(steam_controller_init()));


instance_create_depth(x,y,depth, SERVER);