// AngelCAD code.
// Wheel for flower stand https://www.thingiverse.com/thing:3114292

shape@ main_shape()
{
   double ri =22.0;  // inner radius
   double th = 2.0;
   double ro =ri+th;
   double h1 = 30.0;
   double h2 = 11.0;
   
   solid@ cyl_o  = cylinder(r:ro,h:h1);
   solid@ cyl_i1 = translate(0,0,(h1+h2)*0.5)*cylinder(r:ri,h:h1);
   solid@ cyl_i2 = translate(0,0,-(h1+h2)*0.5)*cylinder(r:ri,h:h1);
   
   // vertical cylinder
   solid@ cyl2   = cylinder(r:h2*0.5,h:20);
   solid@ cyl2b  = cylinder(r:3.5,h:20);
   
   solid@ wheel  = translate(0,h1*0.5,0)*rotate_x(deg:90)*(cyl_o - (cyl_i1+cyl_i2)); 
   
   tmatrix@ tcyl = translate(15.0,0,5.0);
   @wheel = wheel + tcyl*cyl2 - tcyl*translate(0,0,1)*cyl2b;
   @wheel = translate(0,0,7.0)*(wheel - rotate_x(deg:90)*cylinder(r:2.6,h:20,center:true));
      
   return wheel - translate(0,0,-250)*cube(500,center:true);
}

void main()
{
   shape@ obj = main_shape();
   obj.write_xcsg(GetInputFullPath(),secant_tolerance:-1.0);
}
