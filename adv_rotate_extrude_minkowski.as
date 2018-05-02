// AngelCAD sample: basic_rotate_extrude.as
// Illustrate rotate extrude operation with minkowski rounding

shape@ main_shape()
{
   shape2d@ profile = translate(100,0)*square(25);
   solid@ original = rotate_extrude(profile,deg:135);
   return minkowski3d(original,sphere(5));
}

void main()
{
   shape@ obj = main_shape();
   obj.write_xcsg(GetInputFullPath(),secant_tolerance:0.03);
}
