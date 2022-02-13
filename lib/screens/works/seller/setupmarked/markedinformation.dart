// import 'package:flutter/material.dart';

// import '../../../../../all.dart';

// class MarkedInformation extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: ConstantValue().background,
//       appBar: Customized().appBarforlimit(
//         size,
//         ConstantValue().markedinfo,
//         () {
//           Navigator.of(context).popUntil(
//             ModalRoute.withName('/SellerDashboard'),
//           );
//         },
//       ),
//       body: ListView.builder(
//         padding: EdgeInsets.zero,
//         itemCount: 2,
//         itemBuilder: (context, i) => Customized().markedonlynameaddress(
//           size,
//           () {
//             Customized().naviagt(
//               context,
//               MarkedInfoDetailScreen(),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
