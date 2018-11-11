// AngelCAD code sample: csg_wikipedia.as
// Modelled after https://en.wikipedia.org/wiki/Constructive_solid_geometry

shape@ main_shape()
{
   // intersection of cube and sphere
   cube@     cu = cube(size:45,center:true);
   sphere@   sp = sphere(r:30);
   solid@  cusp = cu & sp;                   // '&' : intersection

   // union of 3 cylinders
   cylinder@ cy = cylinder(r:17,h:50,center:true);
   solid@   cy2 = cy  + rotate_x(deg:90)*cy;
   solid@   cy3 = cy2 + rotate_y(deg:90)*cy; // '+' : union

   // difference of the 2 above
   return cusp - cy3;                        // '-' : difference
}

void main()
{
shape@ obj = main_shape();
obj.write_xcsg(GetInputFullPath(),secant_tolerance:0.01);
}
