/// focus_window

if (mouse_check_button_pressed(mb_any)) focus_window();

if (global.DT <= 1) window_center();
global.DT += 1;