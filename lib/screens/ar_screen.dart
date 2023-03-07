import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin/datatypes/config_planedetection.dart';
import 'package:ar_flutter_plugin/datatypes/hittest_result_types.dart';
import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/models/ar_anchor.dart';
import 'package:ar_flutter_plugin/models/ar_hittest_result.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';

class ArScreen extends StatefulWidget {
  final String url;
  ArScreen({Key? key, required this.url}) : super(key: key);
  @override
  _ArScreenState createState() => _ArScreenState();
}

class _ArScreenState extends State<ArScreen> {
  // Firebase stuff
  Map<String, Map> anchorsInDownloadProgress = Map<String, Map>();

  ARSessionManager? arSessionManager;
  ARObjectManager? arObjectManager;
  ARAnchorManager? arAnchorManager;
  ARLocationManager? arLocationManager;

  List<ARNode> nodes = [];
  List<ARAnchor> anchors = [];
  String lastUploadedAnchor = "";
  bool? isobjadded = false;

  bool readyToUpload = false;
  bool readyToDownload = true;
  String? model;
  @override
  void dispose() {
    super.dispose();
    arSessionManager!.dispose();
  }

  @override
  void initState() {
    super.initState();
    print(widget.url);
    // FirebaseFirestore.instance.runTransaction((transaction) async {
    //   final val = await FirebaseFirestore.instance.collection('models').get();

    //   model = val.docs[1].data()["url"];
    //   print(model);
    //   for (var element in val.docs) {
    //     final dataInDB = element.data();
    //     print("length" + dataInDB.length.toString());
    //   }
    // });
  }

