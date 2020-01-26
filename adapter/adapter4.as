// AngelCAD code.

shape@ main_shape()
{
   double angle = 18.0; //degrees
   
   solid@ wedge = cuboid(42,30,25,center:true) 
                - translate(0,0,47.2)*rotate_y(deg:-angle)*cube(100,center:true)
                - translate(-65,0,0)*cube(100,center:true)
                - translate(29,0,0)*cuboid(20,21,100,center:true)
                ;
   
   return wedge;
}

void main()
{
   shape@ obj = main_shape();
   obj.write_xcsg(GetInputFullPath(),secant_tolerance:-1.0);
}
