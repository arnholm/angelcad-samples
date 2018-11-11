// AngelCAD code.
// Illustrate minkowski rounding of solid c, using a sphere

shape@ main_shape()
{
   double sz=40;
   solid@ c = rotate_x(deg:30)*cuboid(sz,sz,sz*0.2,center:true);
   solid@ s = sphere(r:sz*0.1);
   
   return minkowski3d(c,s);
}

void main()
{
   shape@ obj = main_shape();
   obj.write_xcsg(GetInputFullPath(),secant_tolerance:0.01);
}
