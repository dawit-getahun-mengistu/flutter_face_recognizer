import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:objectdetectionapp/screens/view_image.dart';

class CameraAPP extends StatefulWidget {
  const CameraAPP(this.cameras, {super.key});
  final List<CameraDescription> cameras;

  @override
  State<CameraAPP> createState() => _CameraAPPState();
}

class _CameraAPPState extends State<CameraAPP> {
  late CameraController _controller;

  @override
  void initState() {
    // implement initState
    super.initState();
    _controller = CameraController(widget.cameras[0], ResolutionPreset.max);
    _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            print("access was denied");
            break;
          default:
            print(e.description);
            break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    XFile picture;
    return Scaffold(
        // implemnting the camera
        body: Stack(
      children: [
        SizedBox(
          height: double.infinity,
          child: CameraPreview(_controller),
        ),
        // Add button to take picture
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                  margin: const EdgeInsets.all(20.0),
                  child: MaterialButton(
                    onPressed: () async {
                      BuildContext currentcontext = context;

                      if (!_controller.value.isInitialized) {
                        return;
                      }
                      if (_controller.value.isTakingPicture) {
                        return;
                      }
                      try {
                        await _controller.setFlashMode(FlashMode.auto);
                        picture = await _controller.takePicture();
                        // create another screen to display image
                        Navigator.push(
                            currentcontext,
                            MaterialPageRoute(
                                builder: (context) => ImagePreview(picture)));
                      } on CameraException catch (e) {
                        debugPrint("Error occured while taking picture: $e ");
                        return;
                      }
                    },
                    color: Colors.white,
                    child: const Text('Take a picture'),
                  )),
            )
          ],
        )
      ],
    ));
  }
}
