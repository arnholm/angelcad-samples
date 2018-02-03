// AngelCAD code.

shape@ main_shape()
{
   pos2d@[] points = 
   {  pos2d(0,0),     // 1
      pos2d(0,30),    // 2
      pos2d(10,100),  // 3
      pos2d(100,150), // 4
      pos2d(190,100), // 5
      pos2d(100,50),  // 6
      pos2d(130,0)    // 7
   };

   // create an ordinary polygon from the points	 
   polygon@ s1 = polygon(points);

   // add the first point as the last so that the spline ends where it started.
   points.push_back(points[0]);

   // create a polygon from the spline through the points, using 100 segments
   polygon@ s2 = polygon(spline2d(points),nseg:100);

   // compute the areas
   cout << "The area of the straight polygon = " << s1.area() << "\n";
   cout << "The area of the spline polygon   = " << s2.area() << "\n";
						 
   // layout the polygone side by side
	shape2d@ myshape = union2d(s1,translate(200,0)*s2);

   bool STL=true;  // change to false to create DXF
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
