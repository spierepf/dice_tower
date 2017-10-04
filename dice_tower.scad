include <axes.scad>;
use <face.scad>;
use <list.scad>;

PHI = (1 + sqrt(5)) / 2;

wood_thickness = 1.0/8.0;

tray_height = 3;
tray_width = tray_height * PHI;
tray_depth = tray_width * PHI;

tower_height = tray_depth  - 2.0 * wood_thickness;
tower_width  = tray_width  - 2.0 * wood_thickness;
tower_depth  = tray_height - 1.0 * wood_thickness;

tray_points = [
    [0,             0,                                              0],                 // 0  bottom front left
    [tray_width,    0,                                              0],                 // 1  bottom front right
    [tray_width,    tray_depth,                                     0],                 // 2  bottom back right
    [0,             tray_depth,                                     0],                 // 3  bottom back left
    [0,             0,                                              tray_height/2.0],   // 4  top front left (low)
    [tray_width,    0,                                              tray_height/2.0],   // 5  top front right (low)
    [tray_width,    0 + tower_depth + 2*wood_thickness,             tray_height/2.0],   // 6  top middle right (low)
    [tray_width,    tray_depth - tower_depth - 2*wood_thickness,    tray_height],       // 7  top middle right (high)
    [tray_width,    tray_depth,                                     tray_height],       // 8  top back right (high)
    [0,             tray_depth,                                     tray_height],       // 9  top back left (high)
    [0,             tray_depth - tower_depth - 2*wood_thickness,    tray_height],       // 10 top middle left (high)
    [0,             0 + tower_depth + 2*wood_thickness,             tray_height/2.0],   // 11 top middle left (low)
];

// bottom
color("blue") {
    face(select(tray_points, [0, 1, 2, 3]), wood_thickness * Z);
}

// front
color("green") {
    face(select(tray_points, [1, 0, 4, 5]), wood_thickness * Y);
}

// right
color("red") {
    face(select(tray_points, [2, 1, 5, 6, 7, 8]), wood_thickness * -X);
}

// back
color("green") {
    face(select(tray_points, [3, 2, 8, 9]), wood_thickness * -Y);
}

// left
color("red") {
    face(select(tray_points, [0, 3, 9, 10, 11, 4]), wood_thickness * X);
}

tower_points = [
    [0,             0,                                          0],                 // 0  bottom front left
    [tower_width,   0,                                          0],                 // 1  bottom front right
    [tower_width,   tower_depth,                                0],                 // 2  bottom back right
    [0,             tower_depth,                                0],                 // 3  bottom back left
    [0,             0,                                          tower_height],      // 4  top front left
    [tower_width,   0,                                          tower_height],      // 5  top front right
    [tower_width,   tower_depth,                                tower_height],      // 6  top back right
    [0,             tower_depth,                                tower_height],      // 7  top back left
];

translate([wood_thickness, tray_depth - tower_depth - 2 * wood_thickness, wood_thickness]){
    // bottom
    color("blue") {
        face(select(tower_points, [0, 1, 2, 3]), wood_thickness * Z);
    }

    // front
    color("green") {
        face(select(tower_points, [1, 0, 4, 5]), wood_thickness * Y);
    }

    // right
    color("red") {
        face(select(tower_points, [2, 1, 5, 6]), wood_thickness * -X);
    }

    // back
    color("green") {
        face(select(tower_points, [3, 2, 6, 7]), wood_thickness * Y);
    }

    // left
    color("red") {
        face(select(tower_points, [0, 3, 7, 4]), wood_thickness * X);
    }
}
