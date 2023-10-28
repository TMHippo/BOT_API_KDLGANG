// import 'package:flutter/material.dart';


// class ChatMessage extends StatelessWidget {
//   const ChatMessage({super.key, required this.text, required this.sender});

//   final String text;
//   final String sender;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.end, // Đặt giá trị này thành MainAxisAlignment.end
//       children: [
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.end, // Đặt giá trị này thành CrossAxisAlignment.end
//             children: [
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(25),
//                   color: Colors.blue, // Màu xanh
//                 ),
//                 margin: const EdgeInsets.only(top: 5.0),
//                 child: Text(
//                   text,
//                   style: TextStyle(
//                     color: Colors.white, // Màu văn bản
//                     fontSize: 16.0, // Cỡ chữ cho nội dung tin nhắn (có thể điều chỉnh)
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Container(
//           margin: const EdgeInsets.only(left: 10.0, right: 16.0),
//           child: CircleAvatar(child: Text(sender[0])),
//         ),
//       ],
//     );
//   }
// }
