// AngelCAD sample: polyhedron_from_points.as
// construct convex hull from point cloud by
// constructing polyhedron with points only

shape@ main_shape()
{
   // compute point cloud on an approximate sphere.
   // In this case all points lie on the surface,
   // but this is not a requirement.
   // The ordering of points is arbitrary

   double radius = 30.0; // radius of a sphere
   array<pos3d@> points; // array to contain point cloud

   for(double alpha=-PI/2; alpha<=PI/2; alpha+=0.2) {
      double z = radius*sin(alpha);
      for(double beta=0; beta<2*PI; beta+=0.2) {
         double x = radius*cos(alpha)*cos(beta);
         double y = radius*cos(alpha)*sin(beta);
         
         // add the point to the back of the array
         points.push_back(pos3d(x,y,z));
      }
   }

   // convex hull polyhedron defined by the point cloud
   return polyhedron(points);
}

void main()
{
   shape@ obj = main_shape();
   obj.write_xcsg(GetInputFullPath(),secant_tolerance:-1.0);
}
