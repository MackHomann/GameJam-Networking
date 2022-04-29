/// @description Creating server

if (server = -1 and host = -1) {
	
	var port = 25565;
	server = network_create_server(network_socket_tcp, port, 2);
	while (server < 0 && port < 65535) {
	    port++
	    server = network_create_server(network_socket_tcp, port, 2);
	}
	log("port: " + string(port));
	if (server != -1) {
		host	= true;
		
		with(HAS_NETWORK_ENTITY) {
			event_user(0);	
		}
	}
}

