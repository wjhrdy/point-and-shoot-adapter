# L39 Adapter OpenSCAD Project

## Overview
This project generates a parametric Leica L39 (LTM) to lens adapter with a knurled grip, using OpenSCAD and open-source libraries for threads and knurling.

## Structure
- `l39-adapter.scad` — Main OpenSCAD source file (auto-generated from template)
- `l39-adapter.template.scad` — Template for the adapter, with a placeholder for lens profile includes
- `lenses/` — Directory containing individual lens profile SCAD files
- `libs/` — Contains OpenSCAD library dependencies (downloaded automatically)
- `output/` — STL and other generated output
- `justfile` — Automation for dependency management and builds

## Quick Start
1. Install [OpenSCAD](https://openscad.org/) and [`just`](https://just.systems/)
2. Clone this repo
3. Fetch dependencies:
   ```sh
   just deps
   ```
4. Build a default adapter:
   ```sh
   just build __brand-model-focallength-fstop
   ```
   Or build for a specific lens profile:
   ```sh
   just build nikon-fun_touch_6-28mm-f5.6
   ```
   This will generate an STL in the `output/` directory using the selected lens profile.

## Customization
- To create a new lens adapter, copy `lenses/__brand-model-focallength-fstop.scad` to a new file in the `lenses/` directory and edit the parameters for your lens:
  - `lens_hole_diam` — Inner diameter for your lens
  - `lens_cyl_depth` — Depth of the lens holding cylinder
  - `knurl_height` — Height of the knurled ring
  - `lens_offset` — Controls how recessed or protruding the lens sits
  - `l39_thread_length` — Thread length for the adapter
- Build with your new profile using:
  ```sh
  just build your-profile-filename
  ```
- The build system will automatically substitute the correct include for your chosen lens profile.

## Lens Profile Guide

Each lens profile SCAD file should define the following parameters:

```scad
lens_hole_diam = ...;    // mm, lens hole inner diameter (configurable)
lens_cyl_depth = ...;    // mm, depth of lens holding cylinder
knurl_height = ...;      // mm, height of knurled ring
lens_offset = ...;       // mm, positive = lens protrudes, zero/negative = flush or recessed
l39_thread_length = ...; // mm, total thread length
```

### Measurement & Setup Tips

measure from the front housing of the lens back to the first lip or largest lip.
cross section of lens diagram

```
        lens_cyl_depth
             ____
            ⬇  ⬇
        |  |
        |  |
   _____|  |_____    __
  /              \     |
 /                \    |
|                  |   | lens_hole_diam
|                  |   |
 \                /    |
  \____ ____ ____/   __|
        |  | 
        |  | 
back    |  |  front 
```
- Measure the largest diameter and the depth of the lens section to determine `lens_hole_diam` and `lens_cyl_depth`.
- Print with default parameters to test fit and measure the offset and knurl height.
- Seat the lens in the adapter and screw into the camera. Adjust `lens_offset` so the lens focuses to infinity:
  - `lens_offset = 0` for a flat lens
  - `lens_offset = -5` to `-10` for a recessed lens
- A positive `lens_offset` is possible but will make the lens more exposed and harder to print.

```
                              ____
                             ⬇  ⬇ (negative)lens_offset 
                             (this should be zero or >= for ease of printing)
 ⬇ lens mount face
 |                               /
 |                   |  |       /
 |                   |  |      /
 |              _____|  |_____/
 |             /              \  
 |            /                \
 |           |                  |
 |           |                  |
 |           \                /
 |            \____ ____ ____/
 |                   |  |     \
 |                   |  |      \
 |                   |  |       \
 |                               \      
                        
 ⬆_______________________________⬆ knurl_height
```

## Library Sources
- [threads.scad](https://github.com/rcolyer/threads-scad)
- [knurled-openscad](https://github.com/smkent/knurled-openscad)

## License
See individual libraries for their respective licenses.

## Contributing
Contributions are welcome! Please open an issue or submit a pull request.
