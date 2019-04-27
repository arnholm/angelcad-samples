// AngelCAD code.
pos3d@ p(double x, double y, double z) { return pos3d(x,y,z);}

shape@ main_shape()
{
   // pyramid dimensions
   double x = 50;
   double y = 50;
   double z = 50;
   // radius of rounding sphere
   double r=6;
   
   // triangular pyramid   
   array<pos3d@> pnts = {p(-x+r, -y+r, 0+r),
                         p( x-r, -y+r, 0+r),
                         p( 0  ,  y-r, 0+r),
                         p( 0  ,    0, z-r)
                        };
   solid@ pyramid = polyhedron(pnts);

   // if radius greater than zero, run minkowski
   if(r>0) return minkowski3d(pyramid,sphere(r));
   else    return pyramid;
}

void main()
{
   shape@ obj = main_shape();
   obj.write_xcsg(GetInputFullPath(),secant_tolerance:0.01);
}