// import 'package:cinexa/models/movies/movie_types.dart';
// import 'package:flutter/material.dart';

// class JobCard extends StatelessWidget {
//   final MovieCategoryDetails movieCategoryDetails;
//   final VoidCallback onTap;

//   const JobCard({
//     Key? key,
//     required this.movieCategoryDetails,
//     required this.onTap,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final darkMode = Theme.of(context).brightness == Brightness.dark;
//     return GestureDetector(
//       onTap: onTap,
//       child: ClipPath(
//         clipper: ShapeBorderClipper(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(
//               Radius.circular(10),
//             ),
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
//           child: Container(
//             decoration: BoxDecoration(
//               color: Colors.blue,
//               borderRadius: BorderRadius.circular(10),
//               border: Border.all(
//                 color: darkMode ? Colors.grey[500]! : Colors.grey[100]!,
//               ),
//               boxShadow: [
//                 BoxShadow(
//                   color: darkMode ? Colors.black : Colors.grey[500]!,
//                   blurRadius: 2.0,
//                   offset: Offset(0, 2),
//                 )
//               ],
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(8, 20, 8, 5),
//                   child: bottomLine(context),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget bottomLine(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Expanded(
//           child: Container(
//             width: MediaQuery.of(context).size.width / 2 - 22,
//             alignment: Alignment.centerLeft,
//             child: Text(
//               movieCategoryDetails.adult.toString(),
//               style: Theme.of(context).textTheme.subtitle2!.apply(
//                     fontWeightDelta: 2,
//                   ),
//             ),
//           ),
//         ),
//         Expanded(
//           child: Container(
//             width: MediaQuery.of(context).size.width / 2 - 22,
//             alignment: Alignment.centerRight,
//             child: Text(
//               movieCategoryDetails.originalTitle.toString(),
//               overflow: TextOverflow.ellipsis,
//               maxLines: 1,
//               style: Theme.of(context)
//                   .textTheme
//                   .subtitle2!
//                   .apply(fontSizeFactor: 0.8),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
