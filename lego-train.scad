include <lego_brick_builder.scad>

$fn=50;

STUDS_WIDTH=4;
STUDS_LENGTH=8;
STUDS_HEIGHT=5;

BODY_WIDTH=BRICK_WIDTH*STUDS_WIDTH;
BODY_LENGTH=BRICK_WIDTH*STUDS_LENGTH;
BODY_HEIGHT=PLATE_HEIGHT*STUDS_HEIGHT;

WHEEL_RADIUS=10;

// http://bricks.stackexchange.com/questions/288/what-are-the-dimensions-of-a-lego-brick

WHEELPIN_HOLE_TOL=0.1;

WHEELPIN_LENGTH=BRICK_WIDTH;
WHEELPIN_HEIGHT=(3*1.6)/2 - WHEELPIN_HOLE_TOL;
WHEELPIN_EXTRA=(3.5*1.6)/2 - (3*1.6)/2;
WHEELPIN_EXTRA_LENGTH=0.55;

WHEELHOUSE_INSET=WHEELPIN_LENGTH;
WHEELHOUSE_RADIUS=WHEEL_RADIUS+1;

WHEELPIN_SLOT_THICKNESS=1.5;
WHEELPIN_SLOT_LENGTH=6;

MATERIAL_THICKNESS=WALL_THICKNESS;

module wheelhouse_hole() {
    translate([0,0,WHEELPIN_HEIGHT])
    rotate([0,90,0])
    translate([0,0,-1])
    cylinder(
        r=WHEELHOUSE_RADIUS, 
        h=WHEELHOUSE_INSET+1);
    translate([0,0,WHEELPIN_HEIGHT])
    rotate([0,90,0])
    translate([0,0,WALL_THICKNESS])
    cylinder(
        r=WHEELHOUSE_RADIUS+WALL_THICKNESS, 
        h=WHEELHOUSE_INSET);
}

module wheelhouse() {
    difference() {
        
        translate([0,0,WHEELPIN_HEIGHT])
        rotate([0,90,0])
        union() {
            difference() {
                translate([0,0,WALL_THICKNESS])
                cylinder(
                    r=WHEELHOUSE_RADIUS+WALL_THICKNESS, 
                    h=WHEELHOUSE_INSET);
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
                    translate([0,0,WHEELHOUSE_INSET-WHEELPIN_EXTRA_LENGTH])
                    cylinder(
                        r=WHEELPIN_HEIGHT+WHEELPIN_EXTRA,
                        h=WHEELPIN_EXTRA_LENGTH);
                    cylinder(
                        r=WHEELPIN_HEIGHT+WHEELPIN_EXTRA,
                        h=WHEELPIN_EXTRA_LENGTH);
                }
                
                translate([
                    -WHEELPIN_HEIGHT*2, 
                    -WHEELPIN_SLOT_THICKNESS/2, 
                    0])
                cube([
                    WHEELPIN_HEIGHT*4, 
                    WHEELPIN_SLOT_THICKNESS, 
                    WHEELPIN_SLOT_LENGTH]);

                translate([-100-WHEELPIN_HEIGHT, -50, 0])
                cube([100,100,100]);
            }
        }
        
        translate([-50,-50,-100])
        cube([100,100,100]);
    }
}

module body() {
    union() {
        difference() {
            brick(STUDS_WIDTH, STUDS_LENGTH, STUDS_HEIGHT);
            
            // Make room for wheel houses
            translate([
                0, 
                WHEELHOUSE_RADIUS+WALL_THICKNESS*2])
            wheelhouse_hole();

            translate([
                0, 
                BODY_LENGTH-WHEELHOUSE_RADIUS-WALL_THICKNESS*2])
            wheelhouse_hole();

            translate([
                BODY_WIDTH, 
                WHEELHOUSE_RADIUS+WALL_THICKNESS*2])
            rotate([0, 0, 180])
            wheelhouse_hole();

            translate([
                BODY_WIDTH, 
                BODY_LENGTH-WHEELHOUSE_RADIUS-WALL_THICKNESS*2])
            rotate([0, 0, 180])
            wheelhouse_hole();
        }
    
        // Add wheelhouses
        translate([
            0, 
            WHEELHOUSE_RADIUS+WALL_THICKNESS*2])
        wheelhouse();

        translate([
            0, 
            BODY_LENGTH-WHEELHOUSE_RADIUS-WALL_THICKNESS*2])
        wheelhouse();

        translate([
            BODY_WIDTH, 
            WHEELHOUSE_RADIUS+WALL_THICKNESS*2])
        rotate([0, 0, 180])
        wheelhouse();

        translate([
            BODY_WIDTH, 
            BODY_LENGTH-WHEELHOUSE_RADIUS-WALL_THICKNESS*2])
        rotate([0, 0, 180])
        wheelhouse();
    }
}

module wheelpin_hole() {
    cylinder(r=WHEELPIN_HEIGHT+WHEELPIN_HOLE_TOL, h=WHEELPIN_LENGTH);
    cylinder(r=WHEELPIN_HEIGHT+WHEELPIN_EXTRA+WHEELPIN_HOLE_TOL, h=WHEELPIN_EXTRA_LENGTH+WHEELPIN_HOLE_TOL);
    translate([0,0,WHEELPIN_LENGTH-WHEELPIN_EXTRA_LENGTH-WHEELPIN_HOLE_TOL])
    cylinder(r=WHEELPIN_HEIGHT+WHEELPIN_EXTRA+WHEELPIN_HOLE_TOL, h=WHEELPIN_EXTRA_LENGTH+WHEELPIN_HOLE_TOL);
}

module wheel() {
    difference() {
        cylinder(r=WHEEL_RADIUS, h=WHEELPIN_LENGTH);
        
        wheelpin_hole();
    }
}

body();

translate([-15,10,0])
wheel();

translate([-15,32,0])
wheel();

translate([-15,54,0])
wheel();

translate([-15,76,0])
wheel();

