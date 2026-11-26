import sys; import os; sys.path.insert(0,os.path.dirname(__file__))
import numpy as np, matplotlib; matplotlib.use("Agg"); import matplotlib.pyplot as plt
from compare import rings
ref,new,cx,cy,out=sys.argv[1],sys.argv[2],float(sys.argv[3]),float(sys.argv[4]),sys.argv[5]
fig,ax=plt.subplots(figsize=(10,10))
for r in rings(ref): r=np.vstack([r,r[:1]]); ax.plot(r[:,0]-cx,r[:,1]-cy,'r-',lw=2.5,alpha=.45)
for r in rings(new): r=np.vstack([r,r[:1]]); ax.plot(r[:,0],r[:,1],'k-',lw=.6)
ax.set_aspect('equal'); ax.grid(lw=.3); ax.set_title("red = Tinkercad original, black = parametric OpenSCAD")
fig.savefig(out,dpi=90,bbox_inches='tight')
