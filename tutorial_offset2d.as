// AngelCAD sample: basic_offset_2d.as
// demonstrate ofsetting of 2d shapes
// creating rounding and chamfers

shape@ main_shape()
{
   // first create a concave polygon from an array of points
   // note that the points must be listed counter-clockwise (CCW)
   pos2d@[] points = 
   {
      pos2d( 0.0, 0.0)
     ,pos2d(20.0, 0.0)
     ,pos2d(20.0,20.0)
     ,pos2d(10.0, 6.0)
     ,pos2d( 0.0,30.0)
   };
   shape2d@ p  = polygon(points);

   // put offset copies of the polygin into the "profiles" array
   shape2d@[] profiles;
   profiles.push_back(p);  // original, unmodified polygon

   int i=0;
   // specify radius to offset outwards with rounded convex corners
   profiles.push_back(translate(++i*35,0)*offset2d(p,r:1));
   
   // specify delta to create simple offset
   profiles.push_back(translate(++i*35,0)*offset2d(p,delta:1));

   // specify delta and chamfer=true to offset with convex corner chamfers
   profiles.push_back(translate(++i*35,0)*offset2d(p,delta:1,chamfer:true));

   // specify negative radius to offset inwards with rounded concave corners
   profiles.push_back(translate(++i*35,0)*offset2d(p,r:-1));

   // specify negative delta to offset inwards 
   profiles.push_back(translate(++i*35,0)*offset2d(p,delta:-1));

   // specify negative delta and chamfer=true to offset inwards with concave corner chamfers
   profiles.push_back(translate(++i*35,0)*offset2d(p,delta:-1,chamfer:true));

   // use offset2d twice with different radius signs to round both convex and concave corners
   profiles.push_back(translate(++i*35,0)*offset2d(offset2d(p,r:2),r:-1));

   shape2d@ myshape = union2d(profiles);

   bool STL=true;  // change to false to create DXF
   if(STL) {
      // STL requires 3d, so extrude in z-direction
      return translate(-30,0)*scale(0.25)*linear_extrude(myshape,height:3);
   }
   else {
      // alternatively, return as 2d object to create DXF file
      return myshape;
   }

}

void main()
{
   shape@ obj = main_shape();
   obj.write_xcsg(GetInputFullPath(),secant_tolerance:-1.0);
}
