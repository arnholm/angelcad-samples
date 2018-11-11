// AngelCAD sample: cuboid_mirror.as
// Illustrate mirror transform

shape@ main_shape()
{
   double sz = 40;
   // create a cuboid and position it
   solid@ s1 =  rotate_z(deg:30)    // rotate 30 degrees around z
               *translate(sz*0.5,0,0)  // translate 50 units in x-direction
               *cuboid(dx:sz,dy:sz*0.5,dz:sz*0.2);

   // union the cuboid with a mirror of itself
   // around yz-plane (normal vector (1,0,0))
   return s1 + mirror(1,0,0)*s1;
}

void main()
{
   shape@ obj = main_shape();
   obj.write_xcsg(GetInputFullPath(),secant_tolerance:-1);
}
