import 'dart:ui';

import 'package:get/get.dart';

class MyLocalController extends GetxController{
  void changeLanguage(String codeLang){
    Locale locale = Locale(codeLang);
    Get.updateLocale(locale);
  }
}