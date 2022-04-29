/// @description 
AUTO_CREATE_PAUSED = true;
var _map		= async_load;
var _type		= _map[? "type"];
//var _socket_id	= _map[? "id"];
//var _socket_ip	= _map[? "ip"];

switch (_type) {
    case network_type_connect:
        network_client_connect();
        break;
    case network_type_disconnect:
        network_client_disconnect();
        break;
    case network_type_data:
        network_client_data();
        break;
    default:
        
        break;
};

AUTO_CREATE_PAUSED = false;
