// AngelCAD code sample: csg_wikipedia.as
// https://en.wikipedia.org/wiki/Constructive_solid_geometry
// https://arnholm.github.io/angelcad-docs/

shape@ main_shape()
{
   // intersection of cube and sphere
   cube@       cu = cube(size:45,center:true);
   sphere@     sp = sphere(r:30);
   solid@    cusp = cu & sp;     // '&' = intersection

   // union of 3 cylinders
   cylinder@  cy1 = cylinder(r:17,h:60,center:true);
   solid@     cy2 = rotate_x(deg:90)*cy1;
   solid@     cy3 = rotate_y(deg:90)*cy1; 
   solid@ cyl_all = cy1+cy2+cy3; // '+' = union

   // difference of the 2 above
   return cusp - cyl_all;        // '-' = difference
}

void main()
{
   shape@ obj = main_shape();
   obj.write_xcsg(GetInputFullPath(),secant_tolerance:-1);
}
