// AngelCAD sample: basic_mirror.as
// Illustrate mirror transform

shape@ main_shape()
{
   // create a cuboid and position it
   solid@ s1 =  rotate_z(deg:30)    // rotate 30 degrees around z
               *translate(50,0,0)  // translate 50 units in x-direction
               *cuboid(dx:100,dy:50,dz:20);

   // union the cuboid with a mirror of itself
   // there the mirror plane is yz-plane (normal vector (1,0,0))
   return s1 + mirror(1,0,0)*s1;
}

void main()
{
   shape@ obj = main_shape();
   obj.write_xcsg(GetInputFullPath(),secant_tolerance:-1);
}
