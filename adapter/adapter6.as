// AngelCAD code.

shape@ main_shape()
{
   solid@ c = cylinder(r:8,h:5,center:true) - cylinder(r:2.5,h:10,center:true);
   
   solid@ part = c;
   
   for(uint i=0; i<3; i++)
   {
      @part = part + translate(20*(i+1),0,0)*c;
   }
   
   return part;
}

void main()
{
   shape@ obj = main_shape();
   obj.write_xcsg(GetInputFullPath(),secant_tolerance:-0.02);
}
