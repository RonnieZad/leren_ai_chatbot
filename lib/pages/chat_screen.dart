//  LEREN DIGITAL HUMAN
//
//  Created by Ronald Zad Muhanguzi.
//  2021, All rights reserved.
//

//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

import 'dart:convert';
import 'dart:ui';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show HapticFeedback;
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:leren_ai_bot_app/constants/strings.dart';
import 'package:leren_ai_bot_app/models/reply_model.dart';
import 'package:leren_ai_bot_app/models/sent_model.dart';
import 'package:leren_ai_bot_app/pages/menu/info_screen.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<types.Message> _messages = [];
  final _user = const types.User(id: '06c33e8b-e835-4736-80f4-63f44b66666c');
  bool isOnline = true;

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  void _addMessage(types.Message message) async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    setState(() {
      _messages.insert(0, message);
    });

    prefs.setString('chathistory',
        _messages.map((e) => json.encode(e.toJson())).toList().toString());
  }

  void _handleMessageTap(types.Message message) async {
    if (message is types.FileMessage) {
      await OpenFile.open(message.uri);
    }
  }

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final index = _messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = _messages[index].copyWith(previewData: previewData);

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      setState(() {
        _messages[index] = updatedMessage;
      });
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );
    _networkReply(
        message.text, "Zad", DateTime.now().millisecondsSinceEpoch.toString());
    setState(() {});
    _addMessage(textMessage);
  }

  void _loadMessages() async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    final messages =
        (jsonDecode(prefs.getString('chathistory') ?? jsonEncode(msgTemplate))
                as List)
            .map((e) => types.Message.fromJson(e as Map<String, dynamic>))
            .toList();

    setState(() {
      _messages = messages;
    });
  }

  _networkReply(String message, String sender, String time) async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    Sent sentMessage = Sent(sender, message);
    var _jsonMessage = jsonEncode(sentMessage);
    var webhook = prefs.getString('webhook') ?? '9cfa-41-75-187-141';
    Map<String, String> requestHeaders = {'Content-type': 'application/json'};

    try {
      var response = await http.post(
          Uri.parse('https://$webhook.ngrok.io/webhooks/rest/webhook'),
          body: _jsonMessage,
          headers: requestHeaders);
      var statusCode = response.statusCode;

      if (statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        var parsedResponse = ReplyArray.fromJson(jsonResponse);

        var list = parsedResponse.replies;

        final messages = list
            .map(
              (e) => types.TextMessage(
                author: const types.User(
                  id: "b4878b96-efbc-479a-8291-474ef323dec7",
                ),
                id: e.recipientId,
                text: e.text,
              ),
            )
            .toList();

        setState(() {
          for (int i = 0; i <= messages.length - 1; i++) {
            _messages.insert(0, messages[i]);
          }
          //To do> append bot message to list and then persist
        });
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
      // show that bot is offline
    }
  }

  @override
  Widget build(BuildContext context) {
    var prefs = Provider.of<SharedPreferences?>(context);
    var chatBg = prefs?.getString('setBg') ??
        'assets/images/${backgrounds[3]['image']!}';

    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            chatBg,
            width: double.infinity,
            fit: BoxFit.cover,
            height: double.infinity,
          ),
          Chat(
            messages: _messages,
            theme: const DefaultChatTheme(
                dateDividerTextStyle:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                primaryColor: Color.fromRGBO(89, 169, 240, 1),
                backgroundColor: Colors.transparent,
                messageBorderRadius: 23.0,
                inputBackgroundColor: Color.fromRGBO(39, 39, 58, 1),
                inputBorderRadius:
                    BorderRadius.vertical(top: Radius.circular(25.0))),
            onMessageTap: _handleMessageTap,
            onPreviewDataFetched: _handlePreviewDataFetched,
            onSendPressed: _handleSendPressed,
            user: _user,
            showUserNames: true,
          ),
          ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
              child: Container(
                height: 120.0,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.black45,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, top: 30.0, right: 20.0),
                  child: Row(
                    children: [
                      BouncingWidget(
                        onPressed: () {
                          Navigator.pop(context);
                          HapticFeedback.selectionClick();
                        },
                        child: Container(
                          color: Colors.transparent,
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(7.0),
                                child: SvgPicture.asset(
                                    'assets/images/fi-rr-angle-small-left.svg',
                                    color: Colors.white),
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              const Text(
                                'Back',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              )
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      BouncingWidget(
                        onPressed: () {
                          HapticFeedback.selectionClick();
                          _modalBuilder(context);
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            const CircleAvatar(
                              radius: 22.0,
                              backgroundImage:
                                  AssetImage('assets/images/leren.webp'),
                            ),
                            Positioned(
                              left: .0,
                              top: 0.0,
                              child: Container(
                                width: 13.0,
                                height: 13.0,
                                decoration: BoxDecoration(
                                    color: isOnline
                                        ? Colors.blue[600]
                                        : Colors.red[600],
                                    shape: BoxShape.circle),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static _modalBuilder(BuildContext context) {
    // SharedPreferences? preference =
    //     Provider.of<SharedPreferences?>(context, listen: false);

    showDialog(
        context: context,
        barrierColor: Colors.transparent,
        builder: (ctx) {
          return Padding(
            padding: EdgeInsets.only(top: 30.h, right: 55.w),
            child: Align(
              alignment: Alignment.topRight,
              child: SizedBox(
                width: 230.w,
                child: CupertinoPopupSurface(
                  isSurfacePainted: true,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          TextButton.icon(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Info(),
                                  ),
                                );
                              },
                              icon: SizedBox(
                                  width: 18.0,
                                  height: 18.0,
                                  child: SvgPicture.asset(
                                      'assets/images/fi-rr-info.svg')),
                              label: const Text('Info')),
                        ],
                      ),
                      Row(
                        children: [
                          TextButton.icon(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Info(),
                                  ),
                                );
                              },
                              icon: SizedBox(
                                  width: 18.0,
                                  height: 18.0,
                                  child: SvgPicture.asset(
                                      'assets/images/fi-rr-info.svg')),
                              label: const Text('Export Chat')),
                        ],
                      ),
                      Row(
                        children: [
                          TextButton.icon(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Info(),
                                  ),
                                );
                              },
                              icon: SizedBox(
                                  width: 18.0,
                                  height: 18.0,
                                  child: SvgPicture.asset(
                                      'assets/images/fi-rr-info.svg')),
                              label: const Text('Clear Chat History')),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
