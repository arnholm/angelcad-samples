// AngelCAD code: auto_dimmer_override.as
// Enables manual override of rear view mirror auto dimmer
// https://www.thingiverse.com/thing:3158616
//
// Piece to be fastened over rear view mirror ambient light sensor, so the sensor
// is looking through the window of the printed piece. The ambient light sensor 
// is at the back of the mirror looking forward through the wind-shield. 

// When the slider is closed, the sensor registers "night" and mirror auto 
// dimming is possible when it otherwise would not work due to too much 
// ambient light.

// dimensions of main "box"
double xbox=30.0;
double ybox=25.0;
double zbox=4.0;

// dimensions of slider
double xlen_s = 40;
double ywid_s = 13;
double zth_s  = 2.0;


solid@ slider(double xlen,   // length of slider in x
              double ywid,   // width of slider in y
              double zth)    // thickness of slider in z
{
   double y1 = ywid/2;
   double y2 = y1-zth/4;
   pos3d@[] points = {  // end1
                        pos3d(  0.0,  y1, 0.0)
                       ,pos3d(  zth/2,  y2, zth)
                       ,pos3d(  zth/2, -y2, zth)
                       ,pos3d(  0.0, -y1, 0.0)
                        // end2
                       ,pos3d( xlen,  y1, 0.0)
                       ,pos3d( xlen,  y2, zth)
                       ,pos3d( xlen, -y2, zth)
                       ,pos3d( xlen, -y1, 0.0)
                     };
                     
   double xw1= 0.5*zth;
   double yw1= ywid-2*zth;
   
   double xw2= zth*2;
   double yw2= ywid-zth/2;
   
   // slider bar + stopper and grip
   return polyhedron(points)
          + translate(0.75*zth   ,-yw1/2,zth/2)*cuboid(xw1, yw1,  zth*0.7)
          + translate(xlen-xw2,-yw2/2,zth/2)*cuboid(xw2, yw2,  zth*1.5);
}


solid@ box(double dx, double dy, double dz)
{
   // dimensions of sensor window in "box"
   double xwin=18.0;
   double ywin=10.5;   
   
   // main box minus window and slider
   return   translate(0,-dy/2,0.0)*cuboid(dx,dy,dz)  
          - translate(dx/2-2,0,0.0)*cuboid(xwin,ywin,100,center:true) // window
          - translate(3,0,1)*scale(1.05)*slider(xlen:xlen_s,ywid:ywid_s-zth_s,zth:zth_s);
}


shape@ main_shape()
{
   //top piece is to be attached to main piece using double adhesive tape or superglue 
   solid@ top_piece = cuboid(dx:8,dy:ybox,dz:1);

   // Assemble pieces to be printed at once
   return box(dx:xbox,dy:ybox,dz:zbox) 
        - translate(22,-ybox/2,zbox-1)*scale(1.05)*top_piece
        + translate(-10,35,0)*slider(xlen:xlen_s,ywid:ywid_s-zth_s,zth:zth_s)
        + translate(-20,-ybox/2,0)*top_piece ;
}

void main()
{
   shape@ obj = main_shape();
   obj.write_xcsg(GetInputFullPath(),secant_tolerance:-1.0);
}
