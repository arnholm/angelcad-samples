// AngelCAD sample: initlist.as
// Demonstrates use of initialization lists for pos2d/3d and vec2d/3d

shape@ main_shape()
{
   pos3d@  p = { 10.0, 1.0, 4.0 };
   vec3d@ p2 = { -2, -1 , 2};
   vec2d@ p3 = { 0, 1};
   
   array<pos3d@> parr = { {-10,-10, 0}
                          ,{10,-10, 0}
                          ,{10, 10, 0}
                         , {10, 10,10}};
                          
   cout << p2.x() << ' ' << p2.y() <<  endl;
   
   return polyhedron(parr);
}

void main()
{
   shape@ obj = main_shape();
   obj.write_xcsg(GetInputFullPath(),secant_tolerance:-1.0);
}
