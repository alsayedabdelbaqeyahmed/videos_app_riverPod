import 'package:video_payer/models/constants/string_constant.dart';
import 'package:video_payer/models/data_models/search_videos_model.dart';
import 'package:video_payer/models/data_models/video_statics_model.dart';

class YoutubeChannelModel {
  VideoStatisticsModel? statisticsModel;
  SnippetModels? snippetModel;
  YoutubeChannelModel({this.snippetModel, this.statisticsModel});

  factory YoutubeChannelModel.fromJson(Map<String, dynamic> map) {
    return YoutubeChannelModel(
        snippetModel: map[AppStringConstants.snippet],
        statisticsModel: map[AppStringConstants.statistics]);
  }
}
