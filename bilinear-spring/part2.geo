//’part2’ geometry

cl1 = 2.0 ;   //characteristic length, for meshing
off1 = 5.5 ; // y offset from part 1
t1  = 5   ;   //thickness of half part
r1  = 10.5 ;  // inside radius of eye
r2  = 17.0 ;  //outside radius of eye

// 2D Geometry
Point(1) = {0, -off1, 0, cl1}; // Base point
Point(11) = {0, -off1, -r1, cl1};
Point(12) = {-r1*Sin(2*Pi/3), -off1, r1+r1*Cos(2*Pi/3), cl1};
Point(13) = {-r1*Sin(4*Pi/3), -off1, r1+r1*Cos(4*Pi/3), cl1};
Point(21) = {-Sqrt(r2*r2-r1*r1), -off1, r1, cl1};
Point(22) = {r2, -off1, 0, cl1};
Point(23) = {-Sqrt(r2*r2-r1*r1), -off1, -r1, cl1};
Point(24) = {-4*r2, -off1, r1, cl1};
Point(25) = {-4*r2, -t1, -r1, cl1};
Circle(1) = {11, 1, 12};
Circle(2) = {12, 1, 13};
Circle(3) = {13, 1, 11};
Circle(4) = {21, 1, 22};
Circle(5) = {22, 1, 23};
Line(6) = {21, 24};
Line(7) = {23, 25};
Line(8) = {25, 24};
Circle(9) = {21, 1, 23};

// Extrusion
fix2s[] = { Extrude { 0, -t1, 0} { Line{ -8}; Layers {3} ; } };
edge2s[] = { Extrude { 0, -t1, 0} { Line { 6, -4, -5, -7, -9}; Layers {3}; } };
hole2s[] = { Extrude {0, -t1, 0} { Line {-1, -2, -3} ; Layers {3} ; }};

// Surfaces
Line Loop(106) = {4, 5, -9};
Line Loop(107) = {2, 3, 1};
Plane Surface(108) = {106, 107};
Line Loop(109) = { 6 , -8 , -7 , -9};
Plane Surface(110) = {109};

//Surfaces into volumes
part2v[] = { Extrude { 0, t1, 0} {Surface {-108, 110};} };

//Items necessary in the calculation 
Physical Point("move2p") = {11};
Physical Surface("bear1s") = {108};
Physical Surface("hole2s") = {hole2s[]};
Physical Surface("fix2s") = {fix2s[]};
Physical Surface ("pres2s") = {142} ;
Physical Volume ( "part2v") = { part2v[] };
//
