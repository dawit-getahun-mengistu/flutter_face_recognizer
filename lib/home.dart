import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:objectdetectionapp/utils/custom_buttons.dart';
import 'requests/requests.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _loading = true;
  late File _image;
  final imagePicker = ImagePicker();
  List<dynamic> _predictions = [];

  @override
  void initState() {
    super.initState();
  }

  _uploadImage(File image) async {
    return await uploadImage(image);
  }

  _loadImageGallery() async {
    var image = await imagePicker.pickImage(source: ImageSource.gallery);

    if (image == null) {
      return;
    }

    setState(() {
      _loading = false;
      _image = File(image.path);
    });

    var result = await _uploadImage(_image);

    setState(() {
      _predictions.add(result);
    });
  }

  _loadImageFromCamera() async {
    var image = await imagePicker.pickImage(source: ImageSource.camera);

    if (image == null) {
      return;
    }

    setState(() {
      _loading = false;
      _image = File(image.path);
    });

    var result = await _uploadImage(_image);

    setState(() {
      _predictions.add(result);
    });
  }

  getLastPrediction() {
    return _predictions[_predictions.length - 1];
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.white,
                width: 2.0,
              ),
            ),
          ),
        ),
        title: const Center(
          child:
              Text('Face Recognition', style: TextStyle(color: Colors.white)),
        ),
        elevation: 0.0,
      ),
      body: Container(
        height: h,
        width: w,
        color: Colors.white, // Change background color to white
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 45,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.blueGrey.shade700, // Change button color
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: const BorderSide(color: Colors.white),
                    ),
                  ),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.symmetric(
                        horizontal: 50.0, vertical: 15.0),
                  ),
                  textStyle: MaterialStateProperty.all<TextStyle>(
                    const TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ),
                onPressed: () {
                  _loadImageFromCamera();
                },
                child: const Text('Camera'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.green.shade700, // Change button color
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: const BorderSide(color: Colors.white),
                    ),
                  ),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.symmetric(
                        horizontal: 50.0, vertical: 15.0),
                  ),
                  textStyle: MaterialStateProperty.all<TextStyle>(
                    const TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ),
                onPressed: () {
                  _loadImageGallery();
                },
                child: const Text('Gallery'),
              ),
            ),
            if (!_loading && _predictions.isNotEmpty)
              Column(
                children: [
                  Container(
                    height: h / 2,
                    width: w / 1.5,
                    color: Colors.white,
                    child: Image.file(_image),
                  ),
                  Container(
                    padding: const EdgeInsets.all(18.0),
                    margin: const EdgeInsets.all(18.0),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.shade700,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text(
                      _predictions[_predictions.length - 1]['prediction'],
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

// // import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:objectdetectionapp/utils/custom_buttons.dart';

// import 'requests/requests.dart';

// class Home extends StatefulWidget {
//   const Home({Key? key}) : super(key: key);

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   bool _loading = true;

//   late File _image;
//   final imagePicker = ImagePicker();
//   List<dynamic> _predictions = [];

//   @override
//   void initState() {
//     super.initState();
//   }

//   _uploadImage(File image) async {
//     return await uploadImage(image);
//   }

//   _loadImageGallery() async {
//     var image = await imagePicker.pickImage(source: ImageSource.gallery);

//     if (image == null) {
//       return;
//     }

//     setState(() {
//       _loading = false;
//       _image = File(image.path);
//     });

//     var result = await _uploadImage(_image);

//     setState(() {
//       _predictions.add(result);
//     });
//   }

//   _loadImageFromCamera() async {
//     var image = await imagePicker.pickImage(source: ImageSource.camera);

//     if (image == null) {
//       return;
//     }

//     setState(() {
//       _loading = false;
//       _image = File(image.path);
//     });

//     var result = await _uploadImage(_image);

//     setState(() {
//       _predictions.add(result);
//     });
//   }

//   getLastPrediction() {
//     return _predictions[_predictions.length - 1];
//   }

//   @override
//   Widget build(BuildContext context) {
//     var h = MediaQuery.of(context).size.height;
//     var w = MediaQuery.of(context).size.width;
//     return Scaffold(
//       appBar: AppBar(
//         flexibleSpace: Container(
//           decoration: const BoxDecoration(
//             border: Border(
//               bottom: BorderSide(
//                 color: Colors.white,
//                 width: 2.0,
//               ),
//             ),
//           ),
//         ),
//         title: const Center(
//           child: Text('Freshs or stale', style: TextStyle(color: Colors.white)),
//         ),
//         elevation: 0.0,
//       ),
//       body: Container(
//         height: h,
//         width: w,
//         color: Colors.black,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             // SizedBox(
//             //   height: h / 8,
//             // ),
//             Container(
//               padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 0),
//               child: Text(
//                 'Detect From Image',
//                 style: GoogleFonts.roboto(
//                   fontSize: 20,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: CustomButtons.customButton('Camera', () {
//                 _loadImageFromCamera();
//               }),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: CustomButtons.customButton('Gallery', () {
//                 _loadImageGallery();
//               }),
//               // child: PickButton(),
//             ),
//             if (!_loading && _predictions.isNotEmpty)
//               Column(
//                 children: [
//                   Container(
//                     height: h / 2,
//                     width: w / 1.5,
//                     // height: Image.file(_image).height! / 8,
//                     // width: Image.file(_image).width! / 8,
//                     color: Colors.white,
//                     child: Image.file(_image),
//                   ),
//                   Container(
//                     padding: const EdgeInsets.all(8.0),
//                     margin: const EdgeInsets.all(8.0),
//                     decoration: BoxDecoration(
//                       color: Colors.purple.shade900,
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                     child: Text(
//                       _predictions[_predictions.length - 1].toString(),
//                       style: const TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ],
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   ElevatedButton PickButton() {
//     return ElevatedButton(
//       style: ButtonStyle(
//         backgroundColor:
//             MaterialStateProperty.all<Color>(Colors.purple.shade900),
//         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//           RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(18.0),
//             side: const BorderSide(color: Colors.white),
//           ),
//         ),
//         padding: MaterialStateProperty.all<EdgeInsets>(
//           const EdgeInsets.symmetric(horizontal: 100.0, vertical: 20.0),
//         ),
//         textStyle: MaterialStateProperty.all<TextStyle>(
//           const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
//         ),
//       ),
//       onPressed: () {
//         _loadImageGallery();
//       },
//       child: const Text('Gallery'),
//     );
//   }
// }
