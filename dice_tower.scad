X = [1, 0, 0];
Y = [0, 1, 0];
Z = [0, 0, 1];

function cat(L1, L2) = [for (i=[0:len(L1)+len(L2)-1]) 
                        i < len(L1)? L1[i] : L2[i-len(L1)]] ;

function select(vector,indices) = [ for (index = indices) vector[index] ];

function extrude(points, amount) = [
    for(point = points) point + amount
];

function convolve(n) =
    cat([
            [for(i=[0:1:n-1])i],
            [for(i=[n-1:-1:0])i+n]
        ],
        [for(i=[0:1:n-1])
            [(i+1)%n, i, n+i, n+(i+1)%n]
        ]
    );

module face(points, vector) {
    polyhedron(
        cat(points, extrude(points, vector)),
        convolve(len(points))
    );
}

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