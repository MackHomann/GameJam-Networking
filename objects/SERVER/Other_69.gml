/// @description 
//log("Async: Steam");

AUTO_CREATE_PAUSED = true;
var _map		= async_load;
var _event_type = _map[? "event_type"];
log(_event_type);

switch (_event_type) {
	#region lobby created (server)
    case "lobby_created":
	
        if (_map[? "success"]) {
			server = steam_id_create( _map[?"lobby_id_high"], _map[?"lobby_id_low"]);
			host   = true;
			//steam_lobby_activate_invite_overlay();
		}
		
        break;
		#endregion
	
	#region Joining a lobby after invited via steam (client)
	case "lobby_join_requested":
		server = steam_id_create(async_load[?"lobby_id_high"], async_load[?"lobby_id_low"]);	
		steam_lobby_join_id(server);
		break;
		#endregion
		
	#region jobby joined (client)
	case "lobby_joined":
		
		
		break;
		#endregion
	
	#region	p2p session request (server)
	case "p2p_session_request":
		steam_net_accept_p2p_session(steam_id_create(
		    async_load[?"user_id_high"],
		    async_load[?"user_id_low"]
		));	
		break;
		#endregion
	
	//#region
	//case "":
	//
	//	
	//	break;
	//	#endregion
    default:
        // code here
        break;
}


AUTO_CREATE_PAUSED = false;

