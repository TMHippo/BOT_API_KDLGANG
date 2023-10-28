// import 'package:flutter/material.dart';
// import 'package:login_app/Sign_page.dart';
// import 'package:login_app/firebase_services.dart';

// class Navigation_Drawer extends StatelessWidget {
//   final String name;
//   Navigation_Drawer(this.name);

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             buildheader(context, name),
//             buildmenuItems(context),
//           ],
//         ),
//       ),
//     );
//   }
// }

// Widget buildheader(BuildContext context, String name) => Material(
//       color: Colors.blue[900],
//       child: InkWell(
//         onTap: () {},
//         child: Container(
//           padding: EdgeInsets.only(
//               top: 20 + MediaQuery.of(context).padding.top, bottom: 20),
//           child: Column(
//             children: [
//               CircleAvatar(
//                 radius: 52,
//                 backgroundColor: Colors.green,
//                 child: Text(
//                   name[0].toUpperCase(),
//                   style: TextStyle(
//                     fontSize: 45,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 12,
//               ),
//               Text(
//                 name,
//                 style: TextStyle(color: Colors.white, fontSize: 28),
//               ),
//               Text(
//                 "tranminhhien1oo82oo3@gmail.com",
//                 style: TextStyle(color: Colors.white, fontSize: 16),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );

// Widget buildmenuItems(BuildContext context) => Container(
//       padding: const EdgeInsets.all(24),
//       child: Wrap(
//         children: [
//           ListTile(
//             leading: Icon(Icons.account_box),
//             title: const Text('Account'),
//             onTap: () {},
//           ),
//           const Divider(
//             color: Colors.black45,
//           ),
//           ListTile(
//             leading: Icon(Icons.logout),
//             title: const Text('log out'),
//             onTap: () async{
//               await FirebaseServices().signOut();
//               Navigator.push(context, MaterialPageRoute(builder: (context)=> SigninPage()));
//             },
//           ),
//         ],
//       ),
//     );
