// AngelCAD sample: iso_nut.as
// create an M16 hexagonal nut with inside threads

double to_rad(double deg) { return PI*deg/180.0; } // from degrees to radians
  
solid@ metric_hexagon(double G, double H, bool round=true)
{
   // for definition of G and H, see
   // http://www.fairburyfastener.com/xdims_metric_nuts.htm

   // G is the diameter of a circle into which 
   // the hexagon is inscribed. The length of one flat 
   // side on the hexagon is equal to the radius of the circle
   double dx = 0.5*G;

   // the length F (distance between opposite sides) 
   double F  = G*cos(to_rad(30));

   double dy = 0.5*F*tan(to_rad(30));
   pos2d@[] points = 
     {
        pos2d(1.0*F,dy),
        pos2d(1.0*F,G-dy),                   
        pos2d(0.5*F,G),                   
        pos2d(0.0*F,G-dy),                   
        pos2d(0.0*F,dy),                   
        pos2d(0.5*F,0) 
     };
   shape2d@ hex2 = scale(100)*translate(-F/2,-G/2)*polygon(points);

   solid@ hex = linear_extrude(hex2,100*H);

   if(round) {
      // trim the corners
      solid@ trim = scale(100)*cone(1.74*H,G,0);
      return scale(0.01)*intersection3d(hex,trim);
   }
   return scale(0.1)*hex;
}

class GH {
  GH() { G=0; H=0; }
  GH(double g, double h) { G=g; H=h; }
  double G; // diameter of a circle into which the hex is inscribed
  double H; // thickness of hexagon
};

GH get_dimensions(string name)
{
   // Lookup table for metric hex nuts (ISO 4032)
   dictionary ISO4032 = { 
                        { 'M2', GH( 4.32, 1.6)},
                        { 'M3', GH( 6.01, 2.4)},
                        { 'M4', GH( 7.66, 3.2)},
                        { 'M5', GH( 8.79, 4.7)},
                        { 'M6', GH(11.05, 5.2)},
                        { 'M8', GH(14.38, 6.8)},
                        {'M10', GH(17.77, 8.4)},
                        {'M12', GH(20.0,10.5)},
                        {'M14', GH(23.35,12.8)},
                        {'M16', GH(26.75,14.8)},
                        {'M20', GH(32.95,18.0)},
                        {'M24', GH(39.55,21.5)}
                      };
   if(!ISO4032.exists(name)){
      cout << " asERR: No values exist for: " << name << endl;
   }

   GH gh = cast<GH>(ISO4032[name]);
   return gh;
}

solid@ metric_hex_nut(string name, bool rounded = true)
{
   GH gh = get_dimensions(name);
   return metric_hexagon(gh.G,gh.H,rounded);
}



 
shape2d@ ISO_thread(double Dmaj, double pitch)
{
   double P = pitch;
   // basic thread profile https://en.wikipedia.org/wiki/ISO_metric_screw_thread
   double H = P*cos(to_rad(30));
   double delta = 0.01*P;
   
   // establish coordinates in profile
   double x1 = delta;;
   double x2 = P/8;
   double x3 = P/2 - P/16;
   double x4 = P/2 + P/16;
   double x5 = P - P/8;
   double x6 = P - delta;

   double y1 = 0;
   double y2 = H/4 - P/16;
   double y3 = H/4;
   double y4 = H - H/8;
   
   // build the thread profile, points CCW
   pos2d@[] points = { pos2d(x1,y1),  // p0
                       pos2d(x6,y1),  // p1
                       pos2d(x6,y2),  // p2
                       pos2d(x5,y3),  // p3
                       pos2d(x4,y4),  // p4
                       pos2d(x3,y4),  // p5
                       pos2d(x2,y3),  // p6
                       pos2d(x1,y2)   // p7
                     };
   shape2d@ profile = polygon(points);

   // put the profile in place, ready for rotation around Y
   @profile = translate(0.5*Dmaj-H+H/8,P/2)*rotate_z(deg:-90)*profile;

   return profile;
}

solid@ ISO_screw(double Dmaj, double pitch)
{
   // EXPERIMENTAL: non-zero pitch and multiple revolutions
   // rotate profile around Y, 13 revolutions, then make it upright
   double revs = 15;
   shape2d@ thread_profile = ISO_thread(Dmaj:Dmaj,pitch:pitch);
   solid@ threads = translate(0,0,pitch*revs)*rotate_x(deg:90)*rotate_extrude(thread_profile,deg:360*revs,pitch:-pitch);

   //make a cylinder inside the threads, then cut the ends by intersecting with a large diameter cylinder

   double H = pitch*cos(to_rad(30));
   double Dmin = Dmaj + 2*(H/8 - H + 0.8*H/4);
   double Rmin = 0.5*Dmin;
   solid@ rod  = cylinder(r:Rmin,h:pitch*revs);
   solid@ screw = intersection3d(union3d(rod,threads),translate(0,0,0.5*pitch)*cylinder(h:pitch*revs*0.9,r:100));

   solid@ cutter = cone(h:pitch*revs*1.3,r1:Dmaj*1.35,r2:1);
   return translate(0,0,-5)*intersection3d(screw,cutter);
}

solid@ ISO_nut(double Dmaj, double pitch)
{
   double revs = 15;
   shape2d@ thread_profile = ISO_thread(Dmaj:Dmaj,pitch:pitch);
   solid@ threads = translate(0,0,pitch*revs)*rotate_x(deg:90)*rotate_extrude(thread_profile,deg:360*revs,pitch:-pitch);

   //make a cylinder inside the threads, then cut the ends by intersecting with a large diameter cylinder

   double H = pitch*cos(to_rad(30));
   double Dmin = Dmaj + 2*(H/8 - H + 0.8*H/4);
   double Rmin = 0.5*Dmin;
   solid@ rod  = cylinder(r:Rmin,h:pitch*revs);

   solid@ trod = union3d(rod,threads);
   
   // scale up the subtracted threaded slightly in x and y to allow some clearance
   double s = (Dmaj+1)/Dmaj;
   return difference3d(metric_hex_nut('M16'),translate(0,0,-pitch*revs*0.25)*scale(s,s,1.0)*trod);
}



shape@ main_shape()
{
   string name = 'M16';
   GH gh = get_dimensions(name);
   double Dmaj = 16;
   double pitch = 2;
   solid@ bolt = translate(0,0,gh.H)*rotate_x(deg:180)*union3d(rotate_x(deg:180)*ISO_screw(Dmaj:Dmaj,pitch:pitch), metric_hex_nut(name));
   solid@ nut  = translate(Dmaj*2,0,0)*ISO_nut(Dmaj:Dmaj,pitch:pitch);

   return ISO_nut(Dmaj:Dmaj,pitch:pitch);
}

void main()
{
   shape@ obj = main_shape();
   obj.write_xcsg(GetOutputFullPath('.xcsg'),secant_tolerance:0.01);
}
