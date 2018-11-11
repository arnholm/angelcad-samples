// AngelCAD sample: basic_boolean_operators.as
// demonstrate use of operator overloading for booleans

shape@ main_shape()
{
   double size = 10;  // sphere radius & cube side length

   // given 2 solids a and b
   // a + b is equivalent to union3d(a,b)
   // a - b is equivalent to difference3d(a,b)
   // a & b is equivalent to intersection3d(a,b)

   solid@ object = sphere(r:size) + cube(size)                          // union
                 + translate(3*size,0,0)*(sphere(r:size) - cube(size))  // difference
                 + translate(5*size,0,0)*(sphere(r:size) & cube(size)); // intersection
   
   // center the result on origin
   pos3d@ c = object.box().center();
   return translate(-c.x(),-c.y(),-c.z())*object;
}

void main()
{
   shape@ obj = main_shape();
   obj.write_xcsg(GetInputFullPath(),secant_tolerance:0.01);
}
