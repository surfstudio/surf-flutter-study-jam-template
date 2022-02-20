import 'package:core/models/dtos/geolocation.dart';
import 'package:core/models/dtos/message/chat_message_dto.dart';
import 'package:core/models/dtos/user/chat_user_dto.dart';

/// Data transfer object representing geolocation chat message.
class ChatMessageGeolocationDto extends ChatMessageDto {
  /// Location point.
  final ChatGeolocationDto location;

  ChatMessageGeolocationDto({
    required ChatUserDto author,
    required this.location,
    required String message,
    required DateTime createdDate,
  }) : super(author: author, message: message, createdDateTime: createdDate);

  @override
  String toString() =>
      'ChatMessageGeolocationDto(location: $location) extends ${super.toString()}';
}
