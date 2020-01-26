// AngelCAD code.

shape@ main_shape()
{
    solid@ plate = cylinder(r:30.0,h:1.2) 
                 + translate(0,0,0.5)*cylinder(r:4.6,h:10.5)
                 - translate(0,0,1.0)*cylinder(r:2.0,h:20.0);
        
    return plate;
}

void main()
{
   shape@ obj = main_shape();
   obj.write_xcsg(GetInputFullPath(),secant_tolerance:0.02);
}
