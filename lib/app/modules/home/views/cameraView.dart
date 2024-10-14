
import 'package:calories_detector/app/modules/home/controllers/camera_controller.dart';
import 'package:calories_detector/sizeConfig.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Cameraview extends GetView<CameraViewController> {
  const Cameraview({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Obx(() {
        if (controller.isCameraInitialized.isTrue) {
          return Column(
            children: [
              SizedBox(
                height: Get.height, // Updated from SizeConfig
                child: Stack(
                  children: [
                    SizedBox(
                        height: SizeConfig.screenHeight,
                        width: SizeConfig.screenWidth,
                        child: CameraPreview(controller.cameraController!)),
                    Positioned.fill(
                      child: SvgPicture.string(
                        '''
                        <svg width="720" height="1600" viewBox="0 0 360 800" fill="none" xmlns="http://www.w3.org/2000/svg">
                          <g clip-path="url(#clip0_2225_556)">
                            <path fill-rule="evenodd" clip-rule="evenodd" d="M219.919 491C219.919 493.761 222.158 496 224.919 496H246C262.569 496 276 482.569 276 466V443.771C276 441.009 273.761 438.771 271 438.771C268.239 438.771 266 441.009 266 443.771V466C266 477.046 257.046 486 246 486H224.919C222.158 486 219.919 488.239 219.919 491ZM219.919 309C219.919 311.761 222.158 314 224.919 314H246C257.046 314 266 322.954 266 334V356.227C266 358.988 268.239 361.227 271 361.227C273.761 361.227 276 358.988 276 356.227V334C276 317.431 262.569 304 246 304H224.919C222.158 304 219.919 306.239 219.919 309ZM137.375 304C140.136 304 142.375 306.239 142.375 309C142.375 311.761 140.136 314 137.375 314H114C102.954 314 94 322.954 94 334V356.227C94 358.988 91.7614 361.227 89 361.227C86.2386 361.227 84 358.988 84 356.227V334C84 317.431 97.4315 304 114 304H137.375ZM137.375 486C140.136 486 142.375 488.239 142.375 491C142.375 493.761 140.136 496 137.375 496H114C97.4315 496 84 482.569 84 466V443.771C84 441.009 86.2386 438.771 89 438.771C91.7614 438.771 94 441.009 94 443.771V466C94 477.046 102.954 486 114 486H137.375Z" fill="white"/>
                            <path fill-rule="evenodd" clip-rule="evenodd" d="M373 0H-13V800H373V0ZM114 304C97.4315 304 84 317.431 84 334V466C84 482.569 97.4315 496 114 496H246C262.569 496 276 482.569 276 466V334C276 317.431 262.569 304 246 304H114Z" fill="black" fill-opacity="0.7"/>
                          </g>
                          <defs>
                            <clipPath id="clip0_2225_556">
                              <rect width="720" height="800" fill="white"/>
                            </clipPath>
                          </defs>
                        </svg>
                        ''',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: cameraControls(context),
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      }),
    );
  }

  Widget cameraControls(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        color: Colors.black,
        padding: EdgeInsets.only(
          bottom: SizeConfig.blockSizeHorizontal * 8.0,
          right: SizeConfig.blockSizeHorizontal * 8.0,
          left: SizeConfig.blockSizeHorizontal * 8.0,
        ),
        child: Container(
          padding: EdgeInsets.only(top: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () => controller.toggleCamera(),
                icon: Icon(
                  Icons.cameraswitch_outlined,
                  size: 35,
                  color: Colors.white,
                ),
              ),
              Container(
                // height: 50,
                // width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.white,
                ),
                child: IconButton(
                  onPressed: () => controller.captureImage(),
                  icon: Icon(
                    Icons.circle_outlined,
                    size: 50,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                width: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}

// class ImageDisplayScreen extends StatelessWidget {
//   final Uint8List imageData;

//   const ImageDisplayScreen({required this.imageData});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Cropped Image Preview'),
//       ),
//       body: Center(
//         child: Image.memory(
//           imageData,
//           fit: BoxFit.contain,
//         ),
//       ),
//       bottomNavigationBar: BottomAppBar(
//         color: Colors.grey[200],
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             IconButton(
//               icon: const Icon(Icons.close),
//               onPressed: () => Get.back(),  // Enable back button navigation
//             ),
//             IconButton(
//               icon: const Icon(Icons.check),
//               onPressed: () {
//                 final cameraController = Get.find<CameraViewController>();
//                 cameraController.sendCroppedImage();  // Send the cropped image
//                 print("Sending cropped image...");
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
