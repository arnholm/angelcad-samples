// AngelCAD code.

shape@ main_shape()
{
   double sz = 50;
   
   // create a rounded rectangle using 2d minkowski
   
   // object a represents the 'path'
   shape2d@ path  = rectangle(dx:sz,dy:sz*0.5,center:true);
   
   // object b represents the 'brush'
   shape2d@ brush = circle(r:sz/10);
   
   // move the 'brush' along the 'path'
   shape2d@ myshape= minkowski2d(a:path,b:brush);
   
   bool STL=true;  // change to false to create DXF
   if(STL) {
      // STL requires 3d, so extrude in z-direction
      return linear_extrude(myshape,height:sz*0.1);
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
