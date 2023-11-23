import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:news_gi/Utils/Constants.dart';
import '../../Models/NewsChannelHeadlinesModel.dart';


class NewsChannelHeadlinesController extends GetxController {
  String initialChannel = 'bbc-news'.toLowerCase();

  bool isLoading= false;


  List<String> chaneelNameList=[
    'BBC-News',
    'ARY-News',
    'Al-Jazeera-English',
    'CNN',
  ];
  @override
  void onInit() {
    super.onInit();
    newsChannelHeadlinesApi(initialChannel);
  }

  NewsChannelHeadlinesModel? newsChannelHeadlinesModel;
  NewsChannelHeadlinesModel? topHeadlinesModelList;

  Future<void> newsChannelHeadlinesApi(String channelName) async {
    isLoading=true;
    var url =
        "https://newsapi.org/v2/top-headlines?sources=${channelName.toLowerCase()}&apiKey=${Constants.apiKey}";
    final uri = Uri.parse(url);
    var response = await http.get(uri);
    var body = jsonDecode(response.body.toString());
    if (body["status"] == "ok".toLowerCase()) {
      newsChannelHeadlinesModel = NewsChannelHeadlinesModel.fromJson(body);
      print("newsChannelHeadlinesModel");
      print(newsChannelHeadlinesModel);
      isLoading=false;
      update();
    } else {
      isLoading=false;
      Get.snackbar(body['status'].toString().toUpperCase(), body['message']);

      // Timer(Duration(seconds: 3), () {
      //   SystemNavigator.pop();
      // });
    }
  }

}
