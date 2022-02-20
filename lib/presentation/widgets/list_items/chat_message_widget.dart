import 'package:core/models/dtos/message/chat_message_dto.dart';
import 'package:flutter/material.dart';
import 'package:surf_practice_chat_flutter/extensions/string_extensions.dart';

class ChatMessageWidget extends StatefulWidget {
  final ChatMessageDto model;

  const ChatMessageWidget({Key? key, required this.model}) : super(key: key);

  @override
  _ChatMessageWidgetState createState() => _ChatMessageWidgetState();
}

class _ChatMessageWidgetState extends State<ChatMessageWidget> {
  @override
  Widget build(BuildContext context) {
    final item = widget.model;
    var _theme = Theme.of(context);
    return ListTile(
      leading: CircleAvatar(
        //child: Icon(Icons.person),
        child: Text(
          item.author.name.characters.first.toUpperCase(),
          style: _theme.textTheme.headline5?.copyWith(color: Colors.white),
        ),
        radius: 30,
      ),
      title: Text(
        item.author.name,
        style: _theme.textTheme.headline5,
      ),
      subtitle: Text(
        "${item.message}\n${item.createdDateTime.toString().toDateFormat()} ",
        style: _theme.textTheme.bodyText1,
      ),
    );
  }
}
