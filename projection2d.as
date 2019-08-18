// AngelCAD sample: projection2d.as
// Demonstrates simple projection from 3d to 2d

shape@ main_shape()
{ 
   // set extrude=true  to get an STL file 1/100 mm high
   // set extrude=false to get 2d DXF and/or SVG
   bool extrude=true; 
   
   solid@ cyl    = rotate_y(deg:30)*cylinder(r:30,h:100);
   shape2d@ proj = projection2d(cyl);

   if(extrude) return linear_extrude(proj,0.01);
   else        return proj;
}

void main()
{
   shape@ obj = main_shape();
   obj.write_xcsg(GetInputFullPath(),secant_tolerance:-1.0);
}
