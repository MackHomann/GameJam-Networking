/// @description 

if(keyboard_check_pressed(ord("1"))) {
	event_user(0)
}
if(keyboard_check_pressed(ord("2"))) {
	event_user(1)
}

draw_text(10, 10,	  "host    " + string(host));
draw_text(10, 10+40,  "server  " + string(server));
draw_text(10, 10+80,  "client  " + string(client));
draw_text(10, 10+120, "Lobby  " + string(steam_lobby_get_member_count()));
draw_text(10, 10+160, "steam_user_id  " + string(steam_user_id));
