import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patents/view/chats/chatGpt.dart';
import 'package:patents/view/chats/chatbot.dart';
import '../../theme.dart';

class ChatScreenInvestor extends StatefulWidget {
  const ChatScreenInvestor({super.key});

  @override
  State<ChatScreenInvestor> createState() => _ChatScreenInvestorState();
}

class _ChatScreenInvestorState extends State<ChatScreenInvestor> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        backgroundColor: ThemeColor.background,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: ThemeColor.primary,
          title: ZoomIn(
            delay: const Duration(milliseconds: 150),
            child: Text('26'.tr,
                style: TextStyle(color: ThemeColor.white, fontSize: 23)),
          ),
          toolbarHeight: 100,
          automaticallyImplyLeading: false,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25)),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              ZoomIn(
                delay: const Duration(milliseconds: 200),
                child: TabBar(
                    labelColor: ThemeColor.primary,
                    unselectedLabelColor: ThemeColor.black.withOpacity(0.5),
                    indicatorColor: ThemeColor.primary,
                    labelStyle: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                    dividerColor: ThemeColor.black.withOpacity(0.2),
                    tabs: [
                      InkWell(
                        // onTap: _goToMessageTab,
                        child: Tab(
                          child: Text("27".tr),
                        ),
                      ),
                      Tab(
                        child: Text("28".tr),
                      ),
                    ]),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      FadeInDown(
                          delay: const Duration(milliseconds: 300),
                          child: const ChatBot()),
                      FadeInDown(
                          delay: const Duration(milliseconds: 300),
                          child: const Chatgpt()),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
