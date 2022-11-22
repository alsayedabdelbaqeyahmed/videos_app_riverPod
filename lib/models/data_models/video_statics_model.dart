import 'package:video_payer/models/constants/string_constant.dart';

/// statics of every selected video
class VideoStatisticsModel {
  VideoStatisticsModel({
    this.viewCount,
    this.likeCount,
    this.favoriteCount,
    this.commentCount,
  });

  String? viewCount;
  String? likeCount;
  String? favoriteCount;
  String? commentCount;

  factory VideoStatisticsModel.fromJson(Map<String, dynamic> json) =>
      VideoStatisticsModel(
        viewCount: json[AppStringConstants.viewCount],
        likeCount: json[AppStringConstants.likeCount],
        favoriteCount: json[AppStringConstants.favoriteCount],
        commentCount: json[AppStringConstants.commentCount],
      );

  Map<String, dynamic> toJson() => {
        AppStringConstants.viewCount: viewCount,
        AppStringConstants.likeCount: likeCount,
        AppStringConstants.favoriteCount: favoriteCount,
        AppStringConstants.commentCount: commentCount,
      };
}
