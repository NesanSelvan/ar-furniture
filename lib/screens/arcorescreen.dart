// import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:vector_math/vector_math_64.dart';

// class ArCoreScreen extends StatefulWidget {
//   @override
//   _ArCoreScreenState createState() => _ArCoreScreenState();
// }

// class _ArCoreScreenState extends State<ArCoreScreen> {
//   ArCoreController? arCoreController;
//   String? model;
//   String? objectSelected;
//   @override
//   void initState() {
//     super.initState();
//     FirebaseFirestore.instance.runTransaction((transaction) async {
//       final val = await FirebaseFirestore.instance.collection('models').get();

//       model = val.docs[1].data()["url"];
//       print(model);
//       for (var element in val.docs) {
//         final dataInDB = element.data();
//         print("length" + dataInDB.length.toString());
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Custom Object on plane detected'),
//         ),
//         body: ArCoreView(
//           onArCoreViewCreated: _onArCoreViewCreated,
//           enableTapRecognizer: true,
//         ),
//       ),
//     );
//   }

//   void _onArCoreViewCreated(ArCoreController controller) {
//     arCoreController = controller;
//     arCoreController?.onNodeTap = (name) => onTapHandler(name);
//     arCoreController?.onPlaneTap = _handleOnPlaneTap;
//   }

//   void _addToucano(ArCoreHitTestResult plane) {
//     final toucanNode = ArCoreReferenceNode(
//         name: "Toucano",
//         objectUrl:
//             // "https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/Duck/glTF/Duck.gltf",
//             // model.toString(),
//             "https://github.com/NesanSelvan/3dmodels/raw/main/untitled1.glb",
//         scale: Vector3(0.5, 0.5, 0.5),
//         position: plane.pose.translation,
//         rotation: plane.pose.rotation);

//     arCoreController?.addArCoreNodeWithAnchor(toucanNode);
//   }

//   void _handleOnPlaneTap(List<ArCoreHitTestResult> hits) {
//     final hit = hits.first;
//     _addToucano(hit);
//   }

//   void onTapHandler(String name) {
//     print("Flutter: onNodeTap");
//     showDialog<void>(
//       context: context,
//       builder: (BuildContext context) => AlertDialog(
//         content: Row(
//           children: <Widget>[
//             Text('Remove $name?'),
//             IconButton(
//                 icon: Icon(
//                   Icons.delete,
//                 ),
//                 onPressed: () {
//                   arCoreController?.removeNode(nodeName: name);
//                   Navigator.pop(context);
//                 })
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     arCoreController?.dispose();
//     super.dispose();
//   }
// }
