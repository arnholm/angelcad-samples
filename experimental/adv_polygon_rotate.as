// AngelCAD sample: adv_polygon_rotate.as
// This sample demonstrates
// - using arrays, polygon, bounding box
// - how to retrieve vertex information from a polygon
// - how to transform a position
// - how to use output stream to log information
// - how to rotate a polygon to minimise the bounding box area

shape@ main_shape()
{
   // original polygon with  arbitrary shape and orientation
   polygon@ p = polygon(array<pos2d@> = {pos2d(0,10),pos2d(80,-35),pos2d(120,45),pos2d(40,110)} );

   double area_min  = 1E12; // init to a large value
   double angle_opt = 0.0;  // to contain optimal rotation angle
   polygon@ p_opt   = null; // to contain optimal polygon

   // find orientation with minimal bounding box area
   for(double angle=0.0; angle<90.0; angle+=1) {

      // rotation matrix
      tmatrix@ t = rotate_z(deg:angle);

      // transform polygon points
      pos2d@[] tpos(p.size());
      for(uint i=0; i<p.size(); i++) @tpos[i] = t*p.vertex(i);

      // rotated polygon & bounding box
      polygon@     tp = polygon(tpos);
      boundingbox@  b = tp.box();

      // area of the bounding box
      double area = b.dx()*b.dy();
      if(area < area_min) {
         area_min  = area;
         angle_opt = angle;
         @p_opt    = tp;
      }
   }
   
   cout << "Most optimal polygon rotation= " << angle_opt << "deg.\n";
   cout << "optimal polygon: ";
   for(uint i=0; i<p_opt.size(); i++) {
      pos2d@ v = p_opt.vertex(i);
      cout << "\n(" << v.x() << ',' << v.y() << ")";
   }
   cout << "\n";

   // Y-align the roginal & rotatet polygons to illustrate
   double dx = p.box().dx()*1.25;
   double dy = p.box().p1().y() - p_opt.box().p1().y();
   
   return p + translate(dx,dy)*p_opt;
}

void main()
{
   shape@ obj = main_shape();
   obj.write_xcsg(GetInputFullPath(),secant_tolerance:-1.0);
}
