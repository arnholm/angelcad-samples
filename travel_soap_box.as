// AngelCAD code.
// Create a soap box
// https://www.thingiverse.com/thing:2819336

solid@ soap(double l, double w, double h, double r)
{
   solid@[] s;
   for(double z=r; z<=h-r; z+=h-2*r) { 
      for(double y=r; y<=w-r; y+=w-2*r) {
         for(double x=r; x<=l-r; x+=l-2*r) {
            s.push_back(translate(x,y,z)*sphere(r));
         }
      }
   }

   solid@ sb = hull3d(s);
   boundingbox@ b = sb.box();
   pos3d@ c = b.center();  
   return translate(-c.x(),-c.y(),-c.z())*sb;
}

solid@ half_box(double len, double wid, double hei, double ro, double ri, double th) 
{
   return   soap(l:len+2*th,w:wid+2*th,h:hei+2*th,r:ro)
          - soap(l:len,w:wid,h:hei,r:ri)
          - translate(wid,0,0)*cube(size:wid*2,center:true);
}

solid@ lip(double len, double wid, double hei, double ro, double ri, double th) 
{
   return   soap(l:len+2*th,w:wid+2*th,h:hei+2*th,r:ro)
          - soap(l:len,w:wid,h:hei,r:ri)
          - translate(1.2*wid,0,0)*cube(size:wid*2,center:true)
          - translate(-1.2*wid,0,0)*cube(size:wid*2,center:true);
}

solid@ part1(double len, double wid, double hei, double ro, double ri, double th, double th_lip) 
{
   return   half_box(len,wid,hei,ro,ri,th) 
          + lip(len,wid,hei,ro,ri,th_lip-0.1);
}

solid@ part2(double len, double wid, double hei, double ro, double ri, double th, double th_lip) 
{
   return   half_box(len,wid,hei,ro,ri,th) 
          - lip(len,wid,hei,ro,ri,th_lip+0.1);
}

shape@ main_shape()
{
   double len = 90;
   double wid = 62;
   double hei = 33;
   double ri  = 9;
   double ro  = 10;
   double th  = 1.6;
   double th_lip  = 0.8;
   
   solid@ obj = rotate_y(deg:-90)*part1(len,wid,hei,ro,ri,th,th_lip) 
              + translate(len/2,0,0)*rotate_y(deg:90)*rotate_z(deg:180)*part2(len,wid,hei,ro,ri,th,th_lip)
              - translate(0,0,-len/4)*rotate_y(deg:90)*cylinder(r:5,h:200,center:true);
              
   // center the box
   pos3d@ c = obj.box().center();
   return  translate(-c.x(),-c.y(),-c.z())*obj;
}

void main()
{
   shape@ obj = main_shape();
   obj.write_xcsg(GetInputFullPath(),secant_tolerance:0.02);
}
