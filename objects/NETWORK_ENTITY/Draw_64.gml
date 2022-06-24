/// @description
//draw_self();
draw_text(x, y, "in_control : "  + string(in_control))
draw_text(x, y+25, "instance_id : " + string(id))
draw_text(x, y+50, "other_id : "	 + string(other_id))
draw_text(x, y+75, "predict_dot_x : "	 + string(predict_dot_x) + " , " + "predict_dot_y : " + string(predict_dot_y))
draw_text(x, y+100, "network_x : "	 + string(network_x) + " , " + "network_y : " + string(network_y))
draw_text(x, y+125, "has_updated_this_frame : "	 + string(has_updated_this_frame))

