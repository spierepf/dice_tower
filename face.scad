function extrude(points, amount) = [
    for(point = points) point + amount
];

function convolve(n) =
    concat([
            [for(i=[0:1:n-1])i],
            [for(i=[n-1:-1:0])i+n]
        ],
        [for(i=[0:1:n-1])
            [(i+1)%n, i, n+i, n+(i+1)%n]
        ]
    );

module face(points, vector) {
    polyhedron(
        concat(points, extrude(points, vector)),
        convolve(len(points))
    );
}
