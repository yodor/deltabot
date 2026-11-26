# compare OpenSCAD-exported SVG against the Tinkercad reference SVG
import re, sys, numpy as np
from shapely.geometry import Polygon
from shapely import affinity
def rings(svg):
    txt=open(svg).read(); out=[]
    for d in re.findall(r'\bd="([^"]+)"',txt,re.S):
        for sub in re.split(r'M',d)[1:]:
            n=np.array(list(map(float,re.findall(r'-?\d+\.?\d*(?:e-?\d+)?',sub)))).reshape(-1,2); n[:,1]*=-1; out.append(n)
    return out
def shape(svg):
    s=None
    for r in rings(svg):
        P=Polygon(r).buffer(0); s=P if s is None else s.symmetric_difference(P)
    return s
if __name__!="__main__": pass
else:
  ref,new,cx,cy=sys.argv[1],sys.argv[2],float(sys.argv[3]),float(sys.argv[4])
  A=affinity.translate(shape(ref),-cx,-cy); B=shape(new)
  d=A.symmetric_difference(B)
  print(f"area ref {A.area:.1f}  new {B.area:.1f}  symdiff {d.area:.2f} mm2 ({100*d.area/A.area:.3f}%)")
  print(f"holes ref {sum(len(g.interiors) for g in getattr(A,'geoms',[A]))} new {sum(len(g.interiors) for g in getattr(B,'geoms',[B]))}")
  # biggest discrepancies
  parts=sorted(getattr(d,'geoms',[d]),key=lambda g:-g.area)[:6]
  for g in parts: print(f"  {g.area:7.3f} mm2 at ({g.centroid.x:8.2f},{g.centroid.y:8.2f}) width~{2*g.area/max(g.length,1e-9):.3f}")
