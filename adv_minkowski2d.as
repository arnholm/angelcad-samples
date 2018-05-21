// AngelCAD code.

shape@ main_shape()
{
   // create a rounded rectangle using 2d minkowski
   
   // object a represents the 'path'
   shape2d@ path  = rectangle(dx:200,dy:100,center:true);
   
   // object b represents the 'brush'
   shape2d@ brush = circle(r:20);
   
   // move the 'brush' along the 'path'
   return minkowski2d(a:path,b:brush);
}

void main()
{
   shape@ obj = main_shape();
   obj.write_xcsg(GetInputFullPath(),secant_tolerance:-1.0);
}
