// AngelCAD sample: vase_with_handle.as
// This example demonstrates use of sweep

solid@ vase_body()
{
   shape2d@ prof = circle(r:50) - circle(r:47);
   pos3d@[] p;
   vec3d@[] v;
   double dt = 10.0;
   double ds = 2*PI/20;
   for(uint i=0; i<20; i++) {
      p.push_back(pos3d(0,0,i*dt));              // straight line
      v.push_back(vec3d(1+0.5*sin(i*ds),0,0));   // sine curve radius
   }
   spline_path@ path = spline_path(p,v);
   return linear_extrude(circle(r:49),5)+sweep(prof,path);
}

solid@ vase_handle()
{
   // the handle is an ellipse swept along a spline path
   shape2d@ prof = scale(0.4,1)*circle(r:6);
   pos3d@[] p = {
        pos3d(-5,0,40)
      , pos3d(-10,0,50)
      , pos3d(-20,0,70)
      , pos3d(0,0,135)
      , pos3d(-5,0,145)
      , pos3d(-47.2,0,142)
      , pos3d(-52.2,0,120)
   };
   spline_path@ path = spline_path(p,vec3d(0,1,0));
   return translate(79.0,0,25)* sweep(prof,path);
}

shape@ main_shape()
{
   // scale down for web visualisation
   return scale(0.25)*(vase_body() + vase_handle());
}

void main()
{
   shape@ obj = main_shape();
   obj.write_xcsg(GetInputFullPath(),secant_tolerance:-1.0);
}
