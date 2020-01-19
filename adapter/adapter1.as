// AngelCAD code.

shape@ main_shape()
{
    solid@ plate = cylinder(r:100.0/2,h:1.2) - cylinder(r:5,h:10,center:true);
    
    solid@ dowel_pin = translate(82.0/2,0,0.1)*cylinder(r:4.9/2,h:3.3);
    solid@ m4_screw = translate(70.0/2,0,0.1)*cylinder(r:4.0/2,h:3.3,center:true);
    for(uint i=0; i<4; i++) {
       double angle1 = 90*i;
       @plate = plate + rotate_z(deg:angle1)*dowel_pin;
       
       double angle2 = 45 + angle1;
       @plate = plate - rotate_z(deg:angle2)*m4_screw;
    }
    
    
    return plate;
}

void main()
{
   shape@ obj = main_shape();
   obj.write_xcsg(GetInputFullPath(),secant_tolerance:0.03);
}
