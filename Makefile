# make            -> export every laser part as SVG + DXF into export/
# make check      -> compare exports against the original Tinkercad SVGs
OPENSCAD ?= openscad
LASER    := frame_plate effector_plate

all: $(foreach p,$(LASER),export/$(p).svg export/$(p).dxf)

export/%.svg: parts/%.scad config.scad lib/util.scad
	$(OPENSCAD) -o $@ $<
export/%.dxf: parts/%.scad config.scad lib/util.scad
	$(OPENSCAD) -o $@ $<

# reference SVGs are in Tinkercad coordinates; numbers = their machine centre
check: all
	python3 tools/compare.py reference/frame_plate.svg    export/frame_plate.svg    -12.684 -16.391
	python3 tools/compare.py reference/effector_plate.svg export/effector_plate.svg 0 -10

.PHONY: all check
