// measure from the front housing of the lens back to the first lip or largest lip.
// cross section of lens diagram

//         lens_cyl_depth
//              ____
//             ⬇  ⬇
//         |  |
//         |  |
//    _____|  |_____    __
//   /              \     |
//  /                \    |
// |                  |   | lens_hole_diam
// |                  |   |
//  \                /    |
//   \____ ____ ____/   __|
//         |  | 
//         |  | 
// back    |  |  front 

// measure the largest diameter of this section
// measure the depth of this section

lens_hole_diam = 16.78;          // mm, lens hole inner diameter (configurable)
lens_cyl_depth = 4;           // mm, depth of lens holding cylinder

// print with the default params this will let you measure the offset and knurl height

knurl_height = 5;              // mm, height of knurled ring
lens_offset = -5;             // mm, positive = lens protrudes in front of knurled face, zero/negative = flush or recessed
l39_thread_length = 15;        // mm, total thread length reset to 5 after testing.

// measure the offset and knurl height
// seat the lens in the adapter and screw it in to the camera
// screw it in until you are focused on infinity then measure the height of the knurled ring
// decide if you want a flat lens or a recessed lens and set lens_offset accordingly.
// lens_offset = 0 for a flat lens, lens_offset = -5 to -10 for a recessed lens
// sometimes a flat lens might not work if the face of the lens needs to be 
// to close to the lens mount face

// you can make a positive lens offset but it will be harder 
// to print and your lens will be more exposed.

//                               ____
//                              ⬇  ⬇ (negative)lens_offset (this should be zero or >= 5 for ease of printing)
//  ⬇ lens mount face
//  |                               /
//  |                   |  |       /
//  |                   |  |      /
//  |              _____|  |_____/
//  |             /              \  
//  |            /                \
//  |           |                  |
//  |           |                  |
//  |           \                /
//  |            \____ ____ ____/
//  |                   |  |     \
//  |                   |  |      \
//  |                   |  |       \
//  |                               \      
//                       
//  ⬆_______________________________⬆ knurl_height
// 