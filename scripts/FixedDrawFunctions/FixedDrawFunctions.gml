/// Fixed Draw Functions

// Draw a rectangle outline with a specified colour.
// Fixed to work the same for both native and HTML.
// EDIT: Didn't fix shit gamemaker is just broken
function Fdraw_rectangle_colour(x1, y1, x2, y2, c)
{
	if (global.Web == 0) draw_line_colour(x1 - 1, y1, x2, y1, c, c);
	else draw_line_colour(x1, y1, x2, y1, c, c);
	if (global.Web == 1) draw_line_colour(x1, y2, x2 + 1, y2, c, c);
	else draw_line_colour(x1, y2, x2, y2, c, c);
	draw_line_colour(x1, y1, x1, y2, c, c);
	draw_line_colour(x2, y1, x2, y2, c, c);
}