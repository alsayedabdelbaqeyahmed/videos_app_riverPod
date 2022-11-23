// ignore_for_file: use_rethrow_when_possible, avoid_print, unused_field, prefer_final_fields

import 'dart:html';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_payer/models/data_models/search_videos_model.dart';
import 'package:video_payer/models/http_helper/http_helper.dart';

class HomeController extends ChangeNotifier {
  /// fetch data from api wihh search method

  // list of search history
  List<String>? history = List.empty(growable: true);
  SharedPreferences? _profs;
  String key = "searchKey";
  String? searchKeyWord;

  SearchVideoModel? videos =
      SearchVideoModel(items: []); // to make sure the items is empty
  ScrollController _scrollController = ScrollController();

  void onInit() async {
    scrollFunction();

    _profs = await SharedPreferences.getInstance();
    List<dynamic>? initData = _profs!.getStringList(key);

    final data = initData!.map<String>(
      (e) {
        return e.toString();
      },
    ).toList();
    history!.addAll(data);
  }

  void homeScreenVideos({
    String? searchItem,
  }) async {
    // sve the data returned from the server at search
    try {
      SearchVideoModel? search = await HttpHelper().search(
          searchPageToken: videos!.nextPageToken ?? "", searchItem: searchItem);

      if (search.items != null && search.items!.isNotEmpty) {
        videos!.nextPageToken = search.nextPageToken;
        for (var i = 0; i < search.items!.length; i++) {
          videos!.items!.add(search.items![i]);
        }
      }
      notifyListeners();
    } catch (e) {
      print(e.toString());
      throw (e);
    }
  }

  // scroll function to scroll screen to find videos

  void scrollFunction() async {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        homeScreenVideos(searchItem: searchKeyWord);
      }
    });
  }

  void submitSearch(String searchKey) {
    if (!history!.contains(searchKey)) {
      history!.add(searchKey);
    }

    _profs!.setStringList(key, history!);
    searchKeyWord = searchKey;
    homeScreenVideos(searchItem: searchKey);
  }
}
