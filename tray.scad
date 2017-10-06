include <geometry.scad>;
use <face.scad>;
use <list.scad>;
use <finger_joint.scad>;

module tray(tray_height, tray_width, tray_depth, wood_thickness) {
    tray_points = [
        [0,             0,                                                              0],                 // 0  bottom front left
        [tray_width,    0,                                                              0],                 // 1  bottom front right
        [tray_width,    tray_depth,                                                     0],                 // 2  bottom back right
        [0,             tray_depth,                                                     0],                 // 3  bottom back left
        [0,             0,                                                              tray_height/2.0],   // 4  top front left (low)
        [tray_width,    0,                                                              tray_height/2.0],   // 5  top front right (low)
        [tray_width,    0 + (tray_height - wood_thickness) + wood_thickness,            tray_height/2.0],   // 6  top middle right (low)
        [tray_width,    tray_depth - (tray_height - wood_thickness) - wood_thickness,   tray_height],       // 7  top middle right (high)
        [tray_width,    tray_depth,                                                     tray_height],       // 8  top back right (high)
        [0,             tray_depth,                                                     tray_height],       // 9  top back left (high)
        [0,             tray_depth - (tray_height - wood_thickness) - wood_thickness,   tray_height],       // 10 top middle left (high)
        [0,             0 + (tray_height - 1.0 * wood_thickness) + 2*wood_thickness,    tray_height/2.0],   // 11 top middle left (low)
    ];

    // bottom
    color("blue") {
        face(edge_concat([
            finger_joint_ends_out(select(tray_points, [0, 1]), Z, wood_thickness, 7),
            finger_joint_ends_out(select(tray_points, [1, 2]), Z, wood_thickness, 9),
            finger_joint_ends_out(select(tray_points, [2, 3]), Z, wood_thickness, 7),
            finger_joint_ends_out(select(tray_points, [3, 0]), Z, wood_thickness, 9)
        ]), wood_thickness * Z);
    }

    // front
    color("green") {
        face(edge_concat([
            finger_joint_ends_in(select(tray_points, [1, 0]), Y, wood_thickness, 7),
            finger_joint_ends_in(shorten_lead_end(select(tray_points, [0, 4]), Y, wood_thickness), Y, wood_thickness),
            shorten_both_ends(select(tray_points, [4, 5]), Y, wood_thickness),
            finger_joint_ends_in(shorten_tail_end(select(tray_points, [5, 1]), Y, wood_thickness), Y, wood_thickness),
        ]), wood_thickness * Y);
    }

    // right
    color("red") {
        face(edge_concat([
            finger_joint_ends_in(select(tray_points, [2, 1]), -X, wood_thickness, 9),
            finger_joint_ends_out(shorten_lead_end(select(tray_points, [1, 5]), -X, wood_thickness), -X, wood_thickness),
            select(tray_points, [5, 6]),
            select(tray_points, [6, 7]),
            select(tray_points, [7, 8]),
            finger_joint_ends_out(shorten_tail_end(select(tray_points, [8, 2]), -X, wood_thickness), -X, wood_thickness, 5)
        ]), wood_thickness * -X);
    }

    // back
    color("green") {
        face(edge_concat([
            finger_joint_ends_in(select(tray_points, [3, 2]), -Y, wood_thickness, 7),
            finger_joint_ends_in(shorten_lead_end(select(tray_points, [2, 8]), -Y, wood_thickness), -Y, wood_thickness, 5),
            shorten_both_ends(select(tray_points, [8, 9]), -Y, wood_thickness),
            finger_joint_ends_in(shorten_tail_end(select(tray_points, [9, 3]), -Y, wood_thickness), -Y, wood_thickness, 5)
        ]), wood_thickness * -Y);
    }

    // left
    color("red") {
        face(edge_concat([
            finger_joint_ends_in(select(tray_points, [0, 3]), X, wood_thickness, 9),
            finger_joint_ends_out(shorten_lead_end(select(tray_points, [3, 9]), X, wood_thickness), X, wood_thickness, 5),
            select(tray_points, [9, 10]),
            select(tray_points, [10, 11]),
            select(tray_points, [11, 4]),
            finger_joint_ends_out(shorten_tail_end(select(tray_points, [4, 0]), X, wood_thickness), X, wood_thickness)
        ]), wood_thickness * X);
    }
}
