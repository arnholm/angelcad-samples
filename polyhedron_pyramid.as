// AngelCAD sample: basic_polyhedron.as
// Build a polyhedron with a square base from scratch. 

shape@ main_shape()
{
   double sz = 25;
   
   // the 4 apex ponts
   pos3d@[] points = 
   { 
      pos3d(+sz,+sz,  0), 
      pos3d(+sz,-sz,  0), 
      pos3d(-sz,-sz,  0), 
      pos3d(-sz,+sz,  0), 
      pos3d(  0,  0,+sz)  // top point
   };

	// a pface is a polygon face. 
   // It refers to the vertices array using 0-based indices
   // a pface must list the vertices in CCW order, as seen from outside the polyhedron

   pface@[] faces = 
   {
      pface(1,0,4), pface(0,3,4), pface(3,2,4), pface(2,1,4), // side triangle faces
      pface(0,1,2,3) // bottom square face. 
   };

   // create the polyhedron
   polyhedron@ p = polyhedron(points,faces);

   // perform a simple test on the faces
   // a) the vertex indices exist
   // b) the faces are not collapsed
   // c) the polyhedron volume is > 0.0
   // note that individual faces with wrong face normal is not detected by this check
   p.verify();

	return p;
}

void main()
{
   shape@ obj = main_shape();
   obj.write_xcsg(GetInputFullPath(),secant_tolerance:-1.0);
}
