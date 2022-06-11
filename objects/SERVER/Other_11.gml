/// @description Joining a server


if (use_steam_networking) {
	exit;
}
client = network_create_socket(network_socket_tcp);
if(network_connect( client, target_ip, target_port) != -1) {
	host = false;
}