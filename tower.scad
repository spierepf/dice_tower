include <geometry.scad>;
use <face.scad>;
use <list.scad>;
use <finger_joint.scad>;
use <chicane.scad>;

module chicanes(tower_height, tower_width, tower_depth, wood_thickness) {
    translate([0, 0, (9.0/5.0)*wood_thickness]) {
        chicane(
            wood_thickness + (3.0 / 4.0) * (tower_depth - (8.0 / 5.0) * wood_thickness),
            tower_width,
            tower_depth - (8.0 / 5.0) * wood_thickness,
            wood_thickness,
            true,
            5);
    }

    translate([0, (8.0/5.0)*wood_thickness, tower_height / 2 + (9.0/5.0)*wood_thickness]) {
        chicane(
            wood_thickness + (3.0 / 4.0) * (tower_depth - (8.0 / 5.0) * wood_thickness) / 2.0,
            tower_width,
            (tower_depth - (8.0 / 5.0) * wood_thickness) / 2.0,
            wood_thickness,
            false,
            3);
    }
}
module tower(tower_height, tower_width, tower_depth, wood_thickness) {
    tower_points = [
        [0,             0,                                          0],                 // 0  bottom front left
        [tower_width,   0,                                          0],                 // 1  bottom front right
        [tower_width,   tower_depth,                                0],                 // 2  bottom back right
        [0,             tower_depth,                                0],                 // 3  bottom back left
        [0,             0,                                          tower_depth],       // 4  middle front left
        [tower_width,   0,                                          tower_depth],       // 5  middle front right
        [0,             0,                                          tower_height],      // 6  top front left
        [tower_width,   0,                                          tower_height],      // 7  top front right
        [tower_width,   tower_depth,                                tower_height],      // 8  top back right
        [0,             tower_depth,                                tower_height],      // 9  top back left
    ];

    // bottom
    color("blue") {
        face(edge_concat([
            select(tower_points, [0, 1]),
            finger_joint_ends_out(select(tower_points, [1, 2]), Z, wood_thickness, 5),
            finger_joint_ends_out(select(tower_points, [2, 3]), Z, wood_thickness, 7),
            finger_joint_ends_out(select(tower_points, [3, 0]), Z, wood_thickness, 5)
        ]), wood_thickness * Z);
    }

    // front
    color("green") {
        face(edge_concat([
            select(tower_points, [5, 4]),
            finger_joint_ends_out(select(tower_points, [4, 6]), Y, wood_thickness, 7),
            select(tower_points, [6, 7]),
            finger_joint_ends_out(select(tower_points, [7, 5]), Y, wood_thickness, 7)
        ]), wood_thickness * Y);
    }

    // right
    color("red") {
        difference() {
            face(edge_concat([
                finger_joint_ends_in(select(tower_points, [2, 1]), -X, wood_thickness, 5),
                shorten_lead_end(select(tower_points, [1, 5]), -X, wood_thickness),
                finger_joint_ends_in(select(tower_points, [5, 7]), -X, wood_thickness, 7),
                shorten_lead_end(select(tower_points, [7, 8]), -X, wood_thickness),
                finger_joint_ends_out(shorten_tail_end(select(tower_points, [8, 2]), -X, wood_thickness), -X, wood_thickness, 11)
            ]), wood_thickness * -X);

            translate([-0.0005, 0, 0]) {
                chicanes(tower_height, tower_width+0.001, tower_depth, wood_thickness+0.0005);
            }
        }
    }

    // back
    color("green") {
        face(edge_concat([
            finger_joint_ends_in(select(tower_points, [3, 2]), -Y, wood_thickness, 7),
            finger_joint_ends_in(shorten_lead_end(select(tower_points, [2, 8]), -Y, wood_thickness), -Y, wood_thickness, 11),
            shorten_both_ends(select(tower_points, [8, 9]), -Y, wood_thickness),
            finger_joint_ends_in(shorten_tail_end(select(tower_points, [9, 3]), -Y, wood_thickness), -Y, wood_thickness, 11)
        ]), wood_thickness * -Y);
    }

    // left
    color("red") {
        difference() {
            face(edge_concat([
                finger_joint_ends_in(select(tower_points, [0, 3]), X, wood_thickness, 5),
                finger_joint_ends_out(shorten_lead_end(select(tower_points, [3, 9]), X, wood_thickness), X, wood_thickness, 11),
                shorten_tail_end(select(tower_points, [9, 6]), X, wood_thickness),
                finger_joint_ends_in(select(tower_points, [6, 4]), X, wood_thickness, 7),
                shorten_tail_end(select(tower_points, [4, 0]), X, wood_thickness)
            ]), wood_thickness * X);

            translate([-0.0005, 0, 0]) {
                chicanes(tower_height, tower_width+0.001, tower_depth, wood_thickness+0.0005);
            }
        }
    }

    color("yellow") {
        chicanes(tower_height, tower_width, tower_depth, wood_thickness);
    }
}
