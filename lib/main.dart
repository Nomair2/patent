import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:patents/controller/owner_controller/myPatent_owner_controller.dart';
import 'package:patents/locale/locale.dart';
import 'package:patents/view/selectAccountScreen.dart';
import 'locale/localeController.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(
     );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MyLocalController());
    return GetMaterialApp(
      locale: Get.deviceLocale,
      translations: MyLocal(),
      debugShowCheckedModeBanner: false,
      home: const SelecetAccount(),
      initialBinding: BindingsBuilder(
        () => Get.lazyPut(
          () => MypatentOwnerController(),
          fenix: true,
        ),
      ),
    );
  }
}
