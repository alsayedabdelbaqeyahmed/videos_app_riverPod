import 'package:flutter/material.dart';
import 'package:video_payer/controller/vido_info_controller.dart';
import 'package:video_payer/models/data_models/search_videos_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../models/data_models/video_statics_model.dart';
import '../models/data_models/youtube_channel_model.dart';

class ChannelINfoController extends ChangeNotifier {
  ItemsModel videos = ItemsModel();
  VideoStatisticsModel? videoStatistics = VideoStatisticsModel();
  YoutubeChannelModel? youtubechannel = YoutubeChannelModel();
  YoutubePlayerController? youtubePlayerController;

  void init() async {
    VideoInfoController? videoController = VideoInfoController();

    videos = videoController.video!;
    videoStatistics = videoController.videoStatistics!;
    youtubechannel = videoController.youtubechannel;
    _event();
  }

  void _event() {
    youtubePlayerController = YoutubePlayerController(
      initialVideoId: videos.id!.videoId!,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    );
  }
}
