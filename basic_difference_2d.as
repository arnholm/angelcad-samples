// AngelCAD sample: basic_difference_2d.as
// boolean difference operation in 2D,
// make a square with rectangular hole

shape@ main_shape()
{
   shape2d@ a = square(size:100);
   shape2d@ b = translate(dx:10,dy:25)*rectangle(dx:80,dy:50);
   shape2d@ myshape = a - b;  // or: difference2d(a,b);

   bool STL=true;  // change to false to create DXF
   if(STL) {
      // STL requires 3d, so extrude in z-direction
      return linear_extrude(myshape,height:10);
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
