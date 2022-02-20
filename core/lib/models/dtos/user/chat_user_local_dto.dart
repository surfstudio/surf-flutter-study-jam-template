import 'chat_user_dto.dart';

/// Model representing local user.
///
/// As rule as user with the same nickname was entered when sending a message
/// from this device.
class ChatUserLocalDto extends ChatUserDto {
  ChatUserLocalDto({
    required String name,
  }) : super(name: name);

  @override
  String toString() => 'ChatUserLocalDto(name: $name)';
}