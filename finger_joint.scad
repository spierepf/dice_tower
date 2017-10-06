use <list.scad>

function distance(p1, p2) = sqrt(sum([for(w=p2-p1)w*w]));
function unit(v) = v / distance([0, 0, 0], v);
function forward(p1, p2) = unit(p2-p1);
function inward(p1, p2, upward) = cross(upward, forward(p1, p2));

function edge_concat(l) = [
    for (i = [0 : 1 : len(l)-1])
        let(j = (i + len(l)-1) % len(l))
            for (b = (distance(last(l[j]), head(l[i])) < 0.00001) ? tail(l[i]) : l[i]) b
];

function finger_joint_ends_in(ends, upward, wood_thickness, count = 3) = 
    let(
        p1 = ends[0],
        p2 = ends[1],
        forward = forward(p1, p2),
        inward = inward(p1, p2, upward),
        segment = forward * distance(p1, p2) / count
    )
    edge_concat(
        [for(i = [0 : 1 : count-1])
            let(jag=inward*((i%2==0)?wood_thickness:0))
            [
                p1 + (i + 0) * segment + jag,
                p1 + (i + 1) * segment + jag
            ]
        ]
    );

function finger_joint_ends_out(ends, upward, wood_thickness, count = 3) = 
    let(
        p1 = ends[0],
        p2 = ends[1],
        forward = forward(p1, p2),
        inward = inward(p1, p2, upward),
        segment = forward * distance(p1, p2) / count
    )
    edge_concat(
        [for(i = [0 : 1 : count-1])
            let(jag=inward*((i%2!=0)?wood_thickness:0))
            [
                p1 + (i + 0) * segment + jag,
                p1 + (i + 1) * segment + jag
            ]
        ]
    );

function shorten_lead_end(ends, upward, wood_thickness) = [
    ends[0] + wood_thickness * forward(ends[0], ends[1]),
    ends[1]
];

function shorten_tail_end(ends, upward, wood_thickness) = [
    ends[0],
    ends[1] - wood_thickness * forward(ends[0], ends[1])
];

function shorten_both_ends(ends, upward, wood_thickness) = [
    ends[0] + wood_thickness * forward(ends[0], ends[1]),
    ends[1] - wood_thickness * forward(ends[0], ends[1])
];