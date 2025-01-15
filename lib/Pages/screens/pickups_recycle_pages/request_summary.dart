// import 'package:energy_chleen/Pages/screens/pickups_recycle_pages/waste_info.dart';
// import 'package:energy_chleen/utils/Helper.dart';
// import 'package:flutter/material.dart';

// class RequestSummary extends StatefulWidget {
//   const RequestSummary({super.key});

//   @override
//   State<RequestSummary> createState() => _RequestSummaryState();
// }

// class _RequestSummaryState extends State<RequestSummary> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Pick Up Details'),
//         centerTitle: true,
//         leading: Container(
//           margin: EdgeInsets.only(left: 10, right: 10),
//           height: 50,
//           width: 50,
//           padding: EdgeInsets.all(5),
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: Customcolors.teal
//           ),
//           child: IconButton(
//             tooltip: 'Go back',
//             icon: Icon(Icons.arrow_back_ios, size: 18,color: Customcolors.white,),
//             onPressed: () => Navigator.pop(context), // Navigate back
//           ),
//         ),
//         // backgroundColor: Colors.white,
//         elevation: 0,
//         iconTheme: IconThemeData(color: Colors.black),
//         titleTextStyle: TextStyle(
//           color: Colors.black,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       body: Column(
//         children: [
//           Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Row(
//                     children: [
//                       Icon(Icons.location_on, color: Customcolors.teal),
//                       SizedBox(width: 8),
//                       Text('- - - - - - - - - - - - - - -', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Customcolors.teal)),
//                       Icon(Icons.edit, color: Colors.grey),
//                       Text('- - - - - - - - - - - - - - -', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Customcolors.teal)),
//                     ],
//                   ),
//                   Icon(Icons.check_circle, color: Colors.grey),
//                 ],
//               ),
//         ],
//       ),
//     );
//   }
//     // waste details
// Widget _buildWasteTypeAndDetails() {

//   final wasteDetails = WasteInfo.new();

//   return SizedBox(
//     height: 300, // Define a fixed height for the list
//     child: ListView.separated(
//       itemCount: wasteDetails.length,
//       itemBuilder: (context, index) {
//         final station = stations[index];
//         return WasteInfo(wasteType, weight, estimatedIncome, editWasteDetails, removeWasteType, pickupDate)
//       },
//       separatorBuilder: (context, index) => SizedBox(height: 10),
//     ),
//   );
// }
// }