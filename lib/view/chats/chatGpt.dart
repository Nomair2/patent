import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patents/controller/owner_controller/chatController.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Chatgpt extends StatelessWidget {
  const Chatgpt({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ChatController());
    return Scaffold(
        body: GetBuilder<ChatController>(
      builder: (controller) => WebViewWidget(
        controller: controller.controller,
        gestureRecognizers: Set()
          ..add(Factory<VerticalDragGestureRecognizer>(
              () => VerticalDragGestureRecognizer())),
      ),
    ));
  }
}
