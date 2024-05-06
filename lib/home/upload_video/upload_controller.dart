import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tiktok_app/global.dart';
import 'package:tiktok_app/home/home_screen.dart';
import 'package:tiktok_app/home/upload_video/video.dart';
import 'package:video_compress/video_compress.dart';

class UploadController extends GetxController {
  // TextField Controllers to get data from TextFields
  final artistSongs = TextEditingController();
  final descriptionTags = TextEditingController();

  compressVideoFile(String videoFilePath) async {
    final compressedVideoFile = await VideoCompress.compressVideo(
      videoFilePath,
      quality: VideoQuality.LowQuality,
    );
    return compressedVideoFile!.file;
  }

  Future<String> uploadCompressedVideoFileToFirebaseStorage(
      String videoId, String videoFilePath) async {
    // Uploading a compressedVideoFile to "All Videos" folder by the file Id.
    UploadTask videoUploadTask = FirebaseStorage.instance
        .ref()
        .child("All Videos")
        .child(videoId)
        .putFile(await compressVideoFile(videoFilePath));

    TaskSnapshot snapshot = await videoUploadTask;

    String downloadUrlOfUploadedVideo = await snapshot.ref.getDownloadURL();

    return downloadUrlOfUploadedVideo;
  }

  Future<File> getThumbnailImage(String videoFilePath) async {
    // Get the thumbnail image from the video
    final thumbnailImage = await VideoCompress.getFileThumbnail(videoFilePath);
    return thumbnailImage;
  }

  Future<String> uploadThumbnailImageToFirebaseStorage(
      String videoId, String videoFilePath) async {
    // Uploading a compressedVideoFile to "All Videos" folder by the file Id.
    UploadTask thumbnailImageUploadTask = FirebaseStorage.instance
        .ref()
        .child("All Thumbnails")
        .child(videoId)
        .putFile(await getThumbnailImage(videoFilePath));

    TaskSnapshot snapshot = await thumbnailImageUploadTask;

    String downloadUrlOfUploadedThumbnail = await snapshot.ref.getDownloadURL();

    return downloadUrlOfUploadedThumbnail;
  }

  saveVideoInformationToFireStoreDatabase(
    String artistSongName,
    String descriptionTags,
    String videoFilePath,
    BuildContext context,
  ) async {
    try {
      DocumentSnapshot userDocumentSnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      String videoId = DateTime.now().millisecondsSinceEpoch.toString();

      // 1. upload video to storage
      String videoDownloadUrl =
          await uploadCompressedVideoFileToFirebaseStorage(
              videoId, videoFilePath);

      // 2. upload thumbnail to storage
      String thumbnailDownloadUrl =
          await uploadThumbnailImageToFirebaseStorage(videoId, videoFilePath);

      // 3. Save overall video info to fireStore database.
      Video videoObject = Video(
        userId: FirebaseAuth.instance.currentUser!.uid,
        userName: (userDocumentSnapshot.data() as Map<String, dynamic>)["name"],
        userProfileImage:
            (userDocumentSnapshot.data() as Map<String, dynamic>)["image"],
        videoId: videoId,
        totalComments: 0,
        totalShares: 0,
        likesList: [],
        artistSongName: artistSongName,
        descriptionTags: descriptionTags,
        videoUrl: videoDownloadUrl,
        thumbnailUrl: thumbnailDownloadUrl,
        publishedDateTime: DateTime.now().millisecondsSinceEpoch,
      );

      await FirebaseFirestore.instance
          .collection("videos")
          .doc(videoId)
          .set(videoObject.toJson());

      showProgressBar = false;

      Get.to(() => HomeScreen());
      Get.snackbar("New video", "You have successfully uploaded new video");
    } catch (errorMsg) {
      Get.snackbar(
        "Video upload Unsuccessful",
        "Error occurred, Your video is not uploaded. Try Again.",
      );
    }
  }
}
