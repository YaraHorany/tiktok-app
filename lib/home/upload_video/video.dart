import 'package:cloud_firestore/cloud_firestore.dart';

class Video {
  String? userId;
  String? userName;
  String? userProfileImage;
  String? videoId;
  int? totalComments;
  int? totalShares;
  List? likesList;
  String? artistSongName;
  String? descriptionTags;
  String? videoUrl;
  String? thumbnailUrl;
  int? publishedDateTime;

  Video({
    this.userId,
    this.userName,
    this.userProfileImage,
    this.videoId,
    this.totalComments,
    this.totalShares,
    this.likesList,
    this.artistSongName,
    this.descriptionTags,
    this.videoUrl,
    this.thumbnailUrl,
    this.publishedDateTime,
  });

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "userName": userName,
        "userProfileImage": userProfileImage,
        "videoId": videoId,
        "totalComments": totalComments,
        "totalShares": totalShares,
        "likesList": likesList,
        "artistSongName": artistSongName,
        "descriptionTags": descriptionTags,
        "videoUrl": videoUrl,
        "thumbnailUrl": thumbnailUrl,
        "publishedDateTime": publishedDateTime,
      };

  static Video fromSnap(DocumentSnapshot snapshot) {
    var docSnapshot = snapshot.data() as Map<String, dynamic>;
    return Video(
      userId: docSnapshot["userId"],
      userName: docSnapshot["userName"],
      userProfileImage: docSnapshot["userProfileImage"],
      videoId: docSnapshot["videoId"],
      totalComments: docSnapshot["totalComments"],
      totalShares: docSnapshot["totalShares"],
      likesList: docSnapshot["likesList"],
      artistSongName: docSnapshot["artistSongName"],
      descriptionTags: docSnapshot["descriptionTags"],
      videoUrl: docSnapshot["videoUrl"],
      thumbnailUrl: docSnapshot["thumbnailUrl"],
      publishedDateTime: docSnapshot["publishedDateTime"],
    );
  }
}
