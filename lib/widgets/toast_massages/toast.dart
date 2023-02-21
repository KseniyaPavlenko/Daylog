// import 'dart:js';

// import 'package:flutter/material.dart';
// import 'package:motion_toast/motion_toast.dart';
// import 'package:motion_toast/resources/arrays.dart';

// class ToastMessage extends StatelessWidget {
//   const ToastMessage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           const Text(
//             'Motion Toast Examples',
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//           ),
//           const SizedBox(
//             height: 15,
//           ),
//           SizedBox(
//             width: 200,
//             child: ElevatedButton(
//               onPressed: () {
//                 _displaySuccessMotionToast();
//               },
//               child: const Text('Success Motion Toast'),
//             ),
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           SizedBox(
//             width: 200,
//             child: ElevatedButton(
//               onPressed: () {
//                 _displayWarningMotionToast();
//               },
//               child: const Text('Warning Motion Toast'),
//             ),
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           SizedBox(
//             width: 200,
//             child: ElevatedButton(
//               onPressed: () {
//                 _displayErrorMotionToast();
//               },
//               child: const Text('Error Motion Toast'),
//             ),
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           SizedBox(
//             width: 200,
//             child: ElevatedButton(
//               onPressed: () {
//                 _displayInfoMotionToast();
//               },
//               child: const Text('Info Motion Toast'),
//             ),
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           SizedBox(
//             width: 200,
//             child: ElevatedButton(
//               onPressed: () {
//                 _displayDeleteMotionToast();
//               },
//               child: const Text('Delete Motion Toast'),
//             ),
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           SizedBox(
//             width: 200,
//             child: ElevatedButton(
//               onPressed: () {
//                 _displayResponsiveMotionToast();
//               },
//               child: const Text('Responsive Motion Toast'),
//             ),
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           SizedBox(
//             width: 200,
//             child: ElevatedButton(
//               onPressed: () {
//                 _displayCustomMotionToast();
//               },
//               child: const Text('Custom Motion Toast'),
//             ),
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           SizedBox(
//             width: 200,
//             child: ElevatedButton(
//               onPressed: () {
//                 _displayMotionToastWithoutSideBar();
//               },
//               child: const Text('Without sidebar'),
//             ),
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           SizedBox(
//             width: 200,
//             child: ElevatedButton(
//               onPressed: () {
//                 _displayMotionToastWithBorder();
//               },
//               child: const Text('With border'),
//             ),
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           SizedBox(
//             width: 200,
//             child: ElevatedButton(
//               onPressed: () {
//                 _displayTwoColorsMotionToast();
//               },
//               child: const Text('Two-color Motion Toast'),
//             ),
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           SizedBox(
//             width: 200,
//             child: ElevatedButton(
//               onPressed: () {
//                 _displayTransparentMotionToast();
//               },
//               child: const Text('Transparent Motion Toast'),
//             ),
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           SizedBox(
//             width: 200,
//             child: ElevatedButton(
//               onPressed: () {
//                 _displaySimultaneouslyToasts();
//               },
//               child: const Text('Simultaneously taosts'),
//             ),
//           ),
//         ],
//       ),
//     );
  
//   }

//   void _displaySuccessMotionToast() {
//     MotionToast.success(
//       title: const Text(
//         'Lorum Ipsum',
//         style: TextStyle(fontWeight: FontWeight.bold),
//       ),
//       description: const Text(
//         'Lorem ipsum dolor sit amet, Lorem ipsum dolor sit amet, Lorem ipsum dolor sit amet, Lorem ipsum dolor sit amet, Lorem ipsum dolor sit amet, Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor, sed do eiusmod tempor, sed do eiusmod tempor',
//         style: TextStyle(fontSize: 12),
//       ),
//       layoutOrientation: ToastOrientation.rtl,
//       animationType: AnimationType.fromRight,
//       dismissable: true,
//     ).show(context as BuildContext);
//   }

//   void _displayWarningMotionToast() {
//     MotionToast.warning(
//       title: const Text(
//         'Warning Motion Toast',
//         style: TextStyle(
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       description: const Text('This is a Warning'),
//       animationCurve: Curves.bounceIn,
//       borderRadius: 0,
//       animationDuration: const Duration(milliseconds: 1000),
//     ).show(context as BuildContext);
//   }

//   void _displayErrorMotionToast() {
//     MotionToast.error(
//       title: const Text(
//         'Error',
//         style: TextStyle(
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       description: const Text('Please enter your name'),
//       position: MotionToastPosition.top,
//       barrierColor: Colors.black.withOpacity(0.3),
//       width: 300,
//       height: 80,
//       dismissable: false,
//     ).show(context as BuildContext);
//   }

//   void _displayInfoMotionToast() {
//     MotionToast.info(
//       title: const Text(
//         'Info Motion Toast',
//         style: TextStyle(
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       position: MotionToastPosition.center,
//       description: const Text('Example of Info Toast'),
//     ).show(context as BuildContext);
//   }

//   void _displayDeleteMotionToast() {
//     MotionToast.delete(
//       title: const Text(
//         'Deleted',
//         style: TextStyle(
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       description: const Text('The item is deleted'),
//       animationType: AnimationType.fromTop,
//       position: MotionToastPosition.top,
//     ).show(context as BuildContext);
//   }

//   void _displayResponsiveMotionToast() {
//     MotionToast(
//       icon: Icons.rocket_launch,
//       primaryColor: Colors.purple,
//       title: const Text(
//         'Custom Toast',
//         style: TextStyle(
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       description: const Text(
//         'Hello my name is Flutter dev',
//       ),
//     ).show(context as BuildContext);
//   }

//   void _displayCustomMotionToast() {
//     MotionToast(
//       primaryColor: Colors.pink,
//       title: const Text(
//         'Bugatti',
//         style: TextStyle(
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       dismissable: false,
//       description: const Text(
//           'Automobiles Ettore Bugatti was a German then French manufacturer of high-performance automobiles. The company was founded in 1909 in the then-German city of Molsheim, Alsace, by the Italian-born industrial designer Ettore Bugatti. '),
//     ).show(context as BuildContext);
//   }

//   void _displayMotionToastWithoutSideBar() {
//     MotionToast(
//       icon: Icons.zoom_out,
//       primaryColor: Colors.orange[500]!,
//       secondaryColor: Colors.grey,
//       backgroundType: BackgroundType.solid,
//       title: const Text('Two Color Motion Toast'),
//       description: const Text('Another motion toast example'),
//       displayBorder: true,
//       displaySideBar: false,
//     ).show(context as BuildContext);
//   }

//   void _displayMotionToastWithBorder() {
//     MotionToast(
//       icon: Icons.zoom_out,
//       primaryColor: Colors.deepOrange,
//       title: const Text('Top Motion Toast'),
//       description: const Text('Another motion toast example'),
//       position: MotionToastPosition.top,
//       animationType: AnimationType.fromTop,
//       displayBorder: true,
//       width: 350,
//       height: 100,
//       padding: const EdgeInsets.only(
//         top: 30,
//       ),
//     ).show(context as BuildContext);
//   }

//   void _displayTwoColorsMotionToast() {
//     MotionToast(
//       icon: Icons.zoom_out,
//       primaryColor: Colors.orange[500]!,
//       secondaryColor: Colors.grey,
//       backgroundType: BackgroundType.solid,
//       title: const Text(
//         'Two Color Motion Toast',
//         style: TextStyle(
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       description: const Text('Another motion toast example'),
//       position: MotionToastPosition.top,
//       animationType: AnimationType.fromTop,
//       width: 350,
//       height: 100,
//     ).show(context as BuildContext);
//   }

//   void _displayTransparentMotionToast() {
//     MotionToast(
//       icon: Icons.zoom_out,
//       primaryColor: Colors.grey[400]!,
//       secondaryColor: Colors.yellow,
//       backgroundType: BackgroundType.transparent,
//       title: const Text(
//         'Two Color Motion Toast',
//         style: TextStyle(
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       description: const Text('Another motion toast example'),
//       position: MotionToastPosition.center,
//       width: 350,
//       height: 100,
//     ).show(context as BuildContext);
//   }

//   void _displaySimultaneouslyToasts() {
//     MotionToast.warning(
//       title: const Text(
//         'Warning Motion Toast',
//         style: TextStyle(
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       description: const Text('This is a Warning'),
//       animationCurve: Curves.bounceIn,
//       borderRadius: 0,
//       animationDuration: const Duration(milliseconds: 1000),
//     ).show(context as BuildContext);
//     MotionToast.error(
//       title: const Text(
//         'Error',
//         style: TextStyle(
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       description: const Text('Please enter your name'),
//       animationType: AnimationType.fromLeft,
//       position: MotionToastPosition.top,
//       width: 300,
//       height: 80,
//     ).show(context as BuildContext);
//   }
// }

