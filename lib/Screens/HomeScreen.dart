import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_gi/Screens/ChannelTopHeadlinWidget.dart';
import 'package:news_gi/Screens/DetailScreen.dart';
import '../Controllers/ChannelTopHeadlinesController.dart';
import '../Controllers/GeneralTopHeadlinesController.dart';
import '../GlobalWidget/DropDown.dart';
import 'NewsCatogoryScreen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  NewsChannelHeadlinesController NCHC =
      Get.put(NewsChannelHeadlinesController());
  GeneralTopHeadLinesController GTHC = Get.put(GeneralTopHeadLinesController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewsChannelHeadlinesController>(builder: (__) {
      if (__.newsChannelHeadlinesModel == null) {
        return const Scaffold(
          body: Center(
            child: SpinKitFadingCircle(
              color: Colors.black,
              size: 50,
            ),
          ),
        );
      } else {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Get.to(NewsCatogoryScreen());
              },
              icon: ImageIcon(
                AssetImage(
                  'assets/categoryicon.png',
                ),
                size: Get.height * .03,
              ),
            ),
            title: Text(
              "Latest News",
              style: GoogleFonts.domine(color: Colors.red),
            ),
            actions: [
              SizedBox(
                height: Get.height * .05,
                width: Get.width * .3,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * .02),
                  child: CustomDropdownFormField(
                    text: 'BBC News',
                    actionsList: __.chaneelNameList,
                    onChange: (val) {
                      __.newsChannelHeadlinesApi(val!);
                      __.update();
                    },
                  ),
                ),
              ),
            ],
          ),
          body: ListView(
            children: [
              __.isLoading
                  ? SizedBox(
                      height: Get.height * .4,
                      child: const SpinKitFadingCircle(
                        color: Colors.black,
                        size: 30,
                      ),
                    )
                  : const HomeScreenWidget1(),
              GetBuilder<GeneralTopHeadLinesController>(builder: (__) {
                if (__.generalTopHeadlinesList == null) {
                  return SizedBox(
                    height: Get.height / 2,
                    child: const SpinKitFadingCircle(
                      color: Colors.black,
                      size: 30,
                    ),
                  );
                } else {
                  return SizedBox(
                    height: Get.height / 2,
                    child: ListView(
                      children: [
                        Text(
                          '  Top Headlines',
                          style: GoogleFonts.playfair(
                              fontSize: 40, color: Colors.red),
                        ),
                        SizedBox(
                          height: Get.height / 2.5,
                          child: ListView.builder(
                              itemCount:
                                  __.generalTopHeadlinesList!.articles!.length,
                              itemBuilder: (context, index) {
                                var newsDdata = __
                                    .generalTopHeadlinesList!.articles![index];
                                DateTime formattedTime = DateTime.parse(
                                        newsDdata.publishedAt.toString())
                                    .toLocal();
                                DateFormat formatter = DateFormat('MMM d, y');
                                String formattedDateTime =
                                    formatter.format(formattedTime);
                                return ListTile(
                                  onTap: () {
                                    Get.to(
                                      DetaileScreen(
                                          imageUrl:
                                              newsDdata.urlToImage.toString(),
                                          url: newsDdata.url.toString(),
                                          description:
                                              newsDdata.description.toString(),
                                          title: newsDdata.title.toString(),
                                          channelname: newsDdata.source!.name
                                              .toString()),
                                    );
                                  },
                                  leading: Container(
                                    width: Get.width * .3,
                                    height: Get.height * .5,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            newsDdata.urlToImage.toString(),
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            Container(
                                          child: SpinKitThreeBounce(
                                            color: Colors.red,
                                            size: 20,
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Column(
                                          children: [
                                            Text(
                                              'Network Error...',
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.alegreya(
                                                  color: Colors.red),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    newsDdata.title.toString(),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  subtitle: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        newsDdata.source!.name
                                                    .toString()
                                                    .length <=
                                                10
                                            ? newsDdata.source!.name.toString()
                                            : '${newsDdata.source!.name.toString().substring(0, 10)}...',
                                        maxLines: 1,
                                        style: GoogleFonts.poppins(
                                            color: Colors.red),
                                      ),
                                      Text(formattedDateTime),
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  );
                }
              }),
            ],
          ),
        );
      }
    });
  }
}
