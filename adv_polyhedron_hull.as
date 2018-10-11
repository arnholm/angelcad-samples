// AngelCAD sample: adv_polyhedron_hull.as
// construct convex hull from point cloud by
// constructing polyhedron with points only

shape@ main_shape()
{
   double radius = 100.0;

   // array to contain point cloud
   pos3d@[] points;

   // compute point cloud on an approximate sphere.
   // In this case, all points lie on the surface,
   // but this is not a requirement.
   // the ordering of the points is also arbitrary
   for(double alpha=-PI/2; alpha<=PI/2; alpha+=0.2) {
      double z = radius*sin(alpha);
      for(double beta=0; beta<2*PI; beta+=0.2) {
         double x = radius*cos(alpha)*cos(beta);
         double y = radius*cos(alpha)*sin(beta);
         points.push_back(pos3d(x,y,z));
      }
   }

   // compute the convex hull defined by the point cloud
   // represented as a polyhedron. The faces are automatic.
   return polyhedron(points);
}

void main()
{
   shape@ obj = main_shape();
   obj.write_xcsg(GetInputFullPath(),secant_tolerance:-1.0);
}
