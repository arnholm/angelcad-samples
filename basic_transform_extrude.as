// AngelCAD sample: basic_transform_extrude.as
// demonstrate the transform_extrude operation.
// Similar to linear_extrude, but transitioning 
// from one profile to another.

shape@ main_shape()
{
  // create a rounded square and a circle to use as profiles
  double side = 20;
  shape2d@ s1 = offset2d(square(side,center:true),r:3);
  shape2d@ s2 = circle(0.3*side*sqrt(2.0));
  
  // extrude from s1 to a translated copy of s2
  // the transformation of s2 must be reasonable,
  // typically a straight translation in z-direction
  return transform_extrude(s1,translate(0,0,side)*s2);
}

void main()
{
   shape@ obj = main_shape();
   // set the secant tolerance to obtain a detailed mesh
   obj.write_xcsg(GetInputFullPath(),secant_tolerance:0.005);
}
