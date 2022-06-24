/// @description 
update_steam_networking();

if (keyboard_check_pressed(vk_enter)) {
	instance_create_depth(irandom(800), irandom(500), depth, NETWORK_ENTITY);
}