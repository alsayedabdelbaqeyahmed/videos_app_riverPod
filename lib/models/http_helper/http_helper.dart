// ignore_for_file: use_rethrow_when_possible, avoid_print, unnecessary_null_comparison

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:video_payer/models/constants/api_constants.dart';
import 'package:video_payer/models/constants/string_constant.dart';
import 'package:video_payer/models/data_models/search_videos_model.dart';
import 'package:video_payer/models/data_models/video_statics_model.dart';
import 'package:video_payer/models/data_models/youtube_channel_model.dart';

class HttpHelper {
  /// search function to search about videos
  Future<SearchVideoModel> search(
      {String? searchPageToken, String? searchItem}) async {
    SearchVideoModel? searchResult;
    // search url and remove all spaces from search q at api
    String? qWithoutSpaces = searchItem!.replaceAll(RegExp(r" "), "");

    final searchUrl =
        "${ApiConstants.baseApi}/youtube/v3/search?part=snippet&maxResults=1000&pageToken=$searchPageToken&q=$qWithoutSpaces&key=${ApiConstants.apiKey}&order=date&type=videos";
    final client = http.Client();
    final responce = await client.get(
      Uri.https(searchUrl),
    );
    try {
      /// is the responce is ok and
      /// if the items list  at responce is not empty and contain items
      if (responce.statusCode == 200) {
        final searchResponce =
            SearchVideoModel.fromJson(jsonDecode(responce.body));

        if (searchResponce.items!.isNotEmpty && searchResponce.items != null) {
          searchResult = searchResponce;
        } else {
          print(responce.body);
        }
      } else {
        Future.error(responce.statusCode);
      }
      return searchResult!;
    } catch (e) {
      Future.error(responce.statusCode);
      print(e.toString());
      throw (e);
    }
  }

  // load define channel
  Future<YoutubeChannelModel> channelInfoById({String? channelId}) async {
    YoutubeChannelModel? channelResult;
    // channel url

    final channelUrl =
        "${ApiConstants.baseApi}/youtube/v3/channels?part=statistics&part=snippet&id=$channelId&key=${ApiConstants.apiKey}";
    final client = http.Client();
    final responce = await client.get(
      Uri.https(channelUrl),
    );
    try {
      /// is the responce is ok and
      /// if the items list  at responce is not empty and contain items
      /// find the items insinde items list and send to  YoutubeChannelModel.fromJson
      if (responce.statusCode == 200) {
        List<Map<String, dynamic>>? items =
            jsonDecode(responce.body)[AppStringConstants.items];
        // send statistics and snippet of channel
        if (items!.isNotEmpty && items != null) {
          channelResult = YoutubeChannelModel.fromJson(items[0]);
        } else {
          print(responce.body);
        }
      } else {
        Future.error(responce.statusCode);
      }
      return channelResult!;
    } catch (e) {
      Future.error(responce.statusCode);
      print(e.toString());
      throw (e);
    }
  }

  // video info
  Future<VideoStatisticsModel> videoInfoById({String? videoId}) async {
    VideoStatisticsModel? videosResult;
    // channel url

    final videoUrl =
        "${ApiConstants.baseApi}/youtube/v3/videos?key=${ApiConstants.apiKey}&part=statistics&id=$videoId";
    final client = http.Client();
    final responce = await client.get(
      Uri.https(videoUrl),
    );
    try {
      /// is the responce is ok and
      /// if the items list  at responce is not empty and contain items
      /// find the items insinde items list and send to  YoutubeChannelModel.fromJson
      if (responce.statusCode == 200) {
        List<Map<String, dynamic>>? items =
            jsonDecode(responce.body)[AppStringConstants.items];

        if (items!.isNotEmpty && items != null) {
          ///  // go to element 0 at items list and send statistics key
          videosResult = VideoStatisticsModel.fromJson(
              items[0][AppStringConstants.statistics]);
        } else {
          print(responce.body);
        }
      } else {
        Future.error(responce.statusCode);
      }
      return videosResult!;
    } catch (e) {
      Future.error(responce.statusCode);
      print(e.toString());
      throw (e);
    }
  }
}
