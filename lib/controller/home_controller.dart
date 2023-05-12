import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxMap<String, dynamic>? jsonResult;
  var curind = 0.obs;
  var txt = "data loading".obs;
  var bannerImages = ["sa", "sad", "asd"].obs;
  @override
  void onInit() {
    // TODO: implement onInit
    fetchdata();
    super.onInit();
  }

  SetCarouselIndex(int index) {
    curind.value = index;
  }

  void fetchdata() async {
    String data = await rootBundle.loadString('assets/data.json');
    var data1 = json.decode(data) as Map<String, dynamic>;
    //jsonResult = data1.obs;
    jsonResult = data1.obs;
    print(jsonResult!.value);
    bannerImages.value[0] = jsonResult!.value['bannerImages'][0];
    bannerImages.value[1] = jsonResult!.value['bannerImages'][1];
    bannerImages.value[2] = jsonResult!.value['bannerImages'][2];
    txt.value = "";
    // print(bannerImages.value[0]);
    update();
  }
}
