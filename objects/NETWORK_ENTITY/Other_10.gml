/// @description Setup for networking

server_active = (instance_exists(SERVER));

if (server_active && network_has_networking) {
	network_prep_for_networking();
} 

