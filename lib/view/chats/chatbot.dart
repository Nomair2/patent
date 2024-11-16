import 'dart:convert';
import 'package:bubble/bubble.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ChatBot extends StatefulWidget {
  const ChatBot({super.key});

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  final List<String> _data = [];
  var chatUrl = Uri.parse("http://10.0.2.2:5000/chat");
  final TextEditingController _msgController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          title: Text(
            "22".tr,
            style: const TextStyle(color: Colors.black),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Image.asset("assets/images/logo.png"),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            AnimatedList(
                padding: const EdgeInsets.only(bottom: 80),
                key: _listKey,
                initialItemCount: _data.length,
                itemBuilder: (BuildContext context, int index,
                    Animation<double> animation) {
                  return _buildItem(_data[index], animation, index);
                }),
            Align(
                alignment: Alignment.bottomCenter,
                child: ColorFiltered(
                    colorFilter: const ColorFilter.linearToSrgbGamma(),
                    child: Container(
                        color: Colors.white,
                        child: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: TextField(
                                decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.send,
                                    color: Colors.blue[600],
                                  ),
                                  hintText: "23".tr,
                                  fillColor: Colors.white12,
                                ),
                                controller: _msgController,
                                textInputAction: TextInputAction.send,
                                onSubmitted: (msg) async {
                                  if (_msgController.text.isNotEmpty) {
                                    _insertSingleItem(
                                        _msgController.text.trim());
                                    sendMsg(_msgController.text.trim());
                                    _msgController.text = "";
                                  }
                                })))))
          ],
        ));
  }

  sendMsg(String msg) async {
    final client = http.Client();
    http.Response response = await client.post(chatUrl, body: {"msg": msg});
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      Map<String, dynamic> data = jsonDecode(response.body);
      _insertSingleItem(data['CHATBOT'] + "<bot>");
    } else {
      return "Error Code: ${response.statusCode.toString()}";
    }
  }

  void _insertSingleItem(String message) {
    _data.add(message);
    _listKey.currentState!.insertItem(_data.length - 1);
  }

  Widget _buildItem(String item, Animation<double> animation, int index) {
    bool mine = item.endsWith("<bot>");
    return SizeTransition(
        sizeFactor: animation,
        child: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Container(
              alignment: mine ? Alignment.topLeft : Alignment.topRight,
              child: Bubble(
                nip: mine ? BubbleNip.leftTop : BubbleNip.rightTop,
                color: mine ? Colors.blue[600] : Colors.blue[300],
                padding: const BubbleEdges.all(10),
                child: Text(item.replaceAll("<bot>", "")),
              )),
        ));
  }
}
