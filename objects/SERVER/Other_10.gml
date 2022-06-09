/// @description Creating server

if (server = -1 and host = -1) {
	
	var port = target_port;
	server = network_create_server(network_socket_tcp, port, 2);
	while (server < 0 && port < 25665) {
	    port++
	    server = network_create_server(network_socket_tcp, port, 2);
	}

	if (server != -1) {
		host	= true;
		
		with(NETWORK_ENTITY) {
			event_user(0);	
		}
	}
	
}

