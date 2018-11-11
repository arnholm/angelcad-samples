// AngelCAD sample: minkowski3d_2.as
// Illustrate minkowski rounding of concave object A

shape@ main_shape()
{  
   // create a concave polygon
   pos2d@[] p = {
       pos2d(-100,0)
     , pos2d(0,0)
     , pos2d(0,-100)
     , pos2d(100,-100)
     , pos2d(100,100)
     , pos2d(-100,100)
   };
   polygon poly(p);
   
   // object A: extrude the polygon and place a cube on top
   double h_extr=50;
   solid@ A = linear_extrude(poly,h_extr) + translate(50,50,h_extr)*cube(h_extr);

   // object B: a sphere   
   solid@ B = sphere(r:15);
   
   // comote 3d minkowski sum of A and B and scale down the reult
   return scale(0.2)*minkowski3d(A,B);
}

void main()
{
   shape@ obj = main_shape();
   obj.write_xcsg(GetInputFullPath(),secant_tolerance:0.05);
}
