import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_gi/Controllers/ChannelTopHeadlinesController.dart';
import 'package:news_gi/Screens/DetailScreen.dart';

class HomeScreenWidget1 extends StatelessWidget {
  const HomeScreenWidget1({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewsChannelHeadlinesController>(builder: (__) {
      return SizedBox(
        height: Get.height * .4,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: __.newsChannelHeadlinesModel!.articles!.length,
            itemBuilder: (context, index) {
              var newsDdata = __.newsChannelHeadlinesModel!.articles![index];
              DateTime formattedTime =
                  DateTime.parse(newsDdata.publishedAt.toString()).toLocal();
              DateFormat formatter = DateFormat('MMM d, y');
              String formattedDateTime = formatter.format(formattedTime);
              return InkWell(
                onTap: () {
                  print(newsDdata.author.toString(),);
                  Get.to(
                    DetaileScreen(
                      imageUrl: newsDdata.urlToImage.toString(),
                      url: newsDdata.url.toString(),
                      description: newsDdata.description.toString(),
                      title: newsDdata.title.toString(),
                      channelname: newsDdata.source!.name.toString(),
                    ),
                  );
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: Get.height * .02),
                      width: Get.width * .7,
                      height: Get.height * .6,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: newsDdata.urlToImage.toString(),
                          placeholder: (context, url) => Container(
                              child: Column(
                            children: [
                              SizedBox(
                                height: Get.height * .02,
                              ),
                              SpinKitThreeBounce(
                                color: Colors.red,
                                size: 25,
                              ),
                            ],
                          )),
                          errorWidget: (context, url, error) => Column(
                            children: [
                              SizedBox(height: Get.height * .05),
                              Text(
                                'Network Error\nWhile Loading...',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.alegreya(color: Colors.red),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 30,
                      right: 30,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.all(10),
                        height: Get.height * .2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              newsDdata.title.toString(),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.allerta(
                                  fontWeight: FontWeight.w700),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  newsDdata.source!.name.toString().length <= 10
                                      ? newsDdata.source!.name.toString()
                                      : '${newsDdata.source!.name.toString().substring(0, 10)}...',
                                  maxLines: 1,
                                  style: GoogleFonts.poppins(color: Colors.red),
                                ),
                                Text(formattedDateTime),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            }),
      );
    });
  }
}
