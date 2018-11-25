$fs=0.5;
$fa=5;

//************************//
// Defaults for all parts //
//************************//
tolerance = 0.2;
wall_thickness = 2.25;
surface_thickness = 2;


//****************//
// Box Properties //
//****************//

/* Includes the height of the interlocking teeth, so the inner
 * diameter of the box will be box_size - 2 * box_thickness - 2 * tooth_height
 */
box_size = 61.5;
box_bevel = 10;
box_thickness = wall_thickness;
box_height = 75;

//*******************//
// Tooth  Properties //
//*******************//
teeth = 3;
tooth_height = 1.5;
tooth_top = 7.5;
tooth_bottom = 5;

//*******************//
// Drawer Properties //
//*******************//
peg_height = surface_thickness;
peg_width= surface_thickness;
peg_offset = surface_thickness;
drawer_thickness = 0.9;

//*********************//
// Computed Properties //
//*********************//
box_inner = box_size - 2 * box_thickness - 2 * tooth_height;
box_inner_bevel = box_bevel - wall_thickness;
drawer_od = box_inner - 2 * tolerance;
drawer_id = drawer_od - 2 * drawer_thickness;
drawer_depth = box_height - surface_thickness - tolerance;
drawer_height = drawer_od * 3/4;
drawer_bevel = box_inner_bevel - tolerance;