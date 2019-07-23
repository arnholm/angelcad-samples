// AngelCAD code.
// example demonstrates 3d filetting using minkowski3d

solid@ object(double sz)
{
   // cuboids extending in 3 axis directions
   return   translate(-sz,0,0) * cuboid(2*sz,sz,sz)
          + translate(0,-sz,0) * cuboid(sz,2*sz,sz)
          + cuboid(sz,sz,2*sz);
}

solid@ erode(solid@ obj, double r)
{
   // create a cube enclosing the object completely
   // with an internal void shaped by the object
   double diag = obj.box().diagonal();
   solid@ d1 = cube(diag*2,center:true) - obj;
   
   // make the void s
   solid@ m1 = minkowski3d(d1,sphere(r));
   return obj - m1;
}

shape@ main_shape()
{
   return erode(object(sz:100),20.0);
}

void main()
{
   shape@ obj = main_shape();
   obj.write_xcsg(GetInputFullPath(),secant_tolerance:-1);
}
