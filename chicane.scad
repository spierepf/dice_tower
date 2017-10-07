use <face.scad>;
use <list.scad>;
use <finger_joint.scad>;

module chicane(height, width, depth, wood_thickness, front_facing, finger_count) {
    normal = unit([0, front_facing ? -height : height, depth]);

    points = [
        [0,     0,      front_facing ? 0 : height],    // 0 front left
        [width, 0,      front_facing ? 0 : height],    // 1 front right
        [width, depth,  front_facing ? height : 0],    // 2 back right
        [0,     depth,  front_facing ? height : 0]     // 3 back left
    ];

    face(edge_concat([
        finger_joint_ends_in(select(points, [0, 3]), -normal, wood_thickness, finger_count),
        shorten_both_ends(select(points, [3, 2]), -normal, wood_thickness),
        finger_joint_ends_in(select(points, [2, 1]), -normal, wood_thickness, finger_count),
        shorten_both_ends(select(points, [1, 0]), -normal, wood_thickness)
    ]), wood_thickness * -normal);
}
