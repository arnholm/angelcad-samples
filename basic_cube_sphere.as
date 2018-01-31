// AngelCAD sample: basic_cube_sphere.as

shape@ main_shape()
{
   // create cube & sphere in default positions
   double d = 100;
   solid@ mycub = cube(size:d);
   solid@ mysph = sphere(r:d*0.8);

   // move the sphere in z-direction and subtract from cube
   return mycub - translate(0,0,d)*mysph;
}

void main()
{
   shape@ obj = main_shape();
   obj.write_xcsg(GetInputFullPath(),secant_tolerance:0.02);
}
