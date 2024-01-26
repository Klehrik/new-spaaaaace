/// Init

depth = -14900;

global.CamX = 0;
global.CamY = 0;
global.Follow = noone;

global.GroupsNum = 2;
global.Groups = [[noone, ds_list_create(), ds_list_create(), 0, 0],
[noone, ds_list_create(), ds_list_create(), 0, 0]]; // [Leader, ds_list(Members), ds_list(Enemy Groups), TargetX, TargetY]

// test
global.Groups[0][2][| 0] = 1;
global.Groups[1][2][| 0] = 0;

global.Cones = -1;

DamageNum = ds_list_create();

//array_test = [4, ds_list_create()];
//array_test[1][| 0] = 2;
//show_debug_message(array_test[1][| 0]);