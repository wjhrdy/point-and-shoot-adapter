# Justfile for L39 Adapter OpenSCAD Project
# Usage:
#   just deps      # Download latest thread and knurl OpenSCAD libraries
#   just build     # Compile l39-adapter.scad to STL
#   just clean     # Remove downloaded libraries and output

# Download latest dependencies into libs/
deps:
    command -v openscad >/dev/null 2>&1 || brew install --cask openscad@snapshot
    mkdir -p libs
    [ -f libs/threads.scad ] || curl -L -o libs/threads.scad "https://raw.githubusercontent.com/rcolyer/threads-scad/master/threads.scad"
    [ -f libs/knurled.scad ] || curl -L -o libs/knurled.scad "https://raw.githubusercontent.com/smkent/knurled-openscad/master/knurled.scad"

# Build STL from OpenSCAD file, output to output/
# Build STL from OpenSCAD file, output to output/
build lens_profile: deps
    mkdir -p output
    sed "s|//LENS_INCLUDE|include <lenses/{{lens_profile}}.scad>;|" l39-adapter.template.scad > l39-adapter.scad
    openscad -o output/{{lens_profile}}.stl l39-adapter.scad

# Build thread test
thread-test: deps
    mkdir -p output
    openscad -o output/l39-thread.stl l39-thread.scad

# Clean up generated files
clean:
    rm -rf libs output
