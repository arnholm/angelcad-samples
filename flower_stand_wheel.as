// AngelCAD sample: flower_stand_wheel.as
// Wheel for flower stand https://www.thingiverse.com/thing:3114292

shape@ main_shape()
{
   double ri =22.0;  // inner radius of wheel cover
   double th = 2.0;  // thickness of weel cover
   double ro =ri+th; // outer radius of wheel cover
   double h1 = 30.0; // width of wheel cover
   double h2 = 11.0; // Width of center wheel separator
   
   // create the main body as difference between outer and inner cylinders
   // rotate around x to get proper orientation, centered on origin.
   solid@ cyl_o  = cylinder(r:ro,h:h1);
   solid@ cyl_i1 = translate(0,0,(h1+h2)*0.5)*cylinder(r:ri,h:h1);
   solid@ cyl_i2 = translate(0,0,-(h1+h2)*0.5)*cylinder(r:ri,h:h1);
   solid@ wheel  = translate(0,h1*0.5,0)*rotate_x(deg:90)*(cyl_o - (cyl_i1+cyl_i2)); 

   // cylinders to create vertical piece to connect to flower stand
   solid@ cylv_o  = cylinder(r:h2*0.5-0.1,h:20);  // outer
   solid@ cylv_i  = cylinder(r:3.5,h:20);         // inner
   
   // integrate with wheel part by outer cylinder & subtract inner cylinder
   // use a named translation in the process
   tmatrix@ tcyl = translate(15.0,0,5.0);
   @wheel = wheel + tcyl*cylv_o - tcyl*translate(0,0,1)*cylv_i;
   
   // drill a hole for the wheel axle, then move the wheel part up
   // to prepare for removing bottom 
   @wheel = translate(0,0,7.0)*(wheel - rotate_x(deg:90)*cylinder(r:2.6,h:20,center:true));
   
   // remove part of wheel below z=0
   return wheel - translate(0,0,-250)*cube(500,center:true);
}

void main()
{
   shape@ obj = main_shape();
   obj.write_xcsg(GetInputFullPath(),secant_tolerance:-1);
}
