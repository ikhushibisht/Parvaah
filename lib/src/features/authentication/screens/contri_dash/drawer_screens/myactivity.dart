// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart'; // Import the fl_chart package for bar graph

// class MyActivityScreen extends StatelessWidget {
//   const MyActivityScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('My Activity'),
//       ),
//       body: Column(
//         children: [
//           // Bar graph showing contributions
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: SizedBox(
//               height: 200,
//               child: BarChart(
//                 BarChartData(
//                   // Implement your bar chart data here
//                   // See fl_chart documentation for usage
//                   // Example:
//                   barGroups: [
//                     BarChartGroupData(
//                       x: 0,
//                       barRods: [
//                         BarChartRodData(color: Colors.blue, toY: 0.0),
//                       ],
//                     ),
//                     BarChartGroupData(
//                       x: 1,
//                       barRods: [
//                         BarChartRodData(color: Colors.green, toY: 0.0),
//                       ],
//                     ),
//                     // Add more BarChartGroupData as needed
//                   ],
//                   titlesData: const FlTitlesData(
//                     leftTitles: AxisTitles(
//                         sideTitles:
//                             SideTitles(reservedSize: 44, showTitles: true)),
//                     bottomTitles: AxisTitles(
//                         sideTitles:
//                             SideTitles(reservedSize: 30, showTitles: true)),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           // Activity logs
//           Expanded(
//             child: ListView.builder(
//               itemCount: 20,
//               itemBuilder: (context, index) {
//                 // Implement how you want to display each activity log
//                 // You can use ListTile or any other widget
//                 return ListTile(
//                   title: Text('Activity Log $index'),
//                   subtitle: Text('Description of activity log $index'),
//                   // Add more details as needed
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
