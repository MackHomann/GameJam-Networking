function init_singleton(){
	if (instance_number(object_index) > 1) {
		instance_destroy(id);
		show_debug_message("*WARNING* An object named '" + object_get_name(object_index) + "' has been deleted as it's defined as a singleton...");
	}
}

//function convert_id_for_buffer(_id) {
//	return(_id - ID_OFFSET);
//}
//function convert_id_from_buffer(_id) {
//	return(_id + ID_OFFSET);
//}