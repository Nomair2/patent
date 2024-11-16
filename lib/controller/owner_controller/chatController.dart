import 'dart:io';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart'; // Android-specific WebView
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart'; // iOS-specific WebView

class ChatController extends GetxController {
  late final WebViewController controller;

  @override
  void onInit() {
    super.onInit();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(
        Uri.parse("https://WWW.chatgpt.com/"),
      );
  }
}
