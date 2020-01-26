// AngelCAD code.

solid@ wedge(double dang)
{
   double angle = 18.0 + dang; //degrees
   
   solid@ w = cuboid(42,30,25,center:true) 
                - translate(0,0,47.2)*rotate_y(deg:-angle)*cube(100,center:true)
                - translate(-62,0,0)*cube(100,center:true)
                - translate(29,0,0)*cuboid(20,26.5,100,center:true)
                ;
   
   return w;
}

shape@ main_shape()
{
   return     wedge(0.0) 
            + translate(0,1*40,0)*wedge(+5.0) 
            + translate(0,2*40,0)*wedge(-5.0);
}

void main()
{
   shape@ obj = main_shape();
   obj.write_xcsg(GetInputFullPath(),secant_tolerance:-1.0);
}
