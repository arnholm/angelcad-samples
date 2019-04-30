// AngelCAD code: aclib_sign_generator.as
// 
// This sample requires the https://github.com/arnholm/aclib 
// library to be installed in the AngelCAD libraries folder.

// select the font to use from one of the available
#include "aclib/fonts/LiberationSerif_Bold.as"

shape@ main_shape()
{
   // 4 lines of text
   array<string> lines = {
       "Children left"
     , "unattended"
     , "will be sold"
     , "to the circus"
   };

   // Create font object used for text generation
   as_font@ font = LiberationSerif_Bold();
  
   // factors for customizing character & line spacings
   font.xspacer = 0.5; // spacer between characters
   font.yspacer = 0.8; // spacer between lines
   
   // generate 2d text profile, scaled to given x-length.
   // The anchor point is bottom left of text.
   shape2d@ txt2d = font.text(lines,length:100);
   
   // size and center of text bounding box
   boundingbox@ b = txt2d.box();
   pos3d@ c       = b.center();
   
   // thickness in z of bottom plate & text 
   double plt_z = 0.6; // plate thickness  
   double fnt_z = 1.5; // extrude text in z  
   
   // bottom plate
   double sz = 1.1; // scale up plate by 10% vs text in x and y
   solid@ plt = scale(sz,sz)*cuboid(b.dx(),b.dy(),plt_z,center:true);
   
   // extrude 2d text to 3d and center it
   solid@ txt = translate(-c.x(),-c.y())*linear_extrude(txt2d,fnt_z);
   
   // final union
   return plt + txt;
}

void main()
{
   shape@ obj = main_shape();
   obj.write_xcsg(GetInputFullPath(),secant_tolerance:-1.0);
}


