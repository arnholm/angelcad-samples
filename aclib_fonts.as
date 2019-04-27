// AngelCAD code: aclib_fonts.as
// this sample requires the aclib library to be installed
// in the AngelCAD libraries folder
// https://github.com/arnholm/aclib

/*
#include "aclib/fonts/DejaVuSans.as"
#include "aclib/fonts/DejaVuSans_Bold.as"
#include "aclib/fonts/DejaVuSans_Oblique.as"
#include "aclib/fonts/DejaVuSans_ExtraLight.as"
#include "aclib/fonts/DejaVuSansCondensed_Oblique.as"
*/
#include "aclib/fonts/LiberationSerif_Regular.as"
#include "aclib/fonts/LiberationSerif_Bold.as"
#include "aclib/fonts/LiberationSerif_BoldItalic.as"
/*
#include "aclib/fonts/LiberationMono_Regular.as"
#include "aclib/fonts/LiberationMono_BoldItalic.as"
#include "aclib/fonts/LiberationMono_Italic.as"
*/

shape@ main_shape()
{
   // select the font to use from one of the included
   as_font@ font  = LiberationSerif_Bold();
   
   // customize the character spacing
   font.spacer = 0.3;
   
   // generate a text line with given length (optional)
   shape2d@  text = font.text_line("AngelCAD fonts",length:200);
   
   // extrude in z using fraction of text height
   double dy = text.box().dy();
   return linear_extrude(text,dy*0.2);
}

void main()
{
   shape@ obj = main_shape();
   obj.write_xcsg(GetInputFullPath(),secant_tolerance:-1.0);
}


