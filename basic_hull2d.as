// AngelCAD sample: basic_hull2d.as
// demonstrate the hull2d operation
// it creates the convex hull of any number of 2d objects

shape@ main_shape()
{
   // create the hull of 2 circles of 
   // different sizes, one offset from origin
   shape2d@ c1      = circle(50);
   shape2d@ c2      = translate(40,50)*circle(25);
   shape2d@ myshape = hull2d(c1,c2);

   bool STL=false;  // change to false to create DXF
   if(STL) {
      // STL requires 3d, so extrude in z-direction
      return linear_extrude(myshape,height:3);
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
