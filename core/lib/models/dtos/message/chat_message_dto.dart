import 'package:core/models/dtos/user/chat_user_dto.dart';

/// Data transfer object representing simple chat message.
class ChatMessageDto {
  /// Message author.
  final ChatUserDto author;

  /// Chat message string.
  final String message;

  /// Creation date and time.
  final DateTime createdDateTime;

  const ChatMessageDto({
    required this.author,
    required this.message,
    required this.createdDateTime,
  });

  @override
  String toString() =>
      'ChatMessageDto(author: $author, message: $message, createdDate: $createdDateTime)';
}
