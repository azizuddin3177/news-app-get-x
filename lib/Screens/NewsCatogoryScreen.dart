import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_gi/Controllers/NewsCategoryController.dart';
import 'package:news_gi/Screens/DetailScreen.dart';

class NewsCatogoryScreen extends StatelessWidget {
  NewsCatogoryScreen({super.key});

  NewsCategoryController newsCategoryController =
      Get.put(NewsCategoryController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewsCategoryController>(builder: (__) {
      if (__.newsCategoryModelList == null) {
        return const Scaffold(
          body: SpinKitFadingCircle(
            color: Colors.black,
            size: 30,
          ),
        );
      } else {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Icons.arrow_back_ios)),
          ),
          body: ListView(
            children: [
              SizedBox(
                height: Get.height * .05,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: __.categoryNameList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: InkWell(
                          onTap: () {
                            __.initialCatogryName = __.categoryNameList[index];
                            __.initialIndex = index;
                            __.newsCategoryApiCall(__.initialCatogryName);
                            __.update();
                          },
                          child: Container(
                            height: Get.width * .05,
                            padding: EdgeInsets.symmetric(
                                horizontal: Get.width * .05),
                            decoration: BoxDecoration(
                                color: __.initialIndex == index
                                    ? Colors.blue
                                    : Colors.grey,
                                borderRadius: BorderRadius.circular(10)),
                            child:
                                Center(child: Text(__.categoryNameList[index])),
                          ),
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: Get.height * .8,
                child: __.isLoading
                    ? const Center(
                        child: SpinKitFadingCircle(
                          color: Colors.black,
                          size: 30,
                        ),
                      )
                    : ListView.builder(
                        itemCount: __.newsCategoryModelList!.articles!.length,
                        itemBuilder: (context, index) {
                          var newsDdata =
                              __.newsCategoryModelList!.articles![index];
                          DateTime formattedTime =
                              DateTime.parse(newsDdata.publishedAt.toString())
                                  .toLocal();
                          DateFormat formatter = DateFormat('MMM d, y');
                          String formattedDateTime =
                              formatter.format(formattedTime);
                          return ListTile(
                            onTap: () {
                              Get.to(
                                DetaileScreen(
                                    imageUrl: newsDdata.urlToImage.toString(),
                                    url: newsDdata.url.toString(),
                                    description:
                                        newsDdata.description.toString(),
                                    title: newsDdata.title.toString(),
                                    channelname:
                                        newsDdata.source!.name.toString()),
                              );
                            },
                            leading: Container(
                              width: Get.width * .3,
                              height: Get.height * .5,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: CachedNetworkImage(
                                  imageUrl: newsDdata.urlToImage.toString(),
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Container(
                                    child: SpinKitThreeBounce(
                                      color: Colors.red,
                                      size: 20,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) => Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.error,
                                        size: 30,
                                      ),
                                      Text("Network Error !",style: GoogleFonts.rhodiumLibre(
                                        color: Colors.red
                                      ),)
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
                            ),
                          );
                        }),
              ),
            ],
          ),
        );
      }
    });
  }
}
