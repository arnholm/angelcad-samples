// AngelCAD code.
// Illustrate minkowski rounding of object with hole
// resulting in rounding of outside and inside.

shape@ main_shape()
{
   double length = 25;
   double finger_pull_radius = 5;
   double thickness = 3;   
   
   // create a hull from a cylinder and a cuboid
   solid@ h1 = hull3d(
                 translate(length+finger_pull_radius, 0, 0)*cylinder(h:thickness, r:10,center:true)
               , cuboid(10,5,thickness,center:true)
              );
              
   // create another cylinder to make the hole shape
   solid@ c1 = translate(length+finger_pull_radius, 0, 0)*cylinder(h:thickness+0.01,r:5,center:true); 
   
   // subtract the hole and run minkowski on the result
   return minkowski3d(h1-c1,sphere(r:1));
}

void main()
{
   shape@ obj = main_shape();
   obj.write_xcsg(GetInputFullPath(),secant_tolerance:-0.001);
}
