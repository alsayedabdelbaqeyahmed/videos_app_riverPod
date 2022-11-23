// ignore_for_file: unused_local_variable, avoid_print, use_rethrow_when_possible, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:video_payer/models/data_models/search_videos_model.dart';
import 'package:video_payer/models/data_models/video_statics_model.dart';
import 'package:video_payer/models/data_models/youtube_channel_model.dart';
import 'package:video_payer/models/http_helper/http_helper.dart';

class VideoInfoController extends ChangeNotifier {
  final ItemsModel? video;

  VideoInfoController({this.video});

  VideoStatisticsModel? videoStatistics = VideoStatisticsModel();
  YoutubeChannelModel? youtubechannel = YoutubeChannelModel();

// when init start and get the video to find the info
  void onInit() async {
    videoStatistics =
        await HttpHelper().videoInfoById(videoId: video!.id!.videoId);

    youtubechannel = await HttpHelper()
        .channelInfoById(channelId: video!.snippet!.channelId);
  }

// get view and video image url
  String? get viewCountString =>
      "Views ${videoStatistics!.viewCount ?? 'كفايه انت تشوفه'}";

  String? get youtuberThumbnailUrl {
    if (youtubechannel!.snippetModel == null) {
      return "https://yt3.ggpht.com/ytc/AAUvwniE2k5PgFu9yr4sBVEs9jdpdILdMc7ruiPw59DpS0k=s88-c-k-c0x00ffffff-no-rj";
    }
    return youtubechannel!.snippetModel!.thumbnails!.meduimThumbnails!.url;
  }
}
