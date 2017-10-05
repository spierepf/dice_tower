use <tray.scad>;
use <tower.scad>;

PHI = (1 + sqrt(5)) / 2;

wood_thickness = 1.0/8.0;

tray_height = 3;
tray_width = tray_height * PHI;
tray_depth = tray_width * PHI;

tower_height = tray_depth  - 2.0 * wood_thickness;
tower_width  = tray_width  - 2.0 * wood_thickness;
tower_depth  = tray_height - 1.0 * wood_thickness;

tray(tray_height, tray_width, tray_depth, wood_thickness);

translate([wood_thickness, tray_depth - tower_depth - wood_thickness, wood_thickness]){
    tower(tower_height, tower_width, tower_depth, wood_thickness);
}
