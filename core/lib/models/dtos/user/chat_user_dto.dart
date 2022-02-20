/// Basic model representing chat user.
class ChatUserDto {
  final String name;

  const ChatUserDto({
    required this.name,
  });

  @override
  String toString() => 'ChatUserDto(name: $name)';
}
