// AngelCAD code.

solid@ ellipseA()
{
   solid@ leg = cylinder(r:3,h:4.5);
   double dx = 38.0/2;
   double dy = 39.0/2;
   solid@ c1  = hull3d(translate(-dx,dy,0)*leg,translate(dx,-dy,0)*leg);
   solid@ c2  = hull3d(translate(-dx,-dy,0)*leg,translate(dx,+dy,0)*leg);
   solid@ box = translate(-dx,-dy,0)*cuboid(2*dx,2*dy,24);
   
   solid@ hole = cylinder(r:3.8/2, h:15,center:true);
   solid@ holes = translate(-dx,-dy,0)*hole
                + translate(+dx,-dy,0)*hole
                + translate(+dx,+dy,0)*hole
                + translate(-dx,+dy,0)*hole;
   
 //  return box+c1+c2 + mounting_plate() + holes;
 
   // for mounting plate only
   return mounting_plate() - holes - translate(-5,5.5,0)*rotate_z(deg:-5)*holes;
}

solid@ mounting_plate()
{
   solid@ plate = translate(-2.5,0,0)*cuboid(55,60,3,center:true) - translate(43,0,0)*cuboid(42,43,100,center:true);
   
   solid@ h = translate(0,0,-2.1)*rotate_x(deg:90)*(cylinder(r:4,h:8,center:true) - cylinder(r:2.2,h:100,center:true));
   
   double dx = 2.2;
   return plate + translate(dx+25,26,-0.3)*h + translate(dx+25,-26,-0.3)*h;
}

solid@ hinge()
{
   solid@ h = rotate_x(deg:90)*(cylinder(r:3.5,h:50,center:true) - cylinder(r:2.1,h:100,center:true));
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
                 + translate(-20,0,12)*cuboid(3,25,3,center:true);
                 ;
  
    // 3A main adapter    
    return plate; 

    // 3B for mounting plate only           
    // return rotate_y(deg:180)*translate(-7.2,0,28.5)*ellipseA();
}

void main()
{
   shape@ obj = main_shape();
   obj.write_xcsg(GetInputFullPath(),secant_tolerance:0.005);
}
