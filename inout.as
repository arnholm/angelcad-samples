// AngelCAD sample: inout.as
// Demonstrates use of output and input streams
// **** NOTE : This code cannot run in AngelCAD gui
//      instead run in console window: $ as_csg inout.as

shape@ main_shape()
{
// **** NOTE : This code cannot run in AngelCAD gui
//      instead run in console window: $ as_csg inout.as
   double radius = 10;
   cout << "Type cylinder radius followed by <ENTER>: ";
   cin >> radius;
   cout << "creating cylinder with radius = " << radius << endl;
   return cylinder(r:radius,h:100);
}

void main()
{
   shape@ obj = main_shape();
   obj.write_xcsg(GetInputFullPath(),secant_tolerance:-1.0);
}
