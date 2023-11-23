import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:news_gi/Models/GeneralTopHeadlinesModel.dart';
import 'package:news_gi/Utils/Constants.dart';


class GeneralTopHeadLinesController extends GetxController {

  int initialIndex =0;
  bool isLoading = false;

  String initialCatogryName= 'General'.toLowerCase();

  List<String> categoryNameList = [
    'General',
    'Entertainment',
    'Sports',
    'Health',
    'Technology',
    'Science',
    'Business',
  ];


  @override
  void onInit() {
    super.onInit();
    newsCategoryApiCall(initialCatogryName);
  }

  GeneralTopHeadlinesModel? generalTopHeadlinesList;

  Future<void> newsCategoryApiCall(String catogoryUpdatename) async {
    isLoading= true;
    var url =
        "https://newsapi.org/v2/everything?q=${initialCatogryName.toLowerCase()}&apiKey=${Constants.apiKey}";
    final uri = Uri.parse(url);
    var response = await http.get(uri);
    var body = jsonDecode(response.body.toString());
    if (body["status"] == "ok".toLowerCase()) {
      generalTopHeadlinesList = GeneralTopHeadlinesModel.fromJson(body);
      isLoading=false;
      print("newsChannelHeadlinesModel");
      print("newsChannelHeadlinesModel");
      print("newsChannelHeadlinesModel");
      print(generalTopHeadlinesList);
      update();
    } else {
      throw Error();
    }
  }

}
