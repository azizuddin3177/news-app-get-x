import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';

class DetaileScreen extends StatelessWidget {
  final String imageUrl, url, description, title, channelname;
  const DetaileScreen({
    super.key,
    required this.imageUrl,
    required this.url,
    required this.description,
    required this.title,
    required this.channelname,
  });




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          channelname,
          style: GoogleFonts.rhodiumLibre(color: Colors.black),
        ),
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.red,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Colors.white,
            expandedHeight: Get.height * .4,
            flexibleSpace: FlexibleSpaceBar(
              background: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                height: double.infinity,
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
                      size: 50,
                    ),
                    Text("No Image found !")
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              child: Column(
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SelectableText(
                        title,
                        maxLines: 3,
                        style: GoogleFonts.rhodiumLibre(
                            color: Colors.blue, fontSize: 20),
                      ),
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(
                      horizontal: Get.width * .05
                    ),
                    child: SelectableText(
                      description,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * .05,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
