# L39 Adapter OpenSCAD Project

![broken point and shoot cameras](/assets/cameras.jpg)

## Overview
This project generates a parametric Leica L39 (LTM) to lens adapter with a knurled grip, using OpenSCAD and open-source libraries for threads and knurling.

> [!WARNING]
> If you are not careful, it is possible to design and print an adapter that, when screwed into your camera, could protrude so far that it physically touches or damages your camera's sensor or shutter. Always measure carefully and double-check your design before mounting on your camera. The authors and contributors are not responsible for any damage caused by improper use of these adapters.

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

## Achieving Focus

To use these adapted lenses with precise focusing on a mirrorless camera, you can combine this custom L39 adapter with two additional components:

1. **L39-to-M Mount Adapter:**
   - This thin adapter converts the Leica L39 (LTM) thread to Leica M mount. These are widely available and inexpensive.
2. **M Mount Helicoid Adapter:**
   - This is a variable extension tube ("helicoid") with Leica M mount on both sides. It allows you to finely adjust the lens-to-sensor distance, enabling close focus or correcting for flange differences.

**Typical workflow:**
- Attach your lens to the 3D-printed L39 adapter.
- Screw the L39 adapter into the L39-to-M adapter.
- Mount the combined unit onto the M-mount helicoid adapter.
- Attach the assembly to your mirrorless camera using an M-mount-to-camera adapter (if needed).
- Use the helicoid to achieve focus, including infinity and macro distances.

This setup is especially useful for adapting compact point-and-shoot or rangefinder lenses to digital mirrorless systems, giving you full manual focus control.

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
 |            \                /
 |             \______________/
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

---

> [!NOTE]
> Only use broken point and shoot cameras for your lens conversions. Please don't buy up a scarce resource and make these silly lenses from working cameras. Let's keep vintage cameras available for everyone!
