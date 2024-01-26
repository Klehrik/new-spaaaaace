/// Create

depth = 14500;
image_alpha = 0;

Stars = ds_list_create();
for (var n = 0; n < 30; n++) ds_list_add(Stars, [irandom_range(global.CamX, global.CamX + global.CamW), irandom_range(global.CamY, global.CamY + global.CamH)]);