  // void firestore() {
  //   StreamBuilder(
  //     stream: FirebaseFirestore.instance.collection('models').snapshots(),
  //     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
  //       snapshot.data!.docs.map((document) {
  //         model = document.data().toString();
  //         print(document.data());
  //       });
  //     },
  //   );
  // }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Cloud Anchors'),
//         ),
//         body: Container(
//             child: Stack(children: [
//           ARView(
//             onARViewCreated: onARViewCreated,
//             planeDetectionConfig: PlaneDetectionConfig.horizontalAndVertical,
//           ),
//           Align(
//             alignment: FractionalOffset.bottomCenter,
//             child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   ElevatedButton(
//                       onPressed: onRemoveEverything,
//                       child: Text(" Remove Everything")),
//                 ]),
//           ),
//         ])));
//   }

//   void onARViewCreated(
//       ARSessionManager arSessionManager,
//       ARObjectManager arObjectManager,
//       ARAnchorManager arAnchorManager,
//       ARLocationManager arLocationManager) {
//     this.arSessionManager = arSessionManager;
//     this.arObjectManager = arObjectManager;
//     this.arAnchorManager = arAnchorManager;
//     this.arLocationManager = arLocationManager;
//     this.arSessionManager!.onPlaneOrPointTap = onPlaneOrPointTapped;
//     this.arObjectManager!.onPanStart = onPanStarted;
//     this.arObjectManager!.onPanChange = onPanChanged;
//     this.arObjectManager!.onPanEnd = onPanEnded;
//     this.arObjectManager!.onRotationStart = onRotationStarted;
//     this.arObjectManager!.onRotationChange = onRotationChanged;
//     this.arObjectManager!.onRotationEnd = onRotationEnded;
//     this.arSessionManager!.onInitialize(
//           showFeaturePoints: false,
//           showPlanes: true,
//           customPlaneTexturePath: "Images/triangle.png",
//           showWorldOrigin: true,
//         );
//     this.arObjectManager!.onInitialize();

//     this.arSessionManager!.onPlaneOrPointTap = onPlaneOrPointTapped;
//     this.arObjectManager!.onNodeTap = onNodeTapped;

//     this
//         .arLocationManager!
//         .startLocationUpdates()
//         .then((value) => null)
//         .onError((error, stackTrace) {
//       switch (error.toString()) {
//         case 'Location services disabled':
//           {
//             showAlertDialog(
//                 context,
//                 "Action Required",
//                 "To use cloud anchor functionality, please enable your location services",
//                 "Settings",
//                 this.arLocationManager!.openLocationServicesSettings,
//                 "Cancel");
//             break;
//           }

//         case 'Location permissions denied':
//           {
//             showAlertDialog(
//                 context,
//                 "Action Required",
//                 "To use cloud anchor functionality, please allow the app to access your device's location",
//                 "Retry",
//                 this.arLocationManager!.startLocationUpdates,
//                 "Cancel");
//             break;
//           }

//         case 'Location permissions permanently denied':
//           {
//             showAlertDialog(
//                 context,
//                 "Action Required",
//                 "To use cloud anchor functionality, please allow the app to access your device's location",
//                 "Settings",
//                 this.arLocationManager!.openAppPermissionSettings,
//                 "Cancel");
//             break;
//           }

//         default:
//           {
//             this.arSessionManager!.onError(error.toString());
//             break;
//           }
//       }
//       this.arSessionManager!.onError(error.toString());
//     });
//   }

//   Future<void> onRemoveEverything() async {
//     isobjadded = false;
//     anchors.forEach((anchor) {
//       this.arAnchorManager!.removeAnchor(anchor);
//     });

//     anchors = [];
//     if (lastUploadedAnchor != "") {
//       setState(() {
//         readyToDownload = true;
//         readyToUpload = false;
//       });
//     } else {
//       setState(() {
//         readyToDownload = true;
//         readyToUpload = false;
//       });
//     }
//   }

//   Future<void> onNodeTapped(List<String> nodeNames) async {
//     var foregroundNode =
//         nodes.firstWhere((element) => element.name == nodeNames.first);
//     this.arSessionManager!.onError(foregroundNode.data!["onTapText"]);
//   }

//   Future<void> onPlaneOrPointTapped(
//       List<ARHitTestResult> hitTestResults) async {
//     var singleHitTestResult = hitTestResults.firstWhere(
//         (hitTestResult) => hitTestResult.type == ARHitTestResultType.plane);

//     var newAnchor = ARPlaneAnchor(
//         transformation: singleHitTestResult.worldTransform, ttl: 2);
//     bool? didAddAnchor = await this.arAnchorManager!.addAnchor(newAnchor);
//     if (didAddAnchor ?? false) {
//       this.anchors.add(newAnchor);
//       // this.arObjectManager.onPanStart
//       // Add note to anchor
//       this.arObjectManager!.onPanStart = onPanStarted;
//       this.arObjectManager!.onPanChange = onPanChanged;
//       this.arObjectManager!.onPanEnd = onPanEnded;

//       // this
//       //       .arObjectManager!.onRotationChange =
//       var newNode = ARNode(
//           type: NodeType.webGLB,
//           uri: widget.url,
//           //"https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/Duck/glTF/Duck.gltf ",
//           // "https://github.com/NesanSelvan/3dmodels/raw/main/sofa1.glb",
//           // model.toString(),
//           scale: Vector3(0.5, 0.5, 0.5),
//           position: Vector3(0.0, 0.0, 0.0),
//           rotation: Vector4(1.0, 0.0, 0.0, 0.0),
//           data: {"onTapText": "Ouch, that hurt!"});
//       if (isobjadded == false) {
//         bool? didAddNodeToAnchor = await this
//             .arObjectManager!
//             .addNode(newNode, planeAnchor: newAnchor);
//         isobjadded = true;

//         if (didAddNodeToAnchor ?? false) {
//           this.nodes.add(newNode);
//           setState(() {
//             readyToUpload = true;
//           });
//         } else {
//           this.arSessionManager!.onError("Adding Node to Anchor failed");
//         }
//       } else {
//         this.arSessionManager!.onError("Adding Anchor failed");
//       }
//     }
//   }

//   onPanStarted(String nodeName) {
//     print("Started panning node " + nodeName);
//     final pannedNode =
//         this.nodes.firstWhere((element) => element.name == nodeName);
// //  pannedNode.scale = Vector3.all(0.5);
//   }

//   onPanChanged(String nodeName) {
//     print("Continued panning node " + nodeName);
//   }

//   onPanEnded(String nodeName, Matrix4 newTransform) {
//     print("Ended panning node " + nodeName);
//     final pannedNode =
//         this.nodes.firstWhere((element) => element.name == nodeName);
//     pannedNode.scale = Vector3.all(0.5);

//     /*
//     * Uncomment the following command if you want to keep the transformations of the Flutter representations of the nodes up to date
//     * (e.g. if you intend to share the nodes through the cloud)
//     */
//     //pannedNode.transform = newTransform;
//   }

//   onRotationStarted(String nodeName) {
//     print("Started rotating node " + nodeName);
//   }

//   onRotationChanged(String nodeName) {
//     print("Continued rotating node " + nodeName);
//   }

//   onRotationEnded(String nodeName, Matrix4 newTransform) {
//     print("Ended rotating node " + nodeName);
//     final rotatedNode =
//         this.nodes.firstWhere((element) => element.name == nodeName);
//     rotatedNode.rotation = Matrix3.rotationY(21);
//     /*
//     * Uncomment the following command if you want to keep the transformations of the Flutter representations of the nodes up to date
//     * (e.g. if you intend to share the nodes through the cloud)
//     */
//     //rotatedNode.transform = newTransform;
//   }

//   void showAlertDialog(BuildContext context, String title, String content,
//       String buttonText, Function buttonFunction, String cancelButtonText) {
//     // set up the buttons
//     Widget cancelButton = ElevatedButton(
//       child: Text(cancelButtonText),
//       onPressed: () {
//         Navigator.of(context).pop();
//       },
//     );
//     Widget actionButton = ElevatedButton(
//       child: Text(buttonText),
//       onPressed: () {
//         buttonFunction();
//         Navigator.of(context).pop();
//       },
//     );

//     // set up the AlertDialog
//     AlertDialog alert = AlertDialog(
//       title: Text(title),
//       content: Text(content),
//       actions: [
//         cancelButton,
//         actionButton,
//       ],
//     );

//     // show the dialog
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return alert;
//       },
//     );
//   }
// }

// // Class for managing interaction with Firebase (in your own app, this can be put in a separate file to keep everything clean and tidy)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Object Transformation Gestures'),
        ),
        body: Container(
            child: Stack(children: [
          ARView(
            onARViewCreated: onARViewCreated,
            planeDetectionConfig: PlaneDetectionConfig.horizontalAndVertical,
          ),
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: onRemoveEverything,
                      child: Text("Remove Everything")),
                ]),
          )
        ])));
  }

  void onARViewCreated(
      ARSessionManager arSessionManager,
      ARObjectManager arObjectManager,
      ARAnchorManager arAnchorManager,
      ARLocationManager arLocationManager) {
    this.arSessionManager = arSessionManager;
    this.arObjectManager = arObjectManager;
    this.arAnchorManager = arAnchorManager;

    this.arSessionManager!.onInitialize(
          showFeaturePoints: false,
          showPlanes: true,
          customPlaneTexturePath: "Images/triangle.png",
          showWorldOrigin: true,
          handlePans: true,
          handleRotation: true,
        );
    this.arObjectManager!.onInitialize();

    this.arSessionManager!.onPlaneOrPointTap = onPlaneOrPointTapped;
    this.arObjectManager!.onPanStart = onPanStarted;
    this.arObjectManager!.onPanChange = onPanChanged;
    this.arObjectManager!.onPanEnd = onPanEnded;
    this.arObjectManager!.onRotationStart = onRotationStarted;
    this.arObjectManager!.onRotationChange = onRotationChanged;
    this.arObjectManager!.onRotationEnd = onRotationEnded;
  }

  Future<void> onRemoveEverything() async {
    /*nodes.forEach((node) {
      this.arObjectManager.removeNode(node);
    });*/
    isobjadded = false;
    anchors.forEach((anchor) {
      this.arAnchorManager!.removeAnchor(anchor);
    });
    anchors = [];
  }

  Future<void> onPlaneOrPointTapped(
      List<ARHitTestResult> hitTestResults) async {
    var singleHitTestResult = hitTestResults.firstWhere(
        (hitTestResult) => hitTestResult.type == ARHitTestResultType.plane);
    var newAnchor =
        ARPlaneAnchor(transformation: singleHitTestResult.worldTransform);
    bool? didAddAnchor = await this.arAnchorManager!.addAnchor(newAnchor);
    if (didAddAnchor!) {
      this.anchors.add(newAnchor);
      // Add note to anchor
      var newNode = ARNode(
          type: NodeType.webGLB,
          uri: widget.url,
          //"https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/Duck/glTF-Binary/Duck.glb",
          scale: Vector3(0.5, 0.5, 0.5),
          position: Vector3(0.0, 0.0, 0.0),
          rotation: Vector4(1.0, 0.0, 0.0, 0.0));
      if (isobjadded == false) {
        isobjadded = true;
        bool? didAddNodeToAnchor = await this
            .arObjectManager!
            .addNode(newNode, planeAnchor: newAnchor);
        if (didAddNodeToAnchor!) {
          this.nodes.add(newNode);
        } else {
          this.arSessionManager!.onError("Adding Node to Anchor failed");
        }
      } else {
        this.arSessionManager!.onError("Adding Anchor failed");
      }
    }
  }

  onPanStarted(String nodeName) {
    print("Started panning node " + nodeName);
  }

  onPanChanged(String nodeName) {
    print("Continued panning node " + nodeName);
  }

  onPanEnded(String nodeName, Matrix4 newTransform) {
    print("Ended panning node " + nodeName);
    final pannedNode =
        this.nodes.firstWhere((element) => element.name == nodeName);
    // pannedNode.scale = Vector3.all(newTransform);
    /*
    * Uncomment the following command if you want to keep the transformations of the Flutter representations of the nodes up to date
    * (e.g. if you intend to share the nodes through the cloud)
    */
    //pannedNode.transform = newTransform;
  }

  onRotationStarted(String nodeName) {
    print("Started rotating node " + nodeName);
  }

  onRotationChanged(String nodeName) {
    print("Continued rotating node " + nodeName);
  }

  onRotationEnded(String nodeName, Matrix4 newTransform) {
    print("Ended rotating node " + nodeName);
    final rotatedNode =
        this.nodes.firstWhere((element) => element.name == nodeName);

    /*
    * Uncomment the following command if you want to keep the transformations of the Flutter representations of the nodes up to date
    * (e.g. if you intend to share the nodes through the cloud)
    */
    //rotatedNode.transform = newTransform;
  }
}
