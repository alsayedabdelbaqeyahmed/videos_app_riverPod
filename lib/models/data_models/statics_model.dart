import 'package:video_payer/models/constants/string_constant.dart';

class StatisticsModel {
  StatisticsModel({
    this.viewCount,
    this.likeCount,
    this.favoriteCount,
    this.commentCount,
  });

  String? viewCount;
  String? likeCount;
  String? favoriteCount;
  String? commentCount;

  factory StatisticsModel.fromJson(Map<String, dynamic> json) =>
      StatisticsModel(
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
