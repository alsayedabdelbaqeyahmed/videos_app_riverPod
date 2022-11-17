import 'package:flutter/material.dart';
import 'package:video_payer/models/constants/string_constant.dart';

class DefaultModels {
  String? url;
  int? width, hight;
  DefaultModels({this.hight, this.url, this.width});

  Map<String, dynamic> toJson() {
    return {
      AppStringConstants.url: url,
      AppStringConstants.hight: hight,
      AppStringConstants.width: width,
    };
  }

  factory DefaultModels.fromJson(Map<String, dynamic> json) {
    return DefaultModels(
      url: json[AppStringConstants.url],
      hight: json[AppStringConstants.hight],
      width: json[AppStringConstants.width],
    );
  }
}

class ThumbnailsModels {
  DefaultModels? defaultThumbnails;
  DefaultModels? meduimThumbnails;
  DefaultModels? heightThumbnails;
  ThumbnailsModels(
      {this.defaultThumbnails, this.heightThumbnails, this.meduimThumbnails});

  Map<String, dynamic> toJosn() {
    return {
      AppStringConstants.defaultThumbnails: defaultThumbnails,
      AppStringConstants.hight: heightThumbnails,
      AppStringConstants.meduim: meduimThumbnails,
    };
  }

  factory ThumbnailsModels.fromJson(Map<String, dynamic> json) {
    return ThumbnailsModels(
      defaultThumbnails:
          DefaultModels.fromJson(json[AppStringConstants.defaultThumbnails]),
      meduimThumbnails: DefaultModels.fromJson(json[AppStringConstants.meduim]),
      heightThumbnails: DefaultModels.fromJson(json[AppStringConstants.hight]),
    );
  }
}

class SnipperModels {
  String? channelId, title, description, channelTitle, liveBroadcastContent;

  DateTime? publishedAt, publishTime;
  ThumbnailsModels? thumbnails;
  SnipperModels({
    this.channelId,
    this.channelTitle,
    this.description,
    this.liveBroadcastContent,
    this.publishTime,
    this.publishedAt,
    this.thumbnails,
    this.title,
  });
  Map<String, dynamic> toJosn() {
    return {
      AppStringConstants.channelId: channelId,
      AppStringConstants.channelTitle: channelTitle,
      AppStringConstants.description: description,
      AppStringConstants.liveBroadcastContent: liveBroadcastContent,
      AppStringConstants.publishTime: publishTime,
      AppStringConstants.publishedAt: publishedAt,
      AppStringConstants.title: title,
      AppStringConstants.thumbnails: thumbnails,
    };
  }

  factory SnipperModels.fromJson(Map<String, dynamic> map) {
    return SnipperModels(
      channelId: map[AppStringConstants.channelId],
      publishTime: map[AppStringConstants.publishTime],
      publishedAt: map[AppStringConstants.publishedAt],
      title: map[AppStringConstants.title],
      thumbnails: ThumbnailsModels.fromJson(map[AppStringConstants.thumbnails]),
      liveBroadcastContent: map[AppStringConstants.liveBroadcastContent],
      description: map[AppStringConstants.description],
      channelTitle: map[AppStringConstants.channelTitle],
    );
  }
}

class IdModel {
  String? videoId, kind;
  IdModel({this.kind, this.videoId});

  Map<String, dynamic> toJosn() {
    return {AppStringConstants.videoId: videoId, AppStringConstants.kind: kind};
  }

  factory IdModel.fromJson(Map<String, dynamic> json) {
    return IdModel(
      kind: json[AppStringConstants.kind],
      videoId: json[AppStringConstants.videoId],
    );
  }
}

class ItemsModel {
  String? etag, kind;
  IdModel? id;
  SnipperModels? snippet;

  ItemsModel({this.etag, this.id, this.kind, this.snippet});
  Map<String, dynamic> toJosn() {
    return {
      AppStringConstants.id: id,
      AppStringConstants.etag: etag,
      AppStringConstants.kind: kind,
      AppStringConstants.snippet: snippet,
    };
  }

  factory ItemsModel.fromJson(Map<String, dynamic> map) {
    return ItemsModel(
      kind: map[AppStringConstants.kind],
      etag: map[AppStringConstants.etag],
      id: IdModel.fromJson(map[AppStringConstants.id]),
      snippet: SnipperModels.fromJson(
        map[AppStringConstants.snippet],
      ),
    );
  }
}

class PageInfoModel {
  int? resultsPerPage, totalResults;
  PageInfoModel({this.resultsPerPage, this.totalResults});

  Map<String, dynamic> toJosn() {
    return {
      AppStringConstants.resultsPerPage: resultsPerPage,
      AppStringConstants.totalResults: totalResults,
    };
  }

  factory PageInfoModel.fromJson(Map<String, dynamic> map) {
    return PageInfoModel(
      resultsPerPage: map[AppStringConstants.resultsPerPage],
      totalResults: map[AppStringConstants.totalResults],
    );
  }
}

class VideoPlayerModel {
  String? nextPageToken, regionCode, kind, etag;
  PageInfoModel? pageInfo;
  List<ItemsModel>? items;

  VideoPlayerModel({
    this.etag,
    this.items,
    this.kind,
    this.nextPageToken,
    this.pageInfo,
    this.regionCode,
  });
  Map<String, dynamic> toJosn() {
    return {
      AppStringConstants.etag: etag,
      AppStringConstants.items: List<dynamic>.from(
        items!.map(
          (e) => e.toJosn(),
        ),
      ),
      AppStringConstants.kind: kind,
      AppStringConstants.nextPageToken: nextPageToken,
      AppStringConstants.pageInfo: pageInfo,
      AppStringConstants.regionCode: regionCode,
    };
  }

  factory VideoPlayerModel.fromJson(Map<String, dynamic> map) {
    return VideoPlayerModel(
      items: List<ItemsModel>.from(
        map[AppStringConstants.items].map(
          (element) => ItemsModel.fromJson(element),
        ),
      ),
      pageInfo: PageInfoModel.fromJson(map[AppStringConstants.pageInfo]),
      etag: map[AppStringConstants.etag],
      kind: map[AppStringConstants.kind],
      nextPageToken: map[AppStringConstants.nextPageToken],
      regionCode: map[AppStringConstants.regionCode],
    );
  }
}
