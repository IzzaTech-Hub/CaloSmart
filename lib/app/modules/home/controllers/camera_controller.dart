import 'dart:io';
import 'package:calories_detector/app/modules/navbar/controllers/navbar_controller.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

class CameraViewController extends GetxController {
  var cameras = <CameraDescription>[].obs;
  var currentCameraIndex = 0.obs;
  var isCameraInitialized = false.obs;
  CameraController? cameraController;
  Rxn<XFile> capturedImage = Rxn<XFile>();
  Rxn<Uint8List> croppedImageData = Rxn<Uint8List>();
  File? savedCroppedImage; // Store the saved cropped image file
  // final homeController = Get.put(HomeController());

  @override
  void onInit() {
    super.onInit();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    cameras.value = await availableCameras();
    cameraController = CameraController(
      cameras[currentCameraIndex.value],
      ResolutionPreset.high,
    );

    await cameraController?.initialize();
    isCameraInitialized.value = true;
  }

  Future<void> captureImage() async {
    if (!cameraController!.value.isInitialized) {
      print("Camera not initialized");
      return;
    }
    print("Capturing image...");
    capturedImage.value = await cameraController!.takePicture();
    final bytes = await capturedImage.value!.readAsBytes();
    cropImage(bytes);
  }

  void cropImage(Uint8List bytes) async {
    img.Image? originalImage = img.decodeImage(bytes);
    if (originalImage == null) {
      print("Failed to decode image.");
      return;
    }

    double screenWidth = Get.width;
    double screenHeight = Get.height;
    int cropSize = (screenWidth * 1.2).toInt();
    int x = ((originalImage.width - cropSize) ~/ 2)
        .clamp(0, originalImage.width - cropSize);
    int y = ((originalImage.height - cropSize) ~/ 2)
        .clamp(0, originalImage.height - cropSize);

    if (x < 0 ||
        y < 0 ||
        x + cropSize > originalImage.width ||
        y + cropSize > originalImage.height) {
      print("Cropping dimensions are out of bounds.");
      return;
    }

    img.Image croppedImage = img.copyCrop(originalImage,
        x: x, y: y, width: cropSize, height: cropSize);

    croppedImageData.value = Uint8List.fromList(img.encodePng(croppedImage));

    await saveCroppedImage();
    print("Temp Path: ${savedCroppedImage!.path}");
    NavbarController homeController = Get.find();
    Get.back();
    await homeController.sendImageToGoogleAI(savedCroppedImage!);

    // Get.to(() => ImageDisplayScreen(imageData: croppedImageData.value!));
  }

  Future<void> saveCroppedImage() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      String filePath = '${directory.path}/cropped_image.png';

      savedCroppedImage = File(filePath);

      if (await savedCroppedImage!.exists()) {
        await savedCroppedImage!.delete();
        print("Previous cropped image deleted.");
      }

      await savedCroppedImage!.writeAsBytes(croppedImageData.value!);

      print("New cropped image saved successfully at $filePath.");
    } catch (e) {
      print("Error saving cropped image: $e");
    }
  }

  // Send the saved cropped image when the user clicks "ICHECKED"
  Future<void> sendCroppedImage() async {
    if (savedCroppedImage == null) {
      print("No saved cropped image to send.");
      return;
    }

    try {
      // Send the saved file to Google AI via HomeController
      NavbarController homeController = Get.find();

      await homeController.sendImageToGoogleAI(savedCroppedImage!);
      Get.back();
      print("Cropped image sent successfully.");
      // await deleteCroppedImage();
    } catch (e) {
      print("Error sending cropped image: $e");
    }
  }

  Future<void> deleteCroppedImage() async {
    try {
      if (savedCroppedImage != null && await savedCroppedImage!.exists()) {
        await savedCroppedImage!.delete();
        print("Cropped image deleted from temporary area.");
        savedCroppedImage = null; // Reset the file reference
      } else {
        print("Cropped image not found or already deleted.");
      }
    } catch (e) {
      print("Error deleting cropped image: $e");
    }
  }

  Future<void> toggleCamera() async {
    // Ensures the current camera session is stopped before switching
    print("Cameras: ${cameras.length}");
    isCameraInitialized.value = false;
    cameraController?.dispose();

    // Switch camera index
    currentCameraIndex.value = (currentCameraIndex.value + 1) % cameras.length;

    // Reinitialize camera with new index
    initializeCamera();
  }
}
