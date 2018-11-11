// AngelCAD sample: basic_primitives_2d.as
// 2d primitives and how to transform them

shape@ main_shape()
{
   double sz = 5;
   
   // create some simple primitives, each centered at origin
   circle@ s1    = circle(r:sz);
   square@ s2    = square(size:sz,center:true);
   rectangle@ s3 = rectangle(dx:3*sz,dy:sz*1.5,center:true);
   polygon@ s4   = polygon(pos2d(-sz,-sz), pos2d(+sz,-sz), pos2d(0,+sz));

   // layout the shapes along the x-axis, store layout in "myshape".
   // To simplify layout, put the shapes in an array of 2d shapes
   shape2d@[] shapes = { s1, s2, s3, s4 } ;

   shape2d@ myshape = null;
   double offset_x  = 0;  // accumulated offset in x-direction
   double sep_x     = sz/5; // separation between shapes
   for(uint i=0; i<shapes.size(); i++) {
      if(i==0) {
         @myshape = shapes[i];
      }
      else {
         // Add to position offset from half of previous and current shape sizes
         // To do this we use the shape bounding boxes.
         offset_x += sep_x + 0.5*(shapes[i-1].box().dx() + shapes[i].box().dx());

         // translate the current shaope and add to "myshape".
         // Note that this is a boolean union.
         @myshape = myshape + translate(offset_x,0)*shapes[i];
      }
   }
   
   // center the result
   pos3d@ c = myshape.box().center();
   @myshape = translate(-c.x(),-c.y())*myshape;

   bool STL=true;  // change to false to create DXF
   if(STL) {
      // STL requires 3d, so extrude in z-direction
      return linear_extrude(myshape,height:sz/5);
   }
   else {
      // alternatively, return as 2d object to create DXF file
      return myshape;
   }
}

void main()
{
   shape@ obj = main_shape();
   obj.write_xcsg(GetInputFullPath(),secant_tolerance:-1);
}
