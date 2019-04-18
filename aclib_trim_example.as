// AngelCAD sample: aclib_trim_example.as
// This example demonstrates use of trim function from the aclib library
// see https://github.com/arnholm/aclib

// To use the aclib library, you must have git installed
// and do as follows in AngelCAD
// 1. File -> Open Libraries Folder
// 2. From a terminal windows in the libraries folder, do
//    git clone https://github.com/arnholm/aclib
// 3. aclib installation is complete

#include "aclib/trim.as"

shape@ main_shape()
{
   // trim a sphere with a plane through x=80 and with a normal vector (1,0,1)
   return trim(object:sphere(100),pos:pos3d(80,0,0),normal:vec3d(1,0,1));
}

void main()
{
   shape@ obj = main_shape();
   obj.write_xcsg(GetInputFullPath(),secant_tolerance:-1.0);
}
