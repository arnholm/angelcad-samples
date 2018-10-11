// AngelCAD code.
// Illustrate minkowski rounding of concave object A

shape@ main_shape()
{  
   // create a concave polygon
   pos2d@[] p = {
       pos2d(0,100)
     , pos2d(100,100)
     , pos2d(100,0)
     , pos2d(200,0)
     , pos2d(200,200)
     , pos2d(0,200)
   };
   polygon poly(p);
   
   // object A: extrude the polygon and place a cube on top
   double h_extr=50;
   solid@ A = linear_extrude(poly,h_extr) + translate(150,150,h_extr)*cube(h_extr);

   // object B: a sphere   
   solid@ B = sphere(r:15);
   
   // return 3d minkowski sum of A and B
   return minkowski3d(A,B);
}

void main()
{
   shape@ obj = main_shape();
   obj.write_xcsg(GetInputFullPath(),secant_tolerance:0.005);
}
