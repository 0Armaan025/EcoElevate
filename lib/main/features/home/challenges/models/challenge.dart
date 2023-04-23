// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ChallengeModel {
  String challengeName;
  String videoUrl;
  String uid;
  String userName;
  String userProfilePicture;
  ChallengeModel({
    required this.challengeName,
    required this.videoUrl,
    required this.uid,
    required this.userName,
    required this.userProfilePicture,
  });

  ChallengeModel copyWith({
    String? challengeName,
    String? videoUrl,
    String? uid,
    String? userName,
    String? userProfilePicture,
  }) {
    return ChallengeModel(
      challengeName: challengeName ?? this.challengeName,
      videoUrl: videoUrl ?? this.videoUrl,
      uid: uid ?? this.uid,
      userName: userName ?? this.userName,
      userProfilePicture: userProfilePicture ?? this.userProfilePicture,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'challengeName': challengeName,
      'videoUrl': videoUrl,
      'uid': uid,
      'userName': userName,
      'userProfilePicture': userProfilePicture,
    };
  }

  factory ChallengeModel.fromMap(Map<String, dynamic> map) {
    return ChallengeModel(
      challengeName: map['challengeName'] as String,
      videoUrl: map['videoUrl'] as String,
      uid: map['uid'] as String,
      userName: map['userName'] as String,
      userProfilePicture: map['userProfilePicture'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChallengeModel.fromJson(String source) =>
      ChallengeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChallengeModel(challengeName: $challengeName, videoUrl: $videoUrl, uid: $uid, userName: $userName, userProfilePicture: $userProfilePicture)';
  }

  @override
  bool operator ==(covariant ChallengeModel other) {
    if (identical(this, other)) return true;

    return other.challengeName == challengeName &&
        other.videoUrl == videoUrl &&
        other.uid == uid &&
        other.userName == userName &&
        other.userProfilePicture == userProfilePicture;
  }

  @override
  int get hashCode {
    return challengeName.hashCode ^
        videoUrl.hashCode ^
        uid.hashCode ^
        userName.hashCode ^
        userProfilePicture.hashCode;
  }
}
