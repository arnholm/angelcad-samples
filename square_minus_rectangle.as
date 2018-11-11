// AngelCAD sample: square_minus_rectangle.as
// boolean difference operation in 2D,
// make a square with rectangular hole

shape@ main_shape()
{
   double sz=50;
   shape2d@ a = square(size:sz,center:true);
   shape2d@ b = rectangle(dx:sz*0.8,dy:sz*0.5,center:true);
   shape2d@ myshape = a - b;  // or: difference2d(a,b);

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
   obj.write_xcsg(GetInputFullPath(),secant_tolerance:-1);
}
