import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:posttrip/controller/home_controller.dart';
import 'package:posttrip/view/MyListTile.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      //  var data = homeController.jsonResult!.value;

      return Scaffold(
        body: (homeController.jsonResult == null)
            ? Center(child: Text(homeController.txt.value))
            : CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: Colors.transparent,
                    toolbarHeight: 20,
                    floating: false,
                    snap: false,

                    // title: Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [Icon(Icons.arrow_back), Icon(Icons.search)],
                    // ),
                    pinned: true,
                    expandedHeight: 300,
                    // flexibleSpace: FlexibleSpaceBar(
                    flexibleSpace: Stack(
                      children: [
                        Container(
                            height: 360,
                            width: MediaQuery.of(context).size.width,
                            child: ClipRRect(
                              // borderRadius: Bo,

                              borderRadius: BorderRadius.only(
                                  //  bottomRight: Radius.circular(12),
                                  bottomLeft: Radius.circular(18)),
                              child: CarouselSlider(
                                items: homeController.bannerImages.value.map(
                                  (i) {
                                    return Builder(
                                      builder: (BuildContext context) =>
                                          Image.network(
                                        i,
                                        fit: BoxFit.fill,
                                        height: 360,
                                        width:
                                            MediaQuery.of(context).size.width,
                                      ),
                                    );
                                  },
                                ).toList(),
                                options: CarouselOptions(
                                  onPageChanged: (index, reason) {
                                    homeController.SetCarouselIndex(index);

                                    // print(homeController.curind.value);
                                  },
                                  autoPlayInterval: Duration(seconds: 2),
                                  autoPlay: true,
                                  viewportFraction: 1,
                                  height: 360,
                                ),
                              ),
                            )),
                        // child: Image.network(data['bannerImages'][0],
                        //
                        Positioned(
                          bottom: 40,
                          left: 27,
                          child: CarouselIndicator(
                            width: 40,
                            count: 3,
                            index: homeController.curind.value,
                          ),
                        ),

                        Positioned(
                            bottom: 40,
                            left: 18,
                            child: Text(
                              homeController.jsonResult!.value['bannerTitle'],
                              style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 27,
                                      color: Colors.white)),
                            )),
                        Positioned(
                            left: 15,
                            top: 21,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 18,
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                              ),
                            )),
                        Positioned(
                            right: 15,
                            top: 21,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 18,
                              child: Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                            )),
                      ],
                      // ),
                    ),
                    // flexibleSpace: FlexibleSpaceBar(
                    //     background: ClipRRect(
                    //   borderRadius: const BorderRadius.only(
                    //     bottomLeft: Radius.circular(20.0),
                    //     bottomRight: Radius.circular(20.0),
                    //   ),
                    //   child: Image.network(
                    //     data['bannerImages'][0],
                    //     width: double.infinity,
                    //     fit: BoxFit.fill,
                    //   ),
                    // )),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RatingBar.builder(
                              initialRating: 4,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Color.fromARGB(255, 250, 208, 82),
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 18, top: 27),
                            child: Text(
                              homeController.jsonResult!.value["description"],
                              style: GoogleFonts.roboto(
                                  fontSize: 21, fontWeight: FontWeight.w300),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 18, top: 9, right: 9),
                            child: Text(
                              "•   " +
                                  homeController.jsonResult!.value["details"]
                                      [0],
                              style: GoogleFonts.roboto(fontSize: 19),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 18, right: 9),
                            child: Text(
                              "•   " +
                                  homeController.jsonResult!.value["details"]
                                      [1],
                              style: GoogleFonts.roboto(
                                  fontSize: 19), //(fontSize: 12),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 18),
                            child: Text(
                              "•   " +
                                  homeController.jsonResult!.value["details"]
                                      [2],
                              style: GoogleFonts.roboto(
                                  fontSize: 21, fontWeight: FontWeight.w400),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 18, top: 27, bottom: 12),
                            child: Text(
                              "Popular Treks",
                              style: GoogleFonts.robotoSlab(
                                  fontSize: 36, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                MyListTile(
                                    name: homeController.jsonResult!
                                        .value['popularTreks'][0]["title"],
                                    rating: "4",
                                    imagePath: homeController.jsonResult!
                                        .value['popularTreks'][0]["thumbnail"]),
                                MyListTile(
                                    name: homeController.jsonResult!
                                        .value['popularTreks'][1]["title"],
                                    rating: "4",
                                    imagePath: homeController.jsonResult!
                                        .value['popularTreks'][1]["thumbnail"]),
                                MyListTile(
                                    name: homeController.jsonResult!
                                        .value['popularTreks'][2]["title"],
                                    rating: "4",
                                    imagePath: homeController.jsonResult!
                                        .value['popularTreks'][2]["thumbnail"]),
                                MyListTile(
                                    name: homeController.jsonResult!
                                        .value['popularTreks'][3]["title"],
                                    rating: "4",
                                    imagePath: homeController.jsonResult!
                                        .value['popularTreks'][3]["thumbnail"]),
                                MyListTile(
                                    name: homeController.jsonResult!
                                        .value['popularTreks'][4]["title"],
                                    rating: "4",
                                    imagePath: homeController.jsonResult!
                                        .value['popularTreks'][4]["thumbnail"]),
                                MyListTile(
                                    name: homeController.jsonResult!
                                        .value['popularTreks'][5]["title"],
                                    rating: "4",
                                    imagePath: homeController.jsonResult!
                                        .value['popularTreks'][5]["thumbnail"]),
                                MyListTile(
                                    name: homeController.jsonResult!
                                        .value['popularTreks'][6]["title"],
                                    rating: "4",
                                    imagePath: homeController.jsonResult!
                                        .value['popularTreks'][6]["thumbnail"]),
                                MyListTile(
                                    name: homeController.jsonResult!
                                        .value['popularTreks'][7]["title"],
                                    rating: "4",
                                    imagePath: homeController.jsonResult!
                                        .value['popularTreks'][7]["thumbnail"]),
                                MyListTile(
                                    name: homeController.jsonResult!
                                        .value['popularTreks'][8]["title"],
                                    rating: "4",
                                    imagePath: homeController.jsonResult!
                                        .value['popularTreks'][8]["thumbnail"]),
                                MyListTile(
                                    name: homeController.jsonResult!
                                        .value['popularTreks'][9]["title"],
                                    rating: "4",
                                    imagePath: homeController.jsonResult!
                                        .value['popularTreks'][9]["thumbnail"]),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 200,
                          ),
                        ]),
                  ),

                  // ListView.builder(
                  // scrollDirection: Axis.horizontal,
                  // itemCount:
                  //     10, //data.value["popularTreks"].length,
                  // itemBuilder: (cnt, pos) {
                  //   // print(data.value["popularTreks"].length);
                  //   return Text("data");
                  //   // return MyListTile(
                  //   //   name: data["popularTreks"][pos]['title'],
                  //   //   imagePath: data["popularTreks"][pos]['thumbnail'],
                  //   //   rating: "4",
                  //   // );
                  // }),
                ],
              ),
      );
    });
  }
}
