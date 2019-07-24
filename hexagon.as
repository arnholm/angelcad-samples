// AngelCAD sample: hexagon.as
// create simple hexagon by extruding 6 sided polygon

shape@ main_shape()
{
   return linear_extrude(polygon(r:20,np:6),height:20);
}

void main()
{
   shape@ obj = main_shape();
   obj.write_xcsg(GetInputFullPath(),secant_tolerance:-1.0);
}
