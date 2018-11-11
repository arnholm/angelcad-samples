// AngelCAD sample: basic_octahedron.as
// Illustrate creation and use of octahedron

solid@ octahedron(double size)
{
   // An octahedron is a convex object so it can be defined 
   // as a polyhedron simply through an array of octahedron vertices
   pos3d@[] p = 
   {
       pos3d(0,0,size)
      ,pos3d(+size,0,0)
      ,pos3d(0,+size,0)
      ,pos3d(-size,0,0)
      ,pos3d(0,-size,0)
      ,pos3d(0,0,-size)
   };
   return polyhedron(p);
}

shape@ main_shape()
{
   // intersect a cube with the octahedron to create a cube with trimmed corners
   
   double cornerwid = 10;
   double wid = 50;
   return octahedron(size:wid*sqrt(2)-cornerwid/2) & cube(size:wid,center:true);
}

void main()
{
   shape@ obj = main_shape();
   obj.write_xcsg(GetInputFullPath(),secant_tolerance:-1.0);
}
