include <lego_brick_builder.scad>

$fn=50;

STUDS_WIDTH=4;
STUDS_LENGTH=8;
STUDS_HEIGHT=6;

BODY_WIDTH=BRICK_WIDTH*STUDS_WIDTH;
BODY_LENGTH=BRICK_WIDTH*STUDS_LENGTH;
BODY_HEIGHT=PLATE_HEIGHT*STUDS_HEIGHT;

WHEEL_RADIUS=10;

WHEELHOUSE_INSET=6;
WHEELHOUSE_RADIUS=WHEEL_RADIUS+1;

WHEELPIN_HEIGHT=2;
WHEELPIN_EXTRA=0.5;

MATERIAL_THICKNESS=WALL_THICKNESS;

module body() {
    difference() {
        brick(STUDS_WIDTH, STUDS_LENGTH, STUDS_HEIGHT);
        
        // Make room for wheel houses
        translate([0, WHEELHOUSE_RADIUS+WALL_THICKNESS])
        wheelhouse_hole();

        translate([0, BODY_LENGTH-WHEELHOUSE_RADIUS-WALL_THICKNESS])
        wheelhouse_hole();

        translate([BODY_WIDTH, WHEELHOUSE_RADIUS+WALL_THICKNESS])
        rotate([0, 0, 180])
        wheelhouse_hole();

        translate([BODY_WIDTH, BODY_LENGTH-WHEELHOUSE_RADIUS-WALL_THICKNESS])
        rotate([0, 0, 180])
        wheelhouse_hole();
    }
}

module wheelhouse_hole() {
    translate([0,0,WHEELPIN_HEIGHT])
    rotate([0,90,0])
    translate([0,0,-1])
    cylinder(
        r=WHEELHOUSE_RADIUS+WALL_THICKNESS, 
        h=WHEELHOUSE_INSET+WALL_THICKNESS+1);
}

module wheelhouse() {
    difference() {
        
        translate([0,0,WHEELPIN_HEIGHT])
        rotate([0,90,0])
        union() {
            difference() {
                cylinder(
                    r=WHEELHOUSE_RADIUS+WALL_THICKNESS, 
                    h=WHEELHOUSE_INSET+WALL_THICKNESS);
                translate([0,0,-1])
                cylinder(
                    r=WHEELHOUSE_RADIUS, 
                    h=WHEELHOUSE_INSET+1);
            }
            
            // PIN            
            difference() {
                union() {
                    cylinder(
                        r=WHEELPIN_HEIGHT,
                        h=WHEELHOUSE_INSET);
                    cylinder(
                        r1=WHEELPIN_HEIGHT,
                        r2=WHEELPIN_HEIGHT+WHEELPIN_EXTRA,
                        h=1);
                }
                
                translate([-WHEELPIN_HEIGHT, -WHEELPIN_HEIGHT/4/2, 0])
                cube([WHEELPIN_HEIGHT*2, WHEELPIN_HEIGHT/4, 2]);

                translate([-100-WHEELPIN_HEIGHT, -50, 0])
                cube([100,100,100]);
            }
        }
        
        translate([-50,-50,-100])
        cube([100,100,100]);
    }
}

body();

translate([0, WHEELHOUSE_RADIUS+WALL_THICKNESS])
wheelhouse();

translate([0, BODY_LENGTH-WHEELHOUSE_RADIUS-WALL_THICKNESS])
wheelhouse();

translate([BODY_WIDTH, WHEELHOUSE_RADIUS+WALL_THICKNESS])
rotate([0, 0, 180])
wheelhouse();

translate([BODY_WIDTH, BODY_LENGTH-WHEELHOUSE_RADIUS-WALL_THICKNESS])
rotate([0, 0, 180])
wheelhouse();

