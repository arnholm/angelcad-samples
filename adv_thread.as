// AngelCAD sample: adv_thread.as
// demonstrate use of rotate_extrude to create a thread.

shape@ main_shape()
{
   // define the CCW contour of a thread
   pos2d@[] points = {
                       pos2d(0,0),
                       pos2d(3,0),
                       pos2d(2,2),
                       pos2d(1.5,2.2),
                       pos2d(1,2)
                     };

   // create a polugon from the points, 
   // and position the resulting profile on the positive x-axis
   shape2d@ poly = translate(10,0)*rotate_z(deg:-90)*polygon(points);

   // perform 5 full rotations, with s small pitch to offset the threads
   return rotate_extrude(poly,deg:360*5,pitch:3.1);
}

void main()
{
   shape@ obj = main_shape();
   obj.write_xcsg(GetInputFullPath(),secant_tolerance:-1.0);
}
