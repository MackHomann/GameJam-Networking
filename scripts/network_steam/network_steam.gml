
function update_steam_networking(){
	if (use_steam_networking) {
		
		steam_net_update();
		
		if (server != -1) {
			
			host = steam_lobby_is_owner();
			
			while (steam_net_packet_receive()) {
				 var _buffer = buffer_create(1, buffer_grow, 1);
				 steam_net_packet_get_data(_buffer)
				 network_client_data(_buffer);
			}
			
			if (client = -1 && steam_lobby_get_member_count() = 2) {
				for (var i = 0; i < steam_lobby_get_member_count(); ++i) {
				    steam_lobby_steam_ids[i] = steam_lobby_get_member_id(i);
					if (steam_lobby_steam_ids[i] != steam_user_id) {
						client = steam_lobby_steam_ids[i];
					}
				}
			}
			
			if (client != -1 and steam_lobby_get_member_count() = 1) {
				network_client_disconnect();
			}
		}
	
	}

}