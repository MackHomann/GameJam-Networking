/// @description Joining a server

client = network_create_socket(network_socket_tcp);
if(network_connect( client, target_ip, target_port) != -1) {
	host = false;
}