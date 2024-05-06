import 'dart:io';
import 'package:flutter/material.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:tiktok_app/home/upload_video/upload_controller.dart';
import 'package:video_player/video_player.dart';
import '../../global.dart';
import '../../widgets/text_form_field.dart';
import 'package:get/get.dart';

class UploadForm extends StatefulWidget {
  final File videoFile;
  final String videoPath;

  const UploadForm({
    Key? key,
    required this.videoFile,
    required this.videoPath,
  }) : super(key: key);

  @override
  State<UploadForm> createState() => _UploadFormState();
}

class _UploadFormState extends State<UploadForm> {
  VideoPlayerController? playerController;

  final UploadController uploadController = Get.put(UploadController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      playerController = VideoPlayerController.file(widget.videoFile);
    });

    playerController!.initialize();
    playerController!.play();
    playerController!.setVolume(2);
    playerController!.setLooping(true);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    playerController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // display video player
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.4,
              child: VideoPlayer(playerController!),
            ),

            const SizedBox(height: 30),

            // Upload Now button if user clicked.
            // Circular progress bar
            // Input fields
            showProgressBar == true
                ? Container(
                    child: const SimpleCircularProgressBar(
                    progressColors: [
                      Colors.green,
                      Colors.blueAccent,
                      Colors.red,
                      Colors.amber,
                      Colors.purpleAccent,
                    ],
                    animationDuration: 20,
                    backColor: Colors.white38,
                  ))
                : Column(
                    children: [
                      // Artist-song

                      InputTextField(
                          controller: uploadController.artistSongs,
                          iconData: const Icon(Icons.email_outlined),
                          fieldName: "Artist - Song"),

                      const SizedBox(height: 20),

                      // Description tags
                      InputTextField(
                          controller: uploadController.descriptionTags,
                          iconData: const Icon(Icons.email_outlined),
                          fieldName: "Description - Tags"),

                      const SizedBox(height: 20),

                      // Sign Up button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white70)),
                          onPressed: () {
                            if (uploadController.artistSongs.text.isNotEmpty &&
                                uploadController
                                    .descriptionTags.text.isNotEmpty) {
                              uploadController
                                  .saveVideoInformationToFireStoreDatabase(
                                uploadController.artistSongs.text,
                                uploadController.descriptionTags.text,
                                widget.videoPath,
                                context,
                              );
                            }
                          },
                          child: const Text(
                            "Upload Now",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
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
