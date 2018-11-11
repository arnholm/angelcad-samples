// AngelCAD sample: basic_rotate_extrude.as
// Illustrate rotate extrude operation

shape@ main_shape()
{
   // rotate extrude takes a 2d shape lying in the xy-plane
   // and rotates it around the global Y-axis.

   // Note that a positive rotation angle is is here CCW
   // as seen from a position on the negative y-axis

   // to perform a meaningful rotate_extrude, the profile must first 
   // be translated so that it is entirely on the positive x-axis

   // rotation angles can be specified in degrees (deg:) or radians (rad:)
   // if the angle specifies more than a full circle (and the pitch is zero),
   // the result will be a torus.

   shape2d@ profile = translate(100,0)*square(25);
   return scale(0.25)*rotate_extrude(profile,deg:135);
}

void main()
{
   shape@ obj = main_shape();
   obj.write_xcsg(GetInputFullPath(),secant_tolerance:-1.0);
}
