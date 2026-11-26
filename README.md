# deltabot

Custom Kossel-style linear-rail delta printer (Klipper). Parametric OpenSCAD
source for the printed and laser-cut parts, consolidated from the original
Tinkercad projects.

## Layout

```
config.scad          all shared dimensions — parts read from here
lib/util.scad        small 2D helpers (polar placement, rounding, tongues)
parts/               one file per part
  frame_plate.scad     laser cut, 3x (bottom pair + top)
  effector_plate.scad  laser cut
export/              generated SVG/DXF for laser cutting, STL for printing
reference/           original Tinkercad exports, kept for comparison
tools/               compare/overlay scripts used by `make check`
render/              preview images
```

## Conventions

- Origin = machine centre / nozzle axis, units mm.
- Towers use Klipper naming: A 210°, B 330°, C 90° (CCW from +X).
- Laser parts are defined as 2D modules (`*_2d()`); the 3D module just
  extrudes them, for assembly previews.

## Build

```
make          # export all laser parts to export/*.svg and *.dxf
make check    # compare against the Tinkercad originals in reference/
```

Requires OpenSCAD; `make check` also needs Python with numpy, shapely and matplotlib.
