/// @description 
if (in_control) {
	image_blend = c_green;
	x += keyboard_check_direct(vk_right) - keyboard_check_direct(vk_left);
	y += keyboard_check_direct(vk_down) - keyboard_check_direct(vk_up);
} else {
	image_blend = c_red;
}