import 'dart:async';
import 'dart:io';
import 'package:energy_chleen/data/controllers/api_service.dart';
import 'package:energy_chleen/data/controllers/auth_controller.dart';
import 'package:energy_chleen/screens/navbar/appbars.dart';
import 'package:energy_chleen/utils/Helper.dart';
import 'package:energy_chleen/utils/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';


class ItemConfirmation extends StatefulWidget {
  const ItemConfirmation({super.key});

  @override
  State<ItemConfirmation> createState() => _ItemConfirmationState();
}

class _ItemConfirmationState extends State<ItemConfirmation> {
  bool isLoading =false;

// load save data from shared

Future<void> _loadScheduleData() async {
  setState(() {
    isLoading = true; // Start loading
  });

  try {
    StorageService storageService = StorageService();

    // Load pickup details and waste details
    Map<String, dynamic> wasteItems =
        await storageService.loadWasteItem();
    Map<String, dynamic> pickupDetails =
        await storageService.loadPickupDetails();
    Map<String, dynamic> wasteDetails =
        await storageService.loadWasteDetails();

    int? cityId = pickupDetails['cityId'] is int
        ? pickupDetails['cityId']
        : int.tryParse(pickupDetails['cityId'].toString());

    int? stateId = pickupDetails['stateId'] is int
        ? pickupDetails['stateId']
        : int.tryParse(pickupDetails['stateId'].toString());

    if (cityId == null || stateId == null) {
      throw Exception(
          "Invalid cityId or stateId: cityId = $cityId, stateId = $stateId");
    }

// int? categoryId = AuthController.instance.wasteDetails.value?.categoryId;

// // Debugging print statements to check values
// print("wasteDetails: ${AuthController.instance.wasteDetails.value}");
// print("categoryId: $categoryId");

// if (categoryId == null) {
//   throw Exception(
//       "categoryId is null. Ensure categoryId is set properly.");
// }

await ApiService.instance.createPost(
  date: pickupDetails['pickupDate'],
  address: pickupDetails['pickupAddress'],
  cityId: cityId,
  stateId: stateId,
  pickupType: 'Home', //pickupDetails['pickupOption']
  wasteItems: [
    {
      "waste_item_id": AuthController.instance.wasteDetails.value!.id,
      "name": wasteItems['wasteType'],
      "totalWeight": wasteDetails['weight']
    },
  ],
  images: _imageFiles,
  videos: _videoFiles, context: context,
);


    setState(() {
      isLoading = false; // End loading after successful completion
    });
  } catch (e) {
    debugPrint("Error loading data: $e");

    setState(() {
      isLoading = false; // End loading in case of error
    });
  }
}

Future<void> requestPermissions() async {
  if (await Permission.camera.request().isGranted &&
      await Permission.storage.request().isGranted) {
    // Permissions granted, proceed with image picking
    await _takePhoto();
    await _pickVideo();
  } else {
    // Permissions denied, show a message to the user
  }
}



final ImagePicker _picker = ImagePicker();
List<File> _imageFiles = []; // List to hold selected images

// Capture a photo from the camera
// Capture a photo from the camera
Future<void> _takePhoto() async {
  if (_imageFiles.length >= 4) {
    // Limit to 4 images
    print("You can only select up to 4 images.");
    return;
  }

  try {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      File newImage = File(photo.path);

      // Check if the file exists before adding
      if (await newImage.exists()) {
        setState(() {
          _imageFiles.add(newImage); // Add the image to the list
        });
        print('Image captured and added to list successfully.');
      } else {
        print("Error: Captured image file does not exist.");
      }
    }
  } catch (e) {
    // Handle any errors during image capture
    print("Error capturing photo: $e");
  }
}



  // Function to pick videos
  List<File> _videoFiles = [];
  
  get http => null;

  Future<void> _pickVideo() async {
      if (_videoFiles.length >= 1) {
    // Limit to 4 images
    print("You can only select up to 1 video.");
    return;
  }

  try {
    final XFile? video = await _picker.pickVideo(source: ImageSource.camera);
    if (video != null) {
      File newvideo = File(video.path);
            if (await newvideo.exists()) {
        setState(() {
          _imageFiles.add(newvideo); // Add the image to the list
        });
        print('Video captured and added to list successfully.');
      } else {
        print("Video: Captured image file does not exist.");
      }
    }
  } catch (e) {
    print("Error capturing video: $e");
  }
    }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar1(title: 'Item Confirmation'),
        body: SingleChildScrollView(
          child: Column(
            children: [
              RecyclingScheduleProgress(
                isReviewing: true,
                isCompleted: false,
                isTakingPhoto: true,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Take Photos 4 photos'),
                    SizedBox(
                      height: 20,
                    ),
          
                    Text('⚠ Important'),
                    SizedBox(
                      height: 20,
                    ),
                                        GestureDetector(
                      onTap: _takePhoto, // Trigger photo capture
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(16)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.camera_alt_outlined),
                            Text('Take Photos')
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // Display images taken
                    SizedBox(
                      height: 140,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _imageFiles.length,
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 10),
                                width: 70,
                                height: 140,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: FileImage(_imageFiles[index]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 4,
                                right: 4,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _imageFiles.removeAt(index); // Remove image
                                    });
                                  },
                                  child: Icon(Icons.cancel, color: Colors.red),
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    ),
                    // GestureDetector(
                    //   onTap: _pickVideo, // Trigger photo capture
                    //   child: Container(
                    //     height: MediaQuery.of(context).size.height * 0.2,
                    //     width: MediaQuery.of(context).size.width,
                    //     decoration: BoxDecoration(
                    //         border: Border.all(color: Colors.grey),
                    //         borderRadius: BorderRadius.circular(16)),
                    //     child: Column(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         Icon(Icons.video_camera_back_outlined),
                    //         Text('Make A Video')
                    //       ],
                    //     ),
                    //   ),
                    // ),

                    // Add functionality to remove videos
                    // SizedBox(
                    //   height: 140,
                    //   child: ListView.builder(
                    //     scrollDirection: Axis.horizontal,
                    //     itemCount: _videoFiles.length,
                    //     itemBuilder: (context, index) {
                    //       return Stack(
                    //         children: [
                    //           // Similar to images, display video thumbnails or placeholders
                    //           Container(
                    //             margin: EdgeInsets.only(right: 10),
                    //             width: 70,
                    //             height: 140,
                    //             decoration: BoxDecoration(
                    //               borderRadius: BorderRadius.circular(8),
                    //               image: DecorationImage(
                    //                 image: FileImage(_videoFiles[index]),
                    //                 fit: BoxFit.cover,
                    //               ),
                    //             ),
                    //           ),
                    //           Positioned(
                    //             top: 4,
                    //             right: 4,
                    //             child: GestureDetector(
                    //               onTap: () {
                    //                 setState(() {
                    //                   _videoFiles.removeAt(index); // Remove video
                    //                 });
                    //               },
                    //               child: Icon(Icons.cancel, color: Colors.red),
                    //             ),
                    //           ),
                    //         ],
                    //       );
                    //     },
                    //   ),
                    // ),

                    SizedBox(height: 20,),

                    // Show the Finish button only if 4 photos are taken
                    Visibility(
                      visible: _imageFiles.length >= 2,
                      child: GestureDetector(
                        onTap: () {
                          // Handle finish action
                          _loadScheduleData();
                        },
                        child: Container(
                          padding: EdgeInsets.all(16),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Customcolors.teal),
                          child: Text(
                            textAlign: TextAlign.center,
                            'Finish',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
