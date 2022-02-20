import 'dart:developer';

import 'package:core/models/dtos/message/chat_message_dto.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surf_practice_chat_flutter/config/app_configuration.dart';
import 'package:surf_practice_chat_flutter/extensions/string_extensions.dart';
import 'package:surf_practice_chat_flutter/presentation/viewmodels/main_view_model.dart';
import 'package:surf_practice_chat_flutter/presentation/widgets/list_items/chat_message_widget.dart';
import 'package:surf_practice_chat_flutter/presentation/widgets/not_network_connection_widget.dart';
import 'package:surf_practice_chat_flutter/resources/strings.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _username = TextEditingController(text: "Иван Иванов");
  final _message = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Column(
          children: [_appBar(), _body(), _inputMessage()],
        ),
      ),
    );
  }

  Widget _messages(List<ChatMessageDto> items) {
    if (items.isEmpty) {
      var title = _setText(Strings.message_list_is_empty);
      return Expanded(
        child: Center(
          child: Text(
            title,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      );
    }
    var appConfig = context.read<AppConfiguration>();
    if (!appConfig.hasInternetConnection) {
      return const NotNetworkConnectionWidget();
    }

    return Expanded(
      child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            final model = items[index];
            return ChatMessageWidget(
              model: model,
            );
          }),
    );
  }

  Widget _appBar() {
    var textStyle =
        Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.white70);
    return Container(
      color: Theme.of(context).appBarTheme.backgroundColor,
      child: Row(
        children: [
          Expanded(
            child: TextField(
                controller: _username,
                style: textStyle,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: textStyle,
                  hintText: _setText(Strings.hint_login),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: IconButton(
                onPressed: _loadData,
                icon: const Icon(
                  Icons.refresh,
                  color: Colors.white,
                )),
          )
        ],
      ),
    );
  }

  Widget _progress() {
    return const Expanded(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  String _setText(String key) {
    return key.getName(context, key) ?? "";
  }

  void _loadData() async {
    var model = context.read<MainViewModel>();
    await model.updateChatListAsync();
  }

  Widget _body() {
    var model = context.watch<MainViewModel>();
    return model.inProgress() ? _progress() : _messages(model.getItems());
  }

  Widget _inputMessage() {
    var textStyle = Theme.of(context).textTheme.bodyText1;
    var primary = Theme.of(context).colorScheme.primary;
    var model = context.watch<MainViewModel>();
    return Card(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: IconButton(
                onPressed: _loadData,
                icon: Icon(
                  Icons.share_location_outlined,
                  color: primary,
                )),
          ),
          Expanded(
            child: TextField(
                controller: _message,
                style: textStyle,
                decoration: InputDecoration(
                  //border: InputBorder.none,
                  hintStyle: textStyle,
                  hintText: _setText(Strings.hint_message),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: model.sendMessageInProgress()
                ? _progress()
                : IconButton(
                    onPressed: _onSendMessagePressed,
                    icon: Icon(
                      Icons.send,
                      color: Colors.black,
                    )),
          )
        ],
      ),
    );
  }

  void _onSendMessagePressed() async {
    var user = _username.text.toString().trim();
    var message = _message.text.toString().trim();
    log("message $message");
    log("user $user");
    if (user.isNotEmpty && message.isNotEmpty) {
      var model = context.read<MainViewModel>();
      await model.sendMessage(user, message);
      _message.clear();
    }
  }
}
