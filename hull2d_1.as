// AngelCAD sample: hull2d_1.as
// demonstrate the hull2d operation
// it creates the convex hull of any number of 2d objects

shape@ main_shape()
{
   double radius = 25;
   // create the hull of 2 circles of 
   // different sizes, one offset from origin
   shape2d@ c1      = circle(radius);
   shape2d@ c2      = translate(radius*0.8,radius)*circle(radius*0.5);
   shape2d@ myshape = hull2d(c1,c2);

   bool STL=true;  // change to false to create DXF
   if(STL) {
      // STL requires 3d, so extrude in z-direction
      return linear_extrude(myshape,height:radius*0.1);
   }
   else {
      // alternatively, return as 2d object to create DXF file
      return myshape;
   }
}

void main()
{
   shape@ obj = main_shape();
   obj.write_xcsg(GetInputFullPath(),secant_tolerance:-1.0);
}
