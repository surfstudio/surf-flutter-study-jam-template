import 'package:flutter/material.dart';
import 'package:surf_practice_chat_flutter/extensions/string_extensions.dart';
import 'package:surf_practice_chat_flutter/resources/strings.dart';

class NotNetworkConnectionWidget extends StatefulWidget {
  const NotNetworkConnectionWidget({Key? key}) : super(key: key);

  @override
  _NotNetworkConnectionWidgetState createState() =>
      _NotNetworkConnectionWidgetState();
}

class _NotNetworkConnectionWidgetState
    extends State<NotNetworkConnectionWidget> {
  @override
  Widget build(BuildContext context) {
    var message = _setText(Strings.error_internet_connection_failed);
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.wifi_off,
            size: 200,
          ),
          Text(
            message,
            style: Theme.of(context).textTheme.bodyText2,
          )
        ],
      ),
    );
  }

  String _setText(String key) {
    return key.getName(context, key) ?? "";
  }
}
