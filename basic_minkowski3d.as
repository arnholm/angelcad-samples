// AngelCAD code.
// Illustrate minkowski rounding of solid c, using a sphere

shape@ main_shape()
{
   solid@ c = rotate_x(deg:30)*cuboid(20,20,5);
   solid@ s = sphere(r:2);
   
   return minkowski3d(c,s);
}

void main()
{
   shape@ obj = main_shape();
   obj.write_xcsg(GetInputFullPath(),secant_tolerance:0.003);
}
