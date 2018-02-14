// AngelCAD sample: basic_boolean_operators.as
// demonstrate use of operator overloading for booleans

shape@ main_shape()
{
   double size = 10;

   // given 2 solids a and b
   // a + b is equivalent to union3d(a,b)
   // a - b is equivalent to difference3d(a,b)
   // a & b is equivalent to intersection3d(a,b)

   return sphere(r:size) + cube(size)                          // union
        + translate(3*size,0,0)*(sphere(r:size) - cube(size))  // difference
        + translate(5*size,0,0)*(sphere(r:size) & cube(size)); // intersection
}

void main()
{
   shape@ obj = main_shape();
   obj.write_xcsg(GetInputFullPath(),secant_tolerance:0.01);
}
