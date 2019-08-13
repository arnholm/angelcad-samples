// AngelCAD sample: cylinder_joint_fillet.as
// Demonstrates use of filleting the intersection between 2 cylnders


solid@ fillet(solid@ obj, double r)
{
   // create a cube enclosing the object completely
   // with an internal void shaped by the object
   boundingbox@ box = obj.box();
   pos3d@ c  = box.center(); 
   solid@ d1 = translate(c.x(),c.y(),c.z())*cube(box.diagonal()*2,center:true) - obj;
   
   // make the void smaller
   solid@ m1 = minkowski3d(d1,sphere(r));
   //  subtract from the object
   return obj - m1;
}

solid@ cylinder_joint()
{
   // union 2 cylinders with different radius, 
   // second one inclined 45 degrees relative to the first
   solid@ c1 = cylinder(r:30,h:150,center:true);
   solid@ c2 = rotate_y(deg:45)*cylinder(r:15,h:100);
   return c1+c2;
}

shape@ main_shape()
{
   return fillet(cylinder_joint(),r:3.5);
}

void main()
{
   shape@ obj = main_shape();
   obj.write_xcsg(GetInputFullPath(),secant_tolerance:0.005);
}
