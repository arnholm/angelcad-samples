// AngelCAD code.

solid@ ellipseA()
{
   solid@ leg = cylinder(r:3,h:4.5);
   double dx = 38.0/2;
   double dy = 39.0/2;
   solid@ c1  = hull3d(translate(-dx,dy,0)*leg,translate(dx,-dy,0)*leg);
   solid@ c2  = hull3d(translate(-dx,-dy,0)*leg,translate(dx,+dy,0)*leg);
   solid@ box = translate(-dx,-dy,0)*cuboid(2*dx,2*dy,24);
   return box+c1+c2;
}

solid@ hinge()
{
   solid@ h = rotate_x(deg:90)*(cylinder(r:3.5,h:50,center:true) - cylinder(r:2,h:100,center:true));
   return h;
}

solid@ pointer()
{
   return linear_extrude(polygon(pos2d(0,-10),pos2d(0,+10),pos2d(-25,0)),0.6);
}

solid@ trim_hinge()
{
   return rotate_x(deg:90)*cylinder(r:6,h:10,center:true);
}

shape@ main_shape()
{
    solid@ plate = cone(r1:20.0,r2:35,h:30)
                 - translate(0,0,70)*rotate_y(deg:-18)*cube(100,center:true)
                 + pointer()
                 + rotate_z(deg:90)*pointer()
                 + rotate_z(deg:180)*pointer()
                 + rotate_z(deg:270)*pointer()
                 - translate(0,0,-10)*cylinder(r:4.8,h:100)
                 + translate(0,0,+10)*cylinder(r:5.2,h:3)
                 - translate(0,0,1.0)*cylinder(r:2.0,h:50.0)
                 + translate(20,0,26.5)*hinge()
                 - translate(20,-25.5,26.5)*trim_hinge()
                 - translate(20,+25.5,26.5)*trim_hinge()
                 ;
                 
    return plate + translate(0,0,40)*ellipseA();
}

void main()
{
   shape@ obj = main_shape();
   obj.write_xcsg(GetInputFullPath(),secant_tolerance:0.005);
}
