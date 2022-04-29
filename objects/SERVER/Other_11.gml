/// @description Joining a server


client = network_create_socket(network_socket_tcp);
if(network_connect( client, "127.0.0.1", 25565 ) != -1) {
	host = false;
